//
//  Response.swift
//  CTAProject
//
//  Created by Tomoya Tanaka on 2022/01/20.
//

import Foundation

extension HotPepperAPI {
    struct Response<Body: Decodable>: Decodable {
        let results: Body
    }
    
}



