//
//  ToDoRepositoryProtocol.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Combine

public protocol TodoRepositoryProtocol {
    func getTodos() async throws -> [Todo]
    func createTodo(todo: Todo) async throws -> Void
    func createTodoSubscription() async throws -> Todo
}
