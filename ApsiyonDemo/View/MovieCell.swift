//
//  MovieCell.swift
//  ApsiyonDemo
//
//  Created by Metilli on 28.01.2022.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    static let identifier = "MovieCell"
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let labelReleaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        return label
    }()
    
    private let labelScore: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        return label
    }()
    
    private let imagePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .cyan
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let imageRightArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "RightArrowIcon")
        imageView.alpha = 0.4
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        contentView.addSubview(viewBackground)
        contentView.addSubview(imagePoster)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelReleaseDate)
        contentView.addSubview(labelScore)
        contentView.addSubview(imageRightArrow)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewBackground.frame = CGRect(x: contentView.frame.minX + 14,
                                      y: contentView.frame.minY + 14,
                                      width: contentView.frame.width - 28,
                                      height: contentView.frame.height - 16)
        
        imagePoster.frame = CGRect(x: viewBackground.frame.minX + 16,
                                   y: viewBackground.frame.minY - 16,
                                   width: viewBackground.frame.height / 1.5,
                                   height: viewBackground.frame.height)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.topAnchor.constraint(lessThanOrEqualTo: labelReleaseDate.topAnchor).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: imagePoster.rightAnchor, constant: 8).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: imageRightArrow.leftAnchor, constant: 4).isActive = true
        
        labelReleaseDate.translatesAutoresizingMaskIntoConstraints = false
        labelReleaseDate.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 12).isActive = true
        labelReleaseDate.leftAnchor.constraint(equalTo: imagePoster.rightAnchor, constant: 8).isActive = true
        labelReleaseDate.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: 8).isActive = true
        
        labelScore.translatesAutoresizingMaskIntoConstraints = false
        labelScore.topAnchor.constraint(equalTo: labelReleaseDate.bottomAnchor, constant: 10).isActive = true
        labelScore.leftAnchor.constraint(equalTo: imagePoster.rightAnchor, constant: 8).isActive = true
        labelScore.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: 8).isActive = true
        labelScore.bottomAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: -10).isActive = true
        
        imageRightArrow.translatesAutoresizingMaskIntoConstraints = false
        let rightArrowHeight = 24.0 / 150.0 * contentView.frame.height
        let rightArrowWidth = rightArrowHeight / 1
        imageRightArrow.heightAnchor.constraint(equalToConstant: rightArrowHeight).isActive = true
        imageRightArrow.widthAnchor.constraint(equalToConstant: rightArrowWidth).isActive = true
        imageRightArrow.rightAnchor.constraint(equalTo: viewBackground.rightAnchor, constant: -16).isActive = true
        imageRightArrow.centerYAnchor.constraint(equalTo: viewBackground.centerYAnchor, constant: 0).isActive = true
    }
    
    public func setTitle(_ title: String){
        labelTitle.text = title
    }
    
    public func setReleaseDate(_ date: String){
        labelReleaseDate.text = date
    }
    
    public func setScore(_ score: Double){
        var color = UIColor()
        if score < 7{
            color = .red
        }else if score <= 9{
            color = .orange
        }else{
            color = .green
        }
        labelScore.text = "★ \(score) / 10"
        labelScore.textColor = color
    }
    
    public func setPosterURL(_ urlString: String){
        
    }
}
