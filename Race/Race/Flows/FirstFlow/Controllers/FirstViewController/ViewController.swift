//
//  ViewController.swift
//  Race
//
//  Created by macbook m1 on 4.10.22.
//

import Foundation
import UIKit

extension UIButton {
    
    func drawShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 10
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 15
    }
    
    func cornerRadius(radius: Int) {
        self.layer.cornerRadius = CGFloat(radius)
        self.clipsToBounds = true
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var openSecondViewScreen: (()->Void)?
    var openThreeViewScreen: (()->Void)?
    var openTableViewScreen: (()->Void)?
    

  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        button.setTitle(NSLocalizedString("Game", comment: ""), for: .highlighted)
        button2.setTitle(NSLocalizedString("Settings", comment: ""), for: .highlighted)
        button3.setTitle(NSLocalizedString("Table", comment: ""), for: .highlighted)
        
        
        for family in UIFont.familyNames.sorted(){
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
        
        
        let string = NSLocalizedString("Title", comment: "")
        
        let shadow = NSShadow()
        shadow.shadowBlurRadius = 3
        shadow.shadowColor = UIColor.gray
        shadow.shadowOffset = CGSize(width: 3, height: 3)
    
        let attributed: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "BalsamiqSans-BoldItalic", size: 50), NSAttributedString.Key.shadow: shadow ]
        
        let attrString = NSAttributedString(string: string, attributes: attributed)
        label.attributedText = attrString

        button.drawShadow()
        button.cornerRadius(radius: 10)
        
        button2.drawShadow()
        button2.cornerRadius(radius: 10)
        
        button3.drawShadow()
        button3.cornerRadius(radius: 10)
    }
   
    @IBAction func didTapNextScreen() {

        openSecondViewScreen?()

    }
    
    @IBAction func didTapThreeScreen() {
       
        openThreeViewScreen?()
    }
    
    @IBAction func didTapTableRecords() {
       
        openTableViewScreen?()
    }
}

