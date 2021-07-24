//
//  GridLayout.swift
//  GridLayout
//
//  Created by Sztanyi Szabolcs on 2016. 11. 01..
//  Copyright © 2016. Sabminder. All rights reserved.
//

import UIKit

class GridLayout: UICollectionViewFlowLayout {

    private var numberOfColumns: Int = 2

    init(numberOfColumns: Int) {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1

        self.numberOfColumns = numberOfColumns

        print("numberOfColumns =",self.numberOfColumns)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var itemSize: CGSize {
        get {
                if let collectionView = collectionView {
                    let itemWidth: CGFloat = (collectionView.frame.width/CGFloat(self.numberOfColumns)) - self.minimumInteritemSpacing

                    let itemHeight: CGFloat = collectionView.frame.size.height
                    return CGSize(width: itemWidth, height: itemHeight)
                }

            // Default fallback

            // here set for iphone which have numberOfColumns more than 4
            return CGSize(width: 100, height: collectionView!.frame.size.height)
        }
        set {
            super.itemSize = newValue
        }
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        if let collectionView = collectionView {
            return collectionView.contentOffset
        }
        return CGPoint.zero
    }

}
