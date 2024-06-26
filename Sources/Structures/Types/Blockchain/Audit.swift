//
//  Audit.swift
//  SwiftStructures
//
//  Created by Wayne Bishop on 6/11/20.
//  Copyright © 2020 Arbutus Software Inc. All rights reserved.
//

import Foundation


/**
 Records actions of blockchain `miners`. Used when polling for pending transactions, mining blocks and receiving rewards from the main network.
 */
class Audit {
    
    var action: String?
    var requester: Miner?
    var datetime: Date
    
    
    init(action: String = "", _ requester: Miner) {
        
        self.action = action
        self.requester = requester
        
        datetime = Date()
    }
    
}

