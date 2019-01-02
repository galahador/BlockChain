//
//  Blockchain.swift
//  BlockChain_Logic
//
//  Created by Petar Lemajic on 1/2/19.
//  Copyright © 2019 Petar Lemajic. All rights reserved.
//

import Foundation

class Blockchain {
    var chain = [Block]()
    
    func createGenericBlock(data: String) {
        let genesisBlock = Block()
        genesisBlock.hash = genesisBlock.generateHash()
        genesisBlock.data = data
        genesisBlock.index = 0
        genesisBlock.previousHash = "0000"
        chain.append(genesisBlock)
    }
    
    func createBlock(data: String) {
        let newBlock = Block()
        newBlock.hash = newBlock.generateHash()
        newBlock.data = data
        newBlock.index = chain.count
        newBlock.previousHash = chain[chain.count - 1].hash
        chain.append(newBlock)
    }
}
