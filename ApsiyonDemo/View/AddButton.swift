//
//  AddButton.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class AddButton: UIButton {
    
    private let generalColor = UIColor(named: Constants.Color.buttonColor)
    
    private var _systemImageName = ""
    public var systemImageName:String{
        get{
            return _systemImageName
        }
        set{
            _systemImageName = newValue
            self.setImage(UIImage(systemName: newValue), for: .normal)
        }
    }
    
    private var _attributedText:NSMutableAttributedString?
    public var attributedText:NSMutableAttributedString{
        get{
            return _attributedText ?? NSMutableAttributedString(string: "", attributes: nil)
        }
        set{
            _attributedText = newValue
            self.setAttributedTitle(newValue, for: .normal)
        }
    }
    
    override func layoutMarginsDidChange() {
        addDashLine()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.tintColor = generalColor
        self.setTitleColor(generalColor, for: .normal)
        self.backgroundColor = .white
        self.layer.cornerRadius = 6
        
        self.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
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
    
    @objc func buttonPressed(){
        print("Custom button pressed")
    }
}
