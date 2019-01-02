//
//  ViewController.swift
//  BlockChain_Logic
//
//  Created by Petar Lemajic on 1/2/19.
//  Copyright © 2019 Petar Lemajic. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // Wallet 1 Outlet
    @IBOutlet weak var userOneLabel: UILabel!
    @IBOutlet weak var userOneTextField: UITextField!

    // Wallet 2 Outlet
    @IBOutlet weak var userTwoTextField: UITextField!
    @IBOutlet weak var userTwoLabel: UILabel!

    let firstAccount = 1065
    let secondAccount = 0242
    let bitcoinChain = Blockchain()
    let reward = 100
    var accounts: [String: Int] = ["0000": 10000000]
    let invalidAlert = UIAlertController(title: "Invalid Transaction", message: "Please check the details of your transaction as we were unable to process this", preferredStyle: .alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        transaction(from: "0000", to: "\(firstAccount)", amount: 50, type: "genesis")
        transaction(from: "\(firstAccount)", to: "\(secondAccount)", amount: 10, type: "normal")
        chainState()
        self.invalidAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }

    // Main logic for transaction
    fileprivate func transaction(from: String, to: String, amount: Int, type: String) {
        if accounts[from] == nil {
            self.present(invalidAlert, animated: true, completion: nil)
            return
        } else if accounts[from]! - amount < 0 {
            self.present(invalidAlert, animated: true, completion: nil)
            return
        } else {
            accounts.updateValue(accounts[from]! - amount, forKey: from)
        }

        if accounts[to] == nil {
            accounts.updateValue(amount, forKey: to)
        } else {
            accounts.updateValue(accounts[to]! + amount, forKey: to)
        }

        if type == "genesis" {
            bitcoinChain.createGenericBlock(data: "From: \(from); To: \(to); Amount: \(amount)BTC")
        } else if type == "normal" {
            bitcoinChain.createBlock(data: "From: \(from); To: \(to); Amount: \(amount)BTC")
        }
    }

    func chainState() {
        for i in 0...bitcoinChain.chain.count - 1 {
            print("\tBlock: \(bitcoinChain.chain[i].index!)\n\tHash: \(bitcoinChain.chain[i].hash!)\n\tPreviousHash: \(bitcoinChain.chain[i].previousHash!)\n\tData: \(bitcoinChain.chain[i].data!)")
        }
        userOneLabel.text = "Balance: \(accounts[String(describing: firstAccount)]!) BTC"
        userTwoLabel.text = "Balance: \(accounts[String(describing: secondAccount)]!) BTC"
        print(accounts)
    }

    // Chain Validity

    func chainValidity() -> String {
        var isChainValid = true
        for i in 1...bitcoinChain.chain.count - 1 {
            if bitcoinChain.chain[i].previousHash != bitcoinChain.chain[i - 1].hash {
                isChainValid = false
            }
        }
        return "Chain is valid: \(isChainValid)\n"
    }
    
    // Wallet one Sending and mine logic
    fileprivate func walletOneMineLogic() {
        transaction(from: "0000", to: "\(firstAccount)", amount: 100, type: "normal")
        print("New block mined by: \(firstAccount)")
        chainState()
    }

    fileprivate func walletOneSendingLogic() {
        if userOneTextField.text == "" {
            present(invalidAlert, animated: true, completion: nil)
        } else {
            transaction(from: "\(firstAccount)", to: "\(secondAccount)", amount: Int(userOneTextField.text ?? "")!, type: "normal")
            print("\(userOneTextField.text!) BTC sent from \(firstAccount) to \(secondAccount)")
            chainState()
            userOneTextField.text = ""
        }
    }

    // Wallet two sending and mine logic
    fileprivate func walletTwoMineLogic() {
        transaction(from: "0000", to: "\(secondAccount)", amount: 100, type: "normal")
        print("New block mined by: \(secondAccount)")
        chainState()
    }

    fileprivate func walletTwoSendingLogic() {
        if userTwoTextField.text == "" {
            present(invalidAlert, animated: true, completion: nil)
        } else {
            transaction(from: "\(secondAccount)", to: "\(firstAccount)", amount: Int(userTwoTextField.text ?? "")!, type: "normal")
            print("\(userTwoTextField.text!) BTC sent from \(secondAccount) to \(firstAccount)")
            chainState()
            userTwoTextField.text = ""
        }
    }


    //Wallet one Action
    @IBAction func userOneMineButtonTapped(_ sender: Any) {
        walletOneMineLogic()
    }

    @IBAction func userOneSendButtonTapped(_ sender: Any) {
        walletOneSendingLogic()
    }

    //Wallet 2 Action
    @IBAction func userTwoMineButtonTapped(_ sender: Any) {
        walletTwoMineLogic()
    }

    @IBAction func userTwoSendButtonTapped(_ sender: Any) {
        walletTwoSendingLogic()
    }
}

extension MainViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


