//
//  Block.swift
//  BlockChain_Logic
//
//  Created by Petar Lemajic on 1/2/19.
//  Copyright © 2019 Petar Lemajic. All rights reserved.
//

import UIKit

class Block {
    var hash: String?
    var data: String?
    var previousHash: String?
    var index: Int?

    func generateHash() -> String {
        return NSUUID().uuidString.replacingOccurrences(of: "-", with: "")
    }
}
