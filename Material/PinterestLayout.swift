//
//  PinterestLayout.swift
//  Material
//
//  Created by ChengGuoTech || CG-005 on 2020/9/4.
//  Copyright © 2020 ChengGuoTech || CG-005. All rights reserved.
//  resources:
//  https://www.youtube.com/watch?v=DIxyCh55SqQ
//  https://www.youtube.com/watch?v=rsv5TV6NV1Q
//

import UIKit

protocol PinterestLayoutDetegate {
    
    func collectionView(collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat

}

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes{
    var photoHeight : CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! PinterestLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes{
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}


class PinterestLayout: UICollectionViewLayout {
    
    var cellPadding: CGFloat = 0
    var delegate: PinterestLayoutDetegate!
    var numberOfColumns = 1
    
    private var cache = [PinterestLayoutAttributes]()
    private var contentHeight : CGFloat = 0
    
    private var width: CGFloat{
        get{
            let insets = collectionView!.contentInset
            return collectionView!.bounds.width - (insets.left + insets.right)
        }
    }
    
    override class var layoutAttributesClass: AnyClass{
        return PinterestLayoutAttributes.self
    }
    
    override var collectionViewContentSize: CGSize{
        get{
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    
    override func prepare(){
        if cache.isEmpty {
            let columnWidth = width / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            for column in 0..<numberOfColumns{
                xOffsets.append(CGFloat(column)*columnWidth)
            }
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            var column = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
              
                let width = columnWidth - (cellPadding * 2)
                
                let photoHeight = delegate.collectionView(collectionView: collectionView!, heightForPhotoAtIndexPath: indexPath, withWidth: width)
                
                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath, withWidth: width)
                
                let height = cellPadding + photoHeight + annotationHeight + cellPadding
                
                
                let frame = CGRect(x: xOffsets[column], y: yOffset[column], width: columnWidth, height: height)
                
                let insetFrame = frame.insetBy(dx: cellPadding,dy: cellPadding)
                
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.photoHeight = photoHeight
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                
                
                if numberOfColumns > 1{
                    var isColumnChanged = false
                    for index in (1..<numberOfColumns).reversed() {
                      if yOffset[index] >= yOffset[index - 1] {
                        column = index - 1
                        isColumnChanged = true
                      }
                      else {
                        break
                      }
                    }
                    if isColumnChanged {
                      continue
                    }
                }
                
                
                column = column >= (numberOfColumns-1) ? 0 : (column + 1)
            }
            
            
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
          if attributes.frame.intersects(rect) {
            visibleLayoutAttributes.append(attributes)
          }
        }
        return visibleLayoutAttributes
    }
    
    //// Apple建议要重写这个方法, 因为某些情况下(delete insert...)系统可能需要调用这个方法来布局
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
      return cache[indexPath.item]
    }
}
