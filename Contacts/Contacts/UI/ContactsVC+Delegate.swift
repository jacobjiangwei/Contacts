//
//  ContactsVC+CollectionDelegate.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import Foundation
import UIKit

extension ContactsVC:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contacts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: avatarCollectionViewCellIdentifier, for: indexPath) as! AvatarCollectionViewCell
        let contact = contacts[indexPath.row]
        cell.avatarView.image = UIImage(named: contact.avatar_filename!)
        cell.avatarView.isFocus = indexPath.row == avatarFocusIndex
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToIndex(value: indexPath.row)
    }
}

extension ContactsVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width/2.0 - collectionViewCellWidth/2.0, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width/2.0 - collectionViewCellWidth/2.0, height: collectionViewHeight)
    }
}

extension ContactsVC:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView === avatarCollectionView {
            syncPoisitionInAuthorTableView(scrollView)
        }
        else if scrollView === authorTableView {
            syncPoisitionInAvatarCollectionView(scrollView)
        }
    }
    
    private func syncPoisitionInAuthorTableView(_ scrollView: UIScrollView) {
        if avatarCollectionView.contentSize.height == 0 || authorTableView.contentSize.height == 0 {
            return
        }
        // focus avatar
        let focusIndex = Int((scrollView.contentOffset.x + collectionViewCellWidth/2) / collectionViewCellWidth)
        self.avatarFocusIndex = focusIndex
        // get percentage of collection view cell
        let percentage = (scrollView.contentOffset.x / collectionViewCellWidth ).truncatingRemainder(dividingBy: 1.00)
        let authorIndex = Int(scrollView.contentOffset.x / collectionViewCellWidth)
        // get offset for author tableview
        let indexPath = IndexPath(row: authorIndex, section: 0)
        let rectForCell = authorTableView.rectForRow(at: indexPath)
        let cellRectInSuperView = authorTableView.convert(rectForCell, to: authorTableView)
        let targetOffSet = cellRectInSuperView.origin.y + percentage * cellRectInSuperView.height
        
        authorTableView.delegate = nil
        authorTableView.contentOffset.y = targetOffSet
        authorTableView.delegate = self
    }
    
    private func syncPoisitionInAvatarCollectionView(_ scrollView: UIScrollView) {
        // current Visible Offset -> indexPath
        guard let indexPath = authorTableView.indexPathForRow(at: CGPoint(x: 0, y: scrollView.contentOffset.y)) else {
            return
        }        
        let tableviewOriginYOffSet = authorTableView.frame.origin.y
        let rectForCell = authorTableView.rectForRow(at: indexPath)
        let cellRectInSuperView = authorTableView.convert(rectForCell, to: self.view)

        let offsetForThisCell = abs( cellRectInSuperView.origin.y - tableviewOriginYOffSet )

        // current Indexpath + current cell percentage
        let offSetPercentageWithInCell = offsetForThisCell/rectForCell.height

        // calculate avatar offset
        let avatarCollectionOffsetX = (CGFloat(indexPath.row) + offSetPercentageWithInCell) * collectionViewCellWidth
        self.avatarCollectionView.delegate = nil
        if offSetPercentageWithInCell >= 0.5 {
            self.avatarFocusIndex = min(indexPath.row + 1, contacts.count - 1)
        }
        else
        {
            self.avatarFocusIndex = indexPath.row
        }
        self.avatarCollectionView.contentOffset.x = avatarCollectionOffsetX
        self.avatarCollectionView.delegate = self
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView === authorTableView && !decelerate {
            resetAuthorTableViewToNearestCard(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView === authorTableView  {
            resetAuthorTableViewToNearestCard(scrollView)
        }
    }
    
    private func resetAuthorTableViewToNearestCard(_ scrollView:UIScrollView) {
        // find nearest cell / attach to normal position
        guard let indexPath = authorTableView.indexPathForRow(at: CGPoint(x: 0, y: scrollView.contentOffset.y)) else {
            return
        }
        guard let cell = authorTableView.cellForRow(at: indexPath) else { return }
        
        let tableviewOriginYOffSet = authorTableView.frame.origin.y
        let rectForCell = authorTableView.rectForRow(at: indexPath)
        let cellRectInSuperView = authorTableView.convert(rectForCell, to: self.view)
        let offsetForThisCell = abs( cellRectInSuperView.origin.y - tableviewOriginYOffSet )
        
        // current Indexpath + current cell percentage
        let offSetPercentageWithInCell = offsetForThisCell/cell.frame.height
        
        self.avatarCollectionView.delegate = nil
        if offSetPercentageWithInCell >= 0.5 {
            scrollToIndex(value: min(indexPath.row + 1, contacts.count - 1))
        }
        else
        {
            scrollToIndex(value: indexPath.row)
        }
    }
}

extension ContactsVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: authorTableViewCellIdentifier, for: indexPath) as? AuthorTableViewCell
        let contact = contacts[indexPath.row]
        cell?.setData(contact: contact)
        return cell ?? AuthorTableViewCell()
    }
}
