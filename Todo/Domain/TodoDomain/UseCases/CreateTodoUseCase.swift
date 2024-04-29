//
//  CreateTodoUseCase.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation

public class CreateTodoUseCase: CreateTodoUseCaseProtocol {
    private let todoRepository: TodoRepositoryProtocol
    
    public init(todoRepository: TodoRepositoryProtocol) {
        self.todoRepository = todoRepository
    }
    
    public func execute(todo: Todo) async throws {
        try await todoRepository.createTodo(todo: todo)
    }
}
