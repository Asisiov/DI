//
//  Dependencies.swift
//  Livemetric
//
//  Created by Sisov on 22.12.2019.
//  Copyright © 2019 Sisov Alexandr. All rights reserved.
//

import Foundation

protocol DependenciesLogic {
    func add(module: Module)
    func resolve<T>(for componentName: String?) -> T
}

class Dependencies {
    static var root = Dependencies()
    
    private var modules: [String: Module] = [:]
    private init() {}
    deinit { modules.removeAll() }
}

extension Dependencies: DependenciesLogic {
    
    func add(module: Module) {
        modules[module.name] = module
    }
    
    func resolve<T>(for componentName: String? = nil) -> T {
        let name = componentName ?? String(describing: T.self)
        guard let component: T = modules[name]?.resolve() as? T else {
            fatalError("Dependency '\(T.self)' not resolved!")
        }
        
        return component
    }
}

extension Dependencies {
    convenience init(@ModuleBuilder _ modules: () -> [Module]) {
        self.init()
        modules().forEach({ add(module: $0) })
    }
    
    convenience init(@ModuleBuilder _ module: () -> Module) {
        self.init()
        add(module: module())
    }
    
    func build() {
        Self.root = self
    }
    
    @_functionBuilder struct ModuleBuilder {
        static func buildBlock(_ modules: Module...) -> [Module] { modules }
        static func buildBlock(_ module: Module) -> Module { module }
    }
}
