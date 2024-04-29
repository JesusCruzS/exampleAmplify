//
//  GetTodosUseCase.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation

public class GetTodosUseCase: GetTodosUseCaseProtocol {
    private let todoRepository: TodoRepositoryProtocol
    
    public init(todoRepository: TodoRepositoryProtocol) {
        self.todoRepository = todoRepository
    }
    
    public func execute() async throws -> [Todo] {
        let todos = try await todoRepository.getTodos()
        return todos
    }
}
