//
//  AddButton.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class AddButton: UIButton {
    
    override func layoutMarginsDidChange() {
        addDashLine()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setImage(UIImage(systemName: "plus"), for: .normal)
        self.tintColor = .green
        
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string: "Add", attributes:attrs)
        self.setAttributedTitle(boldString, for: .normal)
        self.setTitleColor(.green, for: .normal)
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addDashLine(){
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.width/2, y: bounds.height/2)
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round // Updated in swift 4.2
        shapeLayer.lineDashPattern = [16,8]
        shapeLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: self.layer.cornerRadius).cgPath
        
        self.layer.addSublayer(shapeLayer)
    }
    
}
