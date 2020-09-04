//
//  MaterialCell.swift
//  Material
//
//  Created by ChengGuoTech || CG-005 on 2020/9/3.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit

class MaterialCell: UICollectionViewCell {
    
    
    let imageView : UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let subView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.brown
        return v
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews(){
        contentView.addSubview(imageView)
        contentView.addSubview(subView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(200)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(150)
        }
        
        subView.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            make.height.equalTo(50)
        }
        
        
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! PinterestLayoutAttributes
        imageView.snp.updateConstraints { (make) in
            make.height.equalTo(attributes.photoHeight)
        }
    }
}
