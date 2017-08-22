//
//  Repository.swift
//  Rx
//
//  Created by Pavlo Muratov on 22.08.17.
//  Copyright © 2017 MPO. All rights reserved.
//

import Mapper

class Repository: Mappable {
    
    let identifier: Int
    let language: String
    let name: String
    let fullName: String
    
    required init(map: Mapper) throws {
        identifier = try map.from("id")
        language = try map.from("language")
        name = try map.from("name")
        fullName = try map.from("full_name")
    }
    
}
