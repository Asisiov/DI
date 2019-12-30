//
//  Module.swift
//  Livemetric
//
//  Created by Sisov on 22.12.2019.
//  Copyright © 2019 Sisov Alexandr. All rights reserved.
//

import Foundation

struct Module {
    let name: String
    let resolve: () -> Any
    
    init<T>(_ name: String? = nil, _ resolve: @escaping () -> T) {
        self.name = name ?? String(describing: T.self)
        self.resolve = resolve
    }
}
