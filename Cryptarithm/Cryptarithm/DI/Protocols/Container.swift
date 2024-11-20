//
//  Container.swift
//  Cryptarithm
//
//  Created by Павел Дубровский on 15.11.24.
//

import Foundation

protocol Container { }

protocol ContainerAssembly {
    associatedtype ContainerType: Container
    func assemble() -> ContainerType
}
