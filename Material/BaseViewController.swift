//
//  BaseViewController.swift
//  Material
//
//  Created by ChengGuoTech || CG-005 on 2020/9/3.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//

import UIKit
import SnapKit
class BaseViewController: UIViewController {

    
    var colors: [UIColor] =  [UIColor.red,UIColor.green,UIColor.blue,UIColor.orange,UIColor.purple,UIColor.yellow,UIColor.purple,UIColor.green,UIColor.green,UIColor.lightGray,UIColor.red]
    
    
    let collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        let coll = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        coll.alwaysBounceVertical = true

        return coll
    }()
    
    let cellId = "collId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        
        setUpView()
        setLayout()
    }
    
    func setUpView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MaterialCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    func setLayout(){
        let layout =  PinterestLayout()
        layout.delegate = self
        layout.numberOfColumns = 2
        layout.cellPadding = 4
        collectionView.collectionViewLayout = layout
    }


}


extension BaseViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MaterialCell {
            cell.imageView.backgroundColor = colors[indexPath.item]
            return cell
        }
        
        
        return UICollectionViewCell()
    }
    
    
}

extension BaseViewController:PinterestLayoutDetegate{
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let random = arc4random_uniform(4) + 1
        return CGFloat(random * 100)
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 50
    }
    
}
