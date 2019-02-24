//
//  ContactModel.swift
//  Contacts
//
//  Created by Jacob Jiang on 2/22/19.
//  Copyright © 2019 RingCentral. All rights reserved.
//

import Foundation

struct Contact:Codable {
    var first_name:String?
    var last_name:String?
    var avatar_filename:String?
    var title:String?
    var introduction:String?
}
