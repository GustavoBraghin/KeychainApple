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

        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.save()
//            self?.getPassword()
        }
    }
    
    private func save() {
        do {
            try KeychainManager.save(service: "instagram.com", account: "gbraghin", password: "something".data(using: .utf8) ?? Data())
        }
        catch {
            print(error)
        }
    }
    
    private func getPassword() {
        guard let data = KeychainManager.get(service: "instagram.com", account: "gbraghin") else {
            print("failed to get password")
            return
        }
        
        let password = String(decoding: data, as: UTF8.self)
        print("Password: \(password)")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

