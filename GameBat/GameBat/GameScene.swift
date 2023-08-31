//
//  GameScene.swift
//  GameBat
//
//  Created by macbook m1 on 31.05.23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Helpers
    var animation = AnimationClass()
    
    //MARK: - Variables
    var sound = true
    var gameViewController: GameViewController!
    var gameOver = 0
    var gameSceneBg: SelectBg!
    
    //MARK: - Lable Node
    var scoreLabel = SKLabelNode()
    var doublingLable = SKLabelNode()
    var recordLable = SKLabelNode()
    
    // MARK: -Texture
    var backgroundTex: SKTexture!
    var batTexture: SKTexture!
    var coinTexture: SKTexture!
    var bigCoinTexture: SKTexture!
    var coinAnimTexture: SKTexture!
    var bigCoinAnimTexture: SKTexture!
    var rapTexture: SKTexture!
    var lifeTexture: SKTexture!

    //MARK: - Sprite Nodes
    var background = SKSpriteNode()
    var background2 = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    var bat = SKSpriteNode()
    var coin = SKSpriteNode()
    var bigCoin = SKSpriteNode()
    var rap = SKSpriteNode()
    var lifeNode1 = SKSpriteNode()
    var lifeNode2 = SKSpriteNode()
    var lifeNode3 = SKSpriteNode()
    var blure = SKSpriteNode()
    
    //MARK: - Sprite Objects
    var backgroundObj = SKNode()
    var groundObj = SKNode()
    var movingObj = SKNode()
    var batObj = SKNode()
    var coinObj = SKNode()
    var bigCoinObj = SKNode()
    var scoreObj = SKNode()
    var doublingLableObj = SKNode()
    var lifeObj1 = SKNode()
    var lifeObj2 = SKNode()
    var lifeObj3 = SKNode()
    
    //MARK: - Bit Masks
    var batCategory: UInt32 = 0x1 << 1
    var groundCategory: UInt32 = 0x1 << 2
    var coinCategory: UInt32 = 0x1 << 3
    var bigCoinCategory: UInt32 = 0x1 << 4
    var rapCategory: UInt32 = 0x1 << 5
    
    //MARK: - Array texture for animation
    var coinTextureArray = [SKTexture]()
    var rapTextureArray = [SKTexture]()
    var batTextureArray = [SKTexture]()
    
    //MARK: - Timers
    var timerAddCoin = Timer()
    var timerAddBigCoin = Timer()
    var timerAddRap = Timer()
    
    //MARK: - Sounds
    var takeCoinPreload = SKAction()
    var bumpPreload = SKAction()
    
    //MARK: - Actions
    var moveRapY = SKAction()
    
    override func didMove(to view: SKView) {
        //Bat texture
        batTexture = SKTexture(imageNamed: "bat0")
        
        //Coin texture
        coinTexture = SKTexture(imageNamed: "coin")
        bigCoinTexture = SKTexture(imageNamed: "coin")
        coinAnimTexture = SKTexture(imageNamed: "Coin0")
        bigCoinAnimTexture = SKTexture(imageNamed: "Coin0")
        
        //Rap texture
        rapTexture = SKTexture(imageNamed: "rap1")
        
        //Life texture
        lifeTexture = SKTexture(imageNamed: "life1")
        
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1)
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        
        if UserDefaults.standard.object(forKey: "record") != nil {
            Model.sharedInstance.record = UserDefaults.standard.object(forKey: "record") as! Int
            recordLable.text = "Your record: \(Model.sharedInstance.record)"
        }
        
        if UserDefaults.standard.object(forKey: "totalPoint") != nil {
            Model.sharedInstance.totalScore = UserDefaults.standard.object(forKey: "totalPoint") as! Int
        }
        
        if gameOver == 0 {
            createGame()
        }
        
        takeCoinPreload = SKAction.playSoundFileNamed("takeCoin.mp3", waitForCompletion: false)
        bumpPreload = SKAction.playSoundFileNamed("soundR1.mp3", waitForCompletion: false)
    }
    
    func createObjects() {
        self.addChild(backgroundObj)
        self.addChild(groundObj)
        self.addChild(movingObj)
        self.addChild(batObj)
        self.addChild(coinObj)
        self.addChild(bigCoinObj)
        self.addChild(scoreObj)
        self.addChild(doublingLableObj)
        self.addChild(lifeObj1)
        self.addChild(lifeObj2)
        self.addChild(lifeObj3)
    }
    
    func createGame() {
        setupBackground()
        createGround()
        createSky()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.setupBat()
            self.setupTimer()
            self.setupScoreLable()
            self.setupBatLifes()
        }
        gameViewController.replayButton.isHidden = true
        gameViewController.menuButton.isHidden = true
        gameViewController.gameOverLabel.isHidden = true
        recordLable.isHidden = true
    }
    
    func setupBatLifes() {
        lifeNode1 = SKSpriteNode(texture: lifeTexture)
        lifeNode1.position = CGPoint(x: UIScreen.main.bounds.width / 2 - 200 , y: UIScreen.main.bounds.height - 280)
        lifeNode1.zPosition = 5
        lifeNode1.setScale(0.5)
        lifeObj1.addChild(lifeNode1)
        
        lifeNode2 = SKSpriteNode(texture: lifeTexture)
        lifeNode2.position = CGPoint(x: UIScreen.main.bounds.width / 2 - 170 , y: UIScreen.main.bounds.height - 280)
        lifeNode2.zPosition = 5
        lifeNode2.setScale(0.5)
        lifeObj2.addChild(lifeNode2)
        
        lifeNode3 = SKSpriteNode(texture: lifeTexture)
        lifeNode3.position = CGPoint(x: UIScreen.main.bounds.width / 2 - 140 , y: UIScreen.main.bounds.height - 280)
        lifeNode3.zPosition = 5
        lifeNode3.setScale(0.5)
        lifeObj3.addChild(lifeNode3)
    }
    
    func setupDoublingLable() {
        doublingLable = SKLabelNode(text: "x2")
        doublingLable.fontName = "AmericanTypewriter-Bold"
        doublingLable.fontSize = 20
        doublingLable.fontColor = .white
        doublingLable.position = CGPoint(x: bigCoin.position.x, y: bigCoin.position.y)
        doublingLable.zPosition = 5
        
        doublingLableObj.addChild(doublingLable)
    }
    
    func setupScoreLable() {
        scoreLabel = SKLabelNode(text: "Score: 0")
        scoreLabel.fontName = "AmericanTypewriter-Bold"
        scoreLabel.fontSize = 26
        scoreLabel.fontColor = .white
        scoreLabel.position = CGPoint(x: UIScreen.main.bounds.width / 2 - 670 , y: UIScreen.main.bounds.height - 280)
        scoreLabel.zPosition = 5
        Model.sharedInstance.score = 0
    
        scoreObj.addChild(scoreLabel)
    }
    
    func showRecordLable() {
        recordLable = SKLabelNode(text: "Your record: 0")
        recordLable.fontName = "AmericanTypewriter-Bold"
        recordLable.fontSize = 20
        recordLable.fontColor = .white
        recordLable.zPosition = 5
        recordLable.position = CGPoint(x: 0 , y: self.frame.maxY / 2 - 320)
        
        self.addChild(recordLable)
    }
    
    func blureBg() {
        blure = SKSpriteNode(color: .black, size: CGSize(width: background.size.width, height: background.size.height))
        blure.alpha = 0.4
        blure.zPosition = 2
        
        self.addChild(blure)
    }
    
    func setupBackground() {
        switch gameSceneBg.rawValue {
        case 0:
            backgroundTex = SKTexture(imageNamed: "back")
        case 1:
            backgroundTex = SKTexture(imageNamed: "unlockGameBg4")
        case 2:
            backgroundTex = SKTexture(imageNamed: "unlockGameBg3")
        case 3:
            backgroundTex = SKTexture(imageNamed: "unlockGameBg2")
        default:
            break
        }
        
        background = SKSpriteNode(texture: backgroundTex)
        background.position = CGPoint(x: 0, y: 0)
        background.zPosition = -1
        background.size = CGSize(width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        
        backgroundObj.addChild(background)
        
        background2 = SKSpriteNode(texture: backgroundTex)
        background2.position = CGPointMake(background.size.width , 0)
        background2.zPosition = -1
        background2.size = CGSize(width: (self.view?.bounds.width)!, height: (self.view?.bounds.height)!)
        
        backgroundObj.addChild(background2)
    }
    
    func createGround() {
        ground = SKSpriteNode()
        ground.position = CGPoint(x: 0, y: self.frame.minY)
        ground.zPosition = 3
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height - 340))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = groundCategory
        
        groundObj.addChild(ground)
    }
    
    func createSky() {
        sky = SKSpriteNode()
        sky.position = CGPoint(x: 0, y: self.frame.maxY)
        sky.zPosition = 3
        sky.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height - 340))
        sky.physicsBody?.isDynamic = false
        
        movingObj.addChild(sky)
    }
    
    func setupBat() {
        bat = SKSpriteNode(texture: batTexture)
        
        batTextureArray = [SKTexture(imageNamed: "bat0"), SKTexture(imageNamed: "bat1"), SKTexture(imageNamed: "bat2"), SKTexture(imageNamed: "bat3.1"), SKTexture(imageNamed: "bat4.1"), SKTexture(imageNamed: "bat5.1"), SKTexture(imageNamed: "bat0"), SKTexture(imageNamed: "bat1"), SKTexture(imageNamed: "bat2"), SKTexture(imageNamed: "bat3.1"), SKTexture(imageNamed: "bat4.1"), SKTexture(imageNamed: "bat5.1"), SKTexture(imageNamed: "bat0"), SKTexture(imageNamed: "bat1"), SKTexture(imageNamed: "bat2"), SKTexture(imageNamed: "bat3"), SKTexture(imageNamed: "bat4"), SKTexture(imageNamed: "bat5")]
        
        let batAnimation = SKAction.animate(with: batTextureArray, timePerFrame: 0.1)
        let batAction = SKAction.repeatForever(batAnimation)
        bat.run(batAction)
        
        bat.position = CGPoint(x: -200, y: -30)
        bat.size = CGSize(width: 100, height: 100)
        bat.setScale(1.3)
        bat.zPosition = 3
        
        bat.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bat.size.width - 50, height: bat.size.height - 50))
        bat.physicsBody?.isDynamic = true
        bat.physicsBody?.mass = 0.1
        bat.physicsBody?.categoryBitMask = batCategory
        bat.physicsBody?.contactTestBitMask = groundCategory | coinCategory | bigCoinCategory | rapCategory
        bat.physicsBody?.collisionBitMask = groundCategory
        
        batObj.addChild(bat)
    }
    
    @objc func addCoin() {
        coin = SKSpriteNode(texture: coinTexture)
        
        coinTextureArray = [SKTexture(imageNamed: "Coin0"),SKTexture(imageNamed: "Coin1"), SKTexture(imageNamed: "Coin2"), SKTexture(imageNamed: "Coin3")]
        
        let coinAnimation = SKAction.animate(with: coinTextureArray, timePerFrame: 0.1)
        let coinAction = SKAction.repeatForever(coinAnimation)
        coin.run(coinAction)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let randomPosition = CGFloat(movementAmount) - self.frame.size.height / 4
        
        coin.size = CGSize(width: 40, height: 40)
        coin.position = CGPoint(x: self.size.width + randomPosition, y: 0 + coinTexture.size().height + 90 + randomPosition)
        coin.zPosition = 3
        coin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: coin.size.width - 20, height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinCategory
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        coin.run(coinMoveForever)
        
        coinObj.addChild(coin)
    }
    
    @objc func addBigCoin() {
        bigCoin = SKSpriteNode(texture: bigCoinTexture)
        
        coinTextureArray = [SKTexture(imageNamed: "Coin0"),SKTexture(imageNamed: "Coin1"), SKTexture(imageNamed: "Coin2"), SKTexture(imageNamed: "Coin3")]
        
        let bigCoinAnimation = SKAction.animate(with: coinTextureArray, timePerFrame: 0.1)
        let bigCoinAction = SKAction.repeatForever(bigCoinAnimation)
        bigCoin.run(bigCoinAction)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let randomPosition = CGFloat(movementAmount) - self.frame.size.height / 4
        
        bigCoin.size = CGSize(width: 40, height: 40)
        bigCoin.setScale(1.3)
        bigCoin.position = CGPoint(x: self.size.width + 50, y: 0 + bigCoinTexture.size().height + 90 + randomPosition)
        bigCoin.zPosition = 3
        bigCoin.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bigCoin.size.width - 10, height: bigCoin.size.height - 10))
        bigCoin.physicsBody?.restitution = 0
        bigCoin.physicsBody?.isDynamic = false
        bigCoin.physicsBody?.categoryBitMask = bigCoinCategory
        
        let moveCoin = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveForever = SKAction.repeatForever(SKAction.sequence([moveCoin, removeAction]))
        bigCoin.run(coinMoveForever)
        
        animation.scaleZdirection(sprite: bigCoin)
        animation.coinColorAnimation(sprite: bigCoin, animDuration: 0.5)
        
        bigCoinObj.addChild(bigCoin)
    }
    
  @objc func addRap() {
        rap = SKSpriteNode(texture: rapTexture)
        rapTextureArray = [SKTexture(imageNamed: "rap1")]
        
        let rapAnimation = SKAction.animate(with: rapTextureArray, timePerFrame: 0.1)
        let rapAction = SKAction.repeatForever(rapAnimation)
        rap.run(rapAction)
        
        let randomPosition = arc4random() % 2
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 4)
        let pipeOffset = self.frame.size.height / 4 + 20 - CGFloat(movementAmount)
    
        if randomPosition == 0 {
            rap.position = CGPoint(x: self.size.width + 50, y: background.size.height / 2 + 10 + pipeOffset)
            rap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rap.size.width - 30, height: rap.size.height - 20))
        } else {
            rap.position = CGPoint(x: self.size.width + 50, y: background.size.height / 2 - 10  - pipeOffset)
            rap.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rap.size.width - 30, height: rap.size.height - 20))
        }

        //Rotate
        rap.run(SKAction.repeatForever(SKAction.sequence([SKAction.run({
            self.rap.run(SKAction.rotate(byAngle: CGFloat(M_PI * 2), duration: 0.5))
        }), SKAction.wait(forDuration: 20.0)])))
        
        //Move
        let moveRap = SKAction.moveBy(x: -self.frame.size.width * 2, y: 0, duration: 6)
        rap.run(moveRap)
        
        //Scale
      var scaleValue: CGFloat = 0.5
      
      let scaleRandom = arc4random() % UInt32(5)
      if scaleRandom == 1 {
          scaleValue = 0.55
      } else if scaleRandom == 2 {
          scaleValue = 0.5
      } else if scaleRandom == 3 {
          scaleValue = 0.6
      } else if scaleRandom == 4 {
          scaleValue = 0.4
      } else if scaleRandom == 0 {
          scaleValue = 0.35
      }
      rap.setScale(scaleValue)
      
      let movementRandom = arc4random() % 3
      if movementRandom == 0 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 + 220, duration: 4)
      } else if movementRandom == 1 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 - 220, duration: 5)
      } else if movementRandom == 2 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 - 150, duration: 4)
      } else if movementRandom == 3 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 + 150, duration: 5)
      } else if movementRandom == 4 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 + 50, duration: 4)
      } else if movementRandom == 5 {
          moveRapY = SKAction.moveTo(y: background.size.height / 2 - 50, duration: 5)
      } else {
          moveRapY = SKAction.moveTo(y: background.size.height / 2, duration: 4)
      }
      
      rap.run(moveRapY)
        
        rap.physicsBody?.restitution = 0
        rap.physicsBody?.isDynamic = false
        rap.physicsBody?.categoryBitMask = rapCategory
        rap.zPosition = 3
        
        movingObj.addChild(rap)
    }
    
    func setupTimer() {
        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddRap.invalidate()
        
        timerAddCoin = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(addCoin), userInfo: nil, repeats: true)
        timerAddBigCoin = Timer.scheduledTimer(timeInterval: 8.246, target: self, selector: #selector(addBigCoin), userInfo: nil, repeats: true)
        timerAddRap = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addRap), userInfo: nil, repeats: true)
    }
    
    func stopGameObject() {
        coinObj.speed = 0
        bigCoinObj.speed = 0
        movingObj.speed = 0
        batObj.speed = 0
    }
    
    func replayGame() {
        coinObj.removeAllChildren()
        bigCoinObj.removeAllChildren()
        movingObj.removeAllChildren()
        batObj.removeAllChildren()
        gameOver = 0
        
        scene?.isPaused = false
        
        coinObj.speed = 1
        bigCoinObj.speed = 1
        batObj.speed = 1
        movingObj.speed = 1
        self.speed = 1
        
        if scoreObj.children.count != 0 {
            scoreObj.removeAllChildren()
        }
        
        createGround()
        createSky()
        setupBat()
        setupBatLifes()
        setupScoreLable()
        recordLable.isHidden = true
        showRecordLable()
        
        lifeObj1.isHidden = false
        lifeObj2.isHidden = false
        lifeObj3.isHidden = false
        blure.isHidden = true

        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddRap.invalidate()
        
        setupTimer()
    }
    
    func removeAll() {
        Model.sharedInstance.score = 0
        scoreLabel.text = "0"
        
        gameOver = 0
        
        timerAddCoin.invalidate()
        timerAddBigCoin.invalidate()
        timerAddRap.invalidate()
        
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
        self.view?.removeFromSuperview()
        
        gameViewController = nil
    }
    
    func moveBackground() {
        background.position = CGPoint(x: background.position.x - 3, y: 0)
        background2.position = CGPoint(x: background2.position.x - 3, y: 0)
        
        if background.position.x < -background.size.width {
            background.position = CGPointMake(background2.position.x + background2.size.width, 0)
        }
        
        if background2.position.x < -background2.size.width {
            background2.position = CGPointMake(background.position.x + background.size.width, 0)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        moveBackground()
    }
}
