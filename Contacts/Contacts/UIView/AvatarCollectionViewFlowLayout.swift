//
//  AvatarCollectionViewFlowLayout.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/23/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import UIKit

class AvatarCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let index = Int((proposedContentOffset.x + collectionViewCellWidth/2) / collectionViewCellWidth)
        let desireOffSet = CGFloat(index) * collectionViewCellWidth
        let result = CGPoint(x: desireOffSet, y: proposedContentOffset.y)
        return super.targetContentOffset(forProposedContentOffset: result, withScrollingVelocity: velocity)
    }
}

