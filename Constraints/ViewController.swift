//
//  ViewController.swift
//  Constraints
//
//  Created by Simon Elhoej Steinmejer on 29/08/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    var toggled = false
    
    lazy var lambdaLogoImageView: UIImageView =
    {
        let iv = UIImageView(frame: CGRect(x: (view.frame.width / 2) - 50, y: 110, width: 100, height: 100))
        iv.image = #imageLiteral(resourceName: "logo")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        
        return iv
    }()
    
    lazy var lLabel: UILabel =
    {
        let label = UILabel(frame: CGRect(x: (view.frame.width / 2) - 60, y: (view.frame.height / 2) - 10, width: 20, height: 20))
        label.text = "L"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.tag = 1
        return label
    }()
    
    lazy var aLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: (view.frame.width / 2) - 40, y: (view.frame.height / 2) - 10, width: 20, height: 20))
            label.text = "A"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.tag = 2
            return label
    }()
    
    lazy var mLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: (view.frame.width / 2) - 20, y: (view.frame.height / 2) - 10, width: 20, height: 20))
            label.text = "M"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.tag = 3
            return label
    }()
    
    lazy var bLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: (view.frame.width / 2), y: (view.frame.height / 2) - 10, width: 20, height: 20))
            label.text = "B"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.tag = 4
            return label
    }()
    
    lazy var dLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: (view.frame.width / 2) + 20, y: (view.frame.height / 2) - 10, width: 20, height: 20))
            label.text = "D"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.tag = 5
            return label
    }()
    
    lazy var aaLabel: UILabel =
        {
            let label = UILabel(frame: CGRect(x: (view.frame.width / 2) + 40, y: (view.frame.height / 2) - 10, width: 20, height: 20))
            label.text = "A"
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.textAlignment = .center
            label.tag = 6
            return label
    }()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(lambdaLogoImageView)
        view.addSubview(lLabel)
        view.addSubview(aLabel)
        view.addSubview(mLabel)
        view.addSubview(bLabel)
        view.addSubview(dLabel)
        view.addSubview(aaLabel)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Toggle", style: .plain, target: self, action: #selector(handleToggle))
    }
    
    let colorArray = [UIColor.green, UIColor.blue, UIColor.red, UIColor.yellow, UIColor.purple, UIColor.orange, UIColor.gray, UIColor.brown, UIColor.cyan, UIColor.magenta]
    
    @objc private func handleToggle()
    {
        let labelArray = [lLabel, aLabel, mLabel, bLabel, dLabel, aaLabel]
        
        if !toggled
        {
            for label in labelArray
            {
                let rotationValue = CGFloat(generateRandomNumber(min: 1, max: 4))
                let backgroundColor = self.colorArray[self.generateRandomNumber(min: 0, max: 9)]
                var textColor: UIColor
                repeat {
                    textColor = self.colorArray[self.generateRandomNumber(min: 0, max: 9)]
                } while backgroundColor == textColor
                
                UIView.animate(withDuration: 2) {
                    self.lambdaLogoImageView.alpha = 0
                    label.frame.origin.x = CGFloat(self.generateRandomNumber(min: 0, max: Int(self.view.frame.maxX) - 20))
                    label.frame.origin.y = CGFloat(self.generateRandomNumber(min: 80, max: Int(self.view.frame.maxY) - 20))
                    label.layer.backgroundColor = backgroundColor.cgColor
                    label.textColor = textColor
                    label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / rotationValue)
//                    print(label.frame)
                }
            }
            
            toggled = true
        }
        else
        {
            for label in labelArray
            {
                UIView.animate(withDuration: 2) {
                    
                    self.lambdaLogoImageView.alpha = 1
                    label.transform = .identity
                    label.frame = self.getOriginalFrame(label.tag)
                    label.textColor = .black
                    label.layer.backgroundColor = UIColor.clear.cgColor
                }
            }
            
            toggled = false
        }
    }
    
    func getOriginalFrame(_ tag: Int) -> CGRect
    {
        switch tag {
        case 1:
            return CGRect(x: (view.frame.width / 2) - 60, y: (view.frame.height / 2) - 10, width: 20, height: 20)
        case 2:
            return CGRect(x: (view.frame.width / 2) - 40, y: (view.frame.height / 2) - 10, width: 20, height: 20)
        case 3:
            return CGRect(x: (view.frame.width / 2) - 20, y: (view.frame.height / 2) - 10, width: 20, height: 20)
        case 4:
            return CGRect(x: (view.frame.width / 2), y: (view.frame.height / 2) - 10, width: 20, height: 20)
        case 5:
            return CGRect(x: (view.frame.width / 2) + 20, y: (view.frame.height / 2) - 10, width: 20, height: 20)
        case 6:
            return CGRect(x: (view.frame.width / 2) + 40, y: (view.frame.height / 2) - 10, width: 20, height: 20)
        default:
            return CGRect(x: 0, y: 0, width: 20, height: 20)
        }
    }
    
    func generateRandomNumber(min: Int, max: Int) -> Int
    {
        return Int(arc4random_uniform(UInt32(max) - UInt32(min)) + UInt32(min))
    }
}















