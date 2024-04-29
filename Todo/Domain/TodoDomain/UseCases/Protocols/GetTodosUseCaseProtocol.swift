//
//  GetTodoUseCaseProtocol.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation

public protocol GetTodosUseCaseProtocol {
    func execute() async throws -> [Todo]
}
