//
//  CreateTodoSubscriptionUseCase.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 26/04/24.
//

import Foundation
import Combine

public class CreateTodoSubscriptionUseCase: CreateTodoSubscriptionUseCaseProtocol {
   
    private let todoRepository: TodoRepositoryProtocol
    
    public init(todoRepository: TodoRepositoryProtocol) {
        self.todoRepository = todoRepository
    }
    
    public func execute() async throws -> Todo {
        let todo = try await todoRepository.createTodoSubscription()
        return todo
    }
}
