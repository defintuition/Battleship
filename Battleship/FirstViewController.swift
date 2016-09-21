//
//  FirstViewController.swift
//  Battleship
//
//  Created by Jason Gresh on 9/16/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var buttonContainer: UIView!
    
    let totalButtons: Int
    var loaded: Bool
    var game1 = Battleship()
    var arrayOfShipIndexes = [[Int]]()
    
    
    required init?(coder aDecoder: NSCoder) {
        self.totalButtons = 100
        self.loaded = false
        //  self.brain = MontyBrain(numCards: self.howManyCards)
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        if !loaded {
            setUpGameButtons(v: buttonContainer, totalButtons: self.totalButtons, buttonsPerRow: 10)
            self.view.setNeedsDisplay()
        }
        loaded = true
    }
    
    
    // MARK: Functions
    
    func disableShipButtons() {
        for v in buttonContainer.subviews {
            if let button = v as? UIButton {
                button.isEnabled = false
            }
        }
    }
    
    // sets location in 2D-array to .hit
    func buttonTapped(sender: UIButton){
        if sender.tag - 1 < 10 {
            if game1.buttons[0][sender.tag-1] == .hit {
                sender.backgroundColor = UIColor.black
            }
        }
        else {
            for i in 1..<10 {
                if game1.buttons[i][(sender.tag-1) % 10] == .hit {
                    sender.backgroundColor = UIColor.black
                } else {
                    sender.backgroundColor = UIColor.brown
                }
                
            }
        }
        /*
         switch sender.tag {
         case 1...10:
         if game1.buttons[0][sender.tag-1] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 11...20:
         if game1.buttons[1][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         //print(game1.buttons[1][(sender.tag-1) % 10])
         } else {
         sender.backgroundColor = UIColor.brown
         }
         print(game1.buttons[1][2])
         case 21...30:
         if game1.buttons[2][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 31...40:
         if game1.buttons[3][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 41...50:
         if game1.buttons[4][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 51...60:
         if game1.buttons[5][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 61...70:
         if game1.buttons[6][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 71...80:
         if game1.buttons[7][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 81...90:
         if game1.buttons[8][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         case 91...100:
         if game1.buttons[9][(sender.tag-1) % 10] == .hit {
         sender.backgroundColor = UIColor.black
         } else {
         sender.backgroundColor = UIColor.brown
         }
         
         default:
         break
         */
        
        sender.isEnabled = false
    }
    
    
    func setUpGameButtons(v: UIView, totalButtons: Int, buttonsPerRow : Int) {
        for i in 1...100 {
            let y = ((i - 1) / buttonsPerRow)
            let x = ((i - 1) % buttonsPerRow)
            let side : CGFloat = v.bounds.size.width / CGFloat(buttonsPerRow)
            
            let rect = CGRect(origin: CGPoint(x: side * CGFloat(x), y: (CGFloat(y) * side)), size: CGSize(width: side, height: side))
            let button = UIButton(frame: rect)
            button.tag = i
            button.backgroundColor = UIColor.blue
            button.setTitle(String(i), for: UIControlState())
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            v.addSubview(button)
            
        }
        createThreeButtonShip()
        createFiveButtonShip()
        print(arrayOfShipIndexes)
        
    }
    
    func createThreeButtonShip() {
        let randomRow = Int(arc4random_uniform(UInt32(9)))
        let randomCol = Int(arc4random_uniform(UInt32(9)))
        game1.buttons[randomRow][randomCol] = .hit
        //print("\(randomRow),\(randomCol)")
        
        
        let orientation = "horiz"
        if orientation == orientation {
            arrayOfShipIndexes.append([randomRow,randomCol])
            if randomRow + 3 >= 10 {
                for i in 1..<3 {
                    game1.buttons[randomRow - i][randomCol] = .hit
                    print(randomRow - i,randomCol)
                    arrayOfShipIndexes.append([randomRow - i, randomCol])
                    //print(arrayOfShipIndexes)
                }
            } else {
                for i in 1..<3 {
                    game1.buttons[randomRow + i][randomCol] = .hit
                    print(randomRow + i,randomCol)
                    arrayOfShipIndexes.append([randomRow + i, randomCol])
                    //  print(arrayOfShipIndexes)
                }
            }
            // print(arrayOfShipIndexes)
        }
    }
    
    func createFiveButtonShip() {
        let randomRow = Int(arc4random_uniform(UInt32(9)))
        let randomCol = Int(arc4random_uniform(UInt32(9)))
        game1.buttons[randomRow][randomCol] = .hit
        print("\(randomRow),\(randomCol)")
        
        let orientation = "horiz"
        if orientation == orientation {
            arrayOfShipIndexes.append([randomRow,randomCol])
            if randomRow + 5 >= 10 {
                for i in 1..<5 {
                    game1.buttons[randomRow - i][randomCol] = .hit
                    print(randomRow - i,randomCol)
                    arrayOfShipIndexes.append([randomRow - i, randomCol])
                    
                }
            } else {
                for i in 1..<5 {
                    game1.buttons[randomRow + i][randomCol] = .hit
                    print(randomRow + i,randomCol)
                    arrayOfShipIndexes.append([randomRow + i, randomCol])
                }
            }
            //print(arrayOfShipIndexes)
        }
    }
}
