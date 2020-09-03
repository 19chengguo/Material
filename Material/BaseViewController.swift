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

    let collectionView :UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        if #available(iOS 11.0, *){
            layout.sectionInsetReference = .fromSafeArea
        }
        let coll = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        coll.backgroundColor = .white
        return coll
    }()
    
    let cellId = "collId"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setUpView()
    }
    
    func setUpView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }


}


extension BaseViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}
