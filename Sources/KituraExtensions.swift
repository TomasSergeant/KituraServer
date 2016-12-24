//
//  KituraExtensions.swift
//  KituraServer
//
//  Created by Tomas Sergeant on 23/12/16.
//
//

import Foundation
import Kitura
import SwiftyJSON

public extension RouterRequest {
    var json : JSON? {
        guard let body = self.body else {
            return nil
        }
        guard case let .json(json) = body else {
            return nil
        }
        
        return json
    }
}
