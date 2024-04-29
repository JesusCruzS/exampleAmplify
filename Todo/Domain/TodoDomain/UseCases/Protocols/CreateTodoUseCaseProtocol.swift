//
//  CreateTodoUseCaseProtocol.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation

public protocol CreateTodoUseCaseProtocol {
    func execute(todo: Todo) async throws -> Void
}
