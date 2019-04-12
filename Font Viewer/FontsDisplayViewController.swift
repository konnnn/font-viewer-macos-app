//
//  FontsDisplayViewController.swift
//  Font Viewer
//
//  Created by Evgeny Konkin on 12.04.2019.
//  Copyright © 2019 Evgeny Konkin. All rights reserved.
//

import Cocoa

class FontsDisplayViewController: NSViewController {
    
    @IBOutlet weak var fontsTextView: NSTextView!
    
    var fontFamily: String?
    var fontFamilyMembers = [[Any]]()
    
    @IBAction func closeWindow(_ sender: Any) {
        view.window?.close()
    }
    
    func setupTextView() {
        fontsTextView.backgroundColor = NSColor(white: 1, alpha: 0)
        fontsTextView.isEditable = false
        fontsTextView.enclosingScrollView?.backgroundColor = NSColor(white: 1, alpha: 0)
        fontsTextView.enclosingScrollView?.autohidesScrollers = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
    }
    
    override func viewWillAppear() {
        showFonts()
    }
    
    func showFonts() {
        guard let fontFamily = fontFamily else { return }
        
        var fontPostscriptNames = ""
        var lenghts = [Int]()
        
        for member in fontFamilyMembers {
            if let postscript = member[0] as? String {
                fontPostscriptNames += "\(postscript)\n"
                lenghts.append(postscript.count)
            }
        }
        
        let attributedString = NSMutableAttributedString(string: fontPostscriptNames)
        
        for (index, member) in fontFamilyMembers.enumerated() {
            if let weight = member[2] as? Int, let traits = member[3] as? UInt {
                
                if let font = NSFontManager.shared.font(withFamily: fontFamily, traits: NSFontTraitMask(rawValue: traits), weight: weight, size: 34) {
                    
                    var location = 0
                    if index > 0 {
                        for i in 0..<index {
                            location += lenghts[i] + 1
                        }
                    }
                    
                    let range = NSMakeRange(location, lenghts[index])
                    attributedString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
                }
                
            }
        }
        
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.white, range: NSMakeRange(0, attributedString.string.count))
        fontsTextView.textStorage?.setAttributedString(attributedString)
    }
    
}
