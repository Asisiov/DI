//
//  PropertyWrapper.swift
//  Livemetric
//
//  Created by Sisov on 22.12.2019.
//  Copyright © 2019 Sisov Alexandr. All rights reserved.
//

import Foundation

@propertyWrapper
class Inject<Value> {
    private let name: String?
    private var storage: Value?
    
    var wrappedValue: Value {
        storage ?? {
            let value: Value = Dependencies.root.resolve(for: name)
            storage = value
            return value
            } ()
    }
    
    init() {
        self.name = nil
    }
    
    init(_ name: String) {
        self.name = name
    }
}
