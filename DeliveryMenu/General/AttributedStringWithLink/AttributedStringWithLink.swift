//
//  AttributedStringWithLink.swift
//  DeliveryMenu
//
//  Created by Hleb Rastsisheuski on 25.12.22.
//

import UIKit

class AttributedStringWithLink: UILabel {
    var contentText: String = ""
    var linkWord: String = ""
    
    init(contentText: String, linkWord: String) {
        super.init(frame: .zero)
        
        self.contentText = contentText
        self.linkWord = linkWord
        
        configureSubViews(contentText: contentText, linkWord: linkWord)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews(contentText: String, linkWord: String) {
        let attributeMutableStringLink = NSMutableAttributedString(string: contentText)
        attributeMutableStringLink.addAttribute(.link, value: "https://www.pornhub.com", range: contentText.createRangeInLink(of: linkWord))
//        attributeMutableStringLink.addAttribute(.underlineStyle, value: NSUnderlineStyle.single, range: contentText.createRangeInLink(of: linkWord))
//        attributeMutableStringLink.addAttribute(.foregroundColor, value: Colors.General.selectedButton, range: contentText.createRangeInLink(of: linkWord))
        
        self.attributedText = attributeMutableStringLink
    }
}

extension String {
    func createRangeInLink(of findWord: String) -> NSRange {
        let range = (self as NSString).range(of: findWord, options: .caseInsensitive)
        return range
    }
}
