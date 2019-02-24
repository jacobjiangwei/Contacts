//
//  ContactsVC.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import UIKit

let collectionViewCellWidth:CGFloat = 80.0
let collectionViewHeight:CGFloat = 120.0
let avatarCollectionViewCellIdentifier:String = "avatarCollectionViewCellIdentifier"
let authorTableViewCellIdentifier:String = "authorTableViewCellIdentifier"

class ContactsVC: UIViewController {
    var avatarCollectionView:UICollectionView!
    var authorTableView:UITableView!
    fileprivate var avatarCollectionLayout:AvatarCollectionViewFlowLayout!

    var contacts:[Contact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("Contacts", comment: "Contacts")
        
        setupData()
        setupViews()
        
    }
    
    func setupData() {
        DispatchQueue.global().async {
            let filePath = Bundle.main.path(forResource: "contacts", ofType: "json")
            let contentData = try! Data(contentsOf: URL(fileURLWithPath: filePath!))
            let decoder = JSONDecoder()
            self.contacts = try! decoder.decode([Contact].self, from: contentData)
            DispatchQueue.main.async {
                self.avatarCollectionView.reloadData()
                self.authorTableView.reloadData()
            }
        }
    }
    
    func setupViews() {
        self.view.backgroundColor = UIColor.white
        
        avatarCollectionLayout = AvatarCollectionViewFlowLayout()
        avatarCollectionLayout.itemSize = CGSize(width: collectionViewCellWidth, height: collectionViewHeight)
        avatarCollectionLayout.minimumInteritemSpacing = 0.0
        avatarCollectionLayout.minimumLineSpacing = 0.0
        avatarCollectionLayout.scrollDirection = .horizontal
        avatarCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: avatarCollectionLayout)
        avatarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        avatarCollectionView.delegate = self
        avatarCollectionView.dataSource = self
        avatarCollectionView.showsHorizontalScrollIndicator = false
        avatarCollectionView.register(AvatarCollectionViewCell.self, forCellWithReuseIdentifier: avatarCollectionViewCellIdentifier)
        self.view.addSubview(avatarCollectionView)
        avatarCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        avatarCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0).isActive = true
        avatarCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        avatarCollectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight).isActive = true
        avatarCollectionView.backgroundColor = UIColor.clear
        
        
        authorTableView = UITableView(frame: CGRect.zero)
        authorTableView.translatesAutoresizingMaskIntoConstraints = false
        authorTableView.delegate = self
        authorTableView.dataSource = self
        authorTableView.rowHeight = UITableView.automaticDimension
        authorTableView.estimatedRowHeight = self.view.frame.height - collectionViewHeight
        authorTableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: authorTableViewCellIdentifier)
        self.view.addSubview(authorTableView)
        authorTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0.0).isActive = true
        authorTableView.topAnchor.constraint(equalTo: avatarCollectionView.bottomAnchor, constant: 0.0).isActive = true
        authorTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0.0).isActive = true
        authorTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
    }
    

  
    var avatarFocusIndex:Int = 0 {
        willSet {
            if avatarFocusIndex < 0 || avatarFocusIndex >= contacts.count{
                return
            }
            let indexPath = IndexPath(item: avatarFocusIndex, section: 0)
            let cell = self.avatarCollectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell
            cell?.avatarView.isFocus = false
        }
        
        didSet {
            if avatarFocusIndex < 0 || avatarFocusIndex >= contacts.count{
                return
            }
            let indexPath = IndexPath(item: avatarFocusIndex, section: 0)
            let cell = self.avatarCollectionView.cellForItem(at: indexPath) as? AvatarCollectionViewCell
            cell?.avatarView.isFocus = true
        }
    }
    
    func scrollToIndex(value:Int) {
        if value < 0 || value >= contacts.count {
            return
        }
        avatarFocusIndex = value
        let indexPath = IndexPath(item: value, section: 0)
        self.authorTableView.delegate = nil
        self.avatarCollectionView.delegate = nil
        self.avatarCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        self.authorTableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.authorTableView.delegate = self
            self.avatarCollectionView.delegate = self
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard avatarCollectionView != nil && authorTableView != nil else {
            return
        }
        self.avatarCollectionView.reloadData()
        self.authorTableView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.scrollToIndex(value: self.avatarFocusIndex)
        }
    }
}
