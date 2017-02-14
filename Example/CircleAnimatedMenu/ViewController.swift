//
//  ViewController.swift
//  CircleAnimatedMenu
//
//  Created by Alexandr Honcharenko on 02/02/2017.
//  Copyright (c) 2017 Alexandr Honcharenko. All rights reserved.
//

import UIKit
import CircleAnimatedMenu


class ViewController: UIViewController {

    @IBOutlet weak var testMenu: CircleAnimatedMenu!
    
    override func viewDidLoad() {
        
        testMenu.imageSize = 40
        testMenu.outerRadius = 150
        testMenu.innerRadius = 50
        testMenu.closerBorderWidth = 0
        testMenu.menuWidthLine = 1
        testMenu.delegate = self
        //testMenu.highlightedColors = [.green, .yellow, .purple, .red, .brown]

        testMenu.dataTuple = [("facebook", "Facebook"), ("insta", "Instagram"), ("twit", "Twitter"),
                              ("link", "LinkedIn"), ("googlePlus", "GooglePlus"), ("github", "GitHub")];
    }

}

extension ViewController: CircleAnimatedMenuDelegate {
    func sectionSelected(text: String, index: Int) {
        print("text - \(text), index - \(index)")
    }
}
