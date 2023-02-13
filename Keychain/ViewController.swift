//
//  ViewController.swift
//  Keychain
//
//  Created by Gustavo da Silva Braghin on 13/02/23.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.global(qos: .background).async {
            do {
                try KeychainManager.save(service: "instagram.com", account: "gbraghin", password: "something".data(using: .utf8) ?? Data())
            }
            catch {
                print(error)
            }
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

