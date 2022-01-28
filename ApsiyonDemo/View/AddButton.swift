//
//  AddButton.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class AddButton: UIButton {
    
    private let generalColor = UIColor(named: Constants.Color.buttonColor)
    
    override func layoutMarginsDidChange() {
        addDashLine()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "plus"), for: .normal)
        self.tintColor = generalColor
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string: "Add", attributes:attrs)
        self.setAttributedTitle(boldString, for: .normal)
        self.setTitleColor(generalColor, for: .normal)
        
        self.backgroundColor = .white
        
        self.layer.cornerRadius = 6
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addDashLine(){
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = generalColor?.cgColor ?? UIColor.green.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [8,8]
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
}
