//
//  KeychainManager.swift
//  Keychain
//
//  Created by Gustavo da Silva Braghin on 13/02/23.
//

import Foundation

class KeychainManager {
    enum KeychainError: Error {
        case duplicateEntry
        case unkwown(OSStatus)
    }
    
    static func save(service: String, account: String, password: Data) throws {
        //keys needed: service, account, password, class, data
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecValueData as String: password as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw KeychainError.duplicateEntry
        }
        
        guard status == errSecSuccess else {
            throw KeychainError.unkwown(status)
        }
        
        print("saved")
    }
    
    static func get(service: String, account: String) -> Data? {
        //keys needed: service, account, password, class, data
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        _ = SecItemCopyMatching(query as CFDictionary, &result)
        
        return result as? Data
    }
}
