//
//  MIFab.swift
//  ColorSnipe
//
//  Created by Mario on 23/09/16.
//  Copyright © 2016 Mario Iannotta. All rights reserved.
//

import UIKit

public struct MIFabOption {
    
    public typealias MIFabOption = (Void) -> Void
    
    public var title: String?
    public var image: UIImage?
    
    public var actionClosure: MIFabOption?
    
    public var backgroundColor: UIColor?
    public var tintColor: UIColor?
    
    public init(title: String? = nil, image: UIImage? = nil, backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, actionClosure: @escaping MIFabOption) {
        
        self.title = title
        self.image = image
        
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        
        self.actionClosure = actionClosure
        
    }
    
}

public class MIFab {
    
    public struct Config {
        
        public var width: CGFloat = 10
        
        public var overlayLayerColor = UIColor(white: 0, alpha: 0.6)
        
        public var buttonPadding = CGSize(width: 30, height: 40)
        public var buttonSize: CGFloat = 75
        
        public var buttonImage: UIImage?
        public var buttonBackgroundColor = UIColor.orange
        public var buttonTintColor = UIColor.white
        
        public var buttonShadowColor = UIColor(white: 0, alpha: 0.2)
        public var buttonShadowRadius: CGFloat = 3
        public var buttonShadowOffset = CGSize(width: 3, height: 3)
        
        public var spaceBetweenButtonAndOptions: CGFloat = 15
        
        public var optionHeight: CGFloat = 70
        
        public var optionIconSize: CGFloat = 60
        public var optionIconShadowColor = UIColor(white: 0, alpha: 0.2)
        public var optionIconShadowRadius: CGFloat = 3
        public var optionIconShadowOffset = CGSize(width: 3, height: 3)
        
        public var optionLabelShadowColor = UIColor(white: 0, alpha: 0.1)
        public var optionLabelShadowRadius: CGFloat = 2
        public var optionLabelShadowOffset = CGSize(width: 3, height: 3)
        
        public var optionLabelPadding = CGSize(width: 12, height: 8)
        
        public var optionsAnimationDuration: TimeInterval = 0.3
        
        public init() {
            
        }
        
    }
    
    fileprivate weak var fabButton: MIFabButton!
    
    fileprivate weak var parentVC: UIViewController?
    
    var config: Config!
    var fabOptions: [MIFabOption]?
    
    public init(parentVC: UIViewController, config: Config, options: [MIFabOption]?) {
        
        self.parentVC = parentVC
        self.config = config
        self.fabOptions = options
        
        setupButton()
        
        hideButton()
        
    }
    
    // MARK: - Public methods
    
    public func showButton(animated: Bool = false) {
        
        UIView.animate(withDuration: animated ? 0.2 : 0) {
            
            self.fabButton.alpha = 1
            self.fabButton.frame.origin = CGPoint(x: self.fabButton.frame.origin.x, y: UIScreen.main.bounds.height - self.config.buttonSize)
            
        }
        
    }
    public func hideButton(animated: Bool = false) {
        
        UIView.animate(withDuration: animated ? 0.2 : 0) {
            
            self.fabButton.alpha = 0
            self.fabButton.frame.origin = CGPoint(x: self.fabButton.frame.origin.x, y: UIScreen.main.bounds.height + self.config.buttonSize)
            
        }
        
    }
    
    public func showFabOptions(animated: Bool = false) {
        print("clicked")
    }
    
    // MARK: - Fileprivate methods
    
    fileprivate func setupButton() {
        
        fabButton = MIFabButton.get(delegate: self)
        
        fabButton.alpha = 0
        
        fabButton.button.setImage(config.buttonImage, for: UIControlState())
        
        fabButton.button.backgroundColor = config.buttonBackgroundColor
        fabButton.button.tintColor = config.buttonTintColor
        
        fabButton.layer.shadowColor = config.buttonShadowColor.cgColor
        fabButton.layer.shadowRadius = config.buttonShadowRadius
        fabButton.layer.shadowOpacity = 1
        fabButton.layer.shadowOffset = config.buttonShadowOffset
        
        guard let fabButtonSuperView = parentVC?.view else { return }
        
        fabButtonSuperView.addSubview(fabButton)
        
        fabButton.translatesAutoresizingMaskIntoConstraints = false
        
        fabButton.addConstraints([
            NSLayoutConstraint(item: fabButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: config.buttonSize),
            NSLayoutConstraint(item: fabButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: config.buttonSize)
            ])
        
        fabButtonSuperView.addConstraints([
            NSLayoutConstraint(item: fabButtonSuperView, attribute: .bottom, relatedBy: .equal, toItem: fabButton, attribute: .bottom, multiplier: 1, constant: config.buttonPadding.height),
            NSLayoutConstraint(item: fabButtonSuperView, attribute: .trailing, relatedBy: .equal, toItem: fabButton, attribute: .trailing, multiplier: 1, constant: config.buttonPadding.width)
            ])
        
    }
    
}

// MARK: MIFabButtonDelegate

extension MIFab: MIFabButtonDelegate {
    
    func fabButtonDidTapped(_ fabButton: MIFabButton) {
        
        showFabOptions(animated: true)
        
    }
    
}
