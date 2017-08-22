//
//  Issue.swift
//  Rx
//
//  Created by Pavlo Muratov on 22.08.17.
//  Copyright © 2017 MPO. All rights reserved.
//

import Mapper

class Issue: Mappable {
    
    let identifier: Int
    let number: Int
    let title: String
    let body: String
    
    required init(map: Mapper) throws {
        try identifier = map.from("id")
        try number = map.from("number")
        try title = map.from("title")
        try body = map.from("body")
    }
}
