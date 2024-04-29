//
//  TodoRepository.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation
import Amplify
import Combine

enum CustomError: Error {
    case subscriptionError
    case subscriptionClosed
}

class TodoRepository: TodoRepositoryProtocol {
    
    private var subscription: AnyCancellable?
    
    func getTodos() async throws -> [Todo] {
        do {
            let result = try await Amplify.API.query(request: GraphQLRequest<Todo>.list(Todo.self))
            switch result {
            case .success(let todos):
                return todos.compactMap { $0 }
            case .failure(let error):
                print("Got failed result with \(error.errorDescription)")
            }
        } catch let error as APIError {
            print("Failed to query list of todos: ", error)
        } catch {
            print("Unexpected error: \(error)")
        }
        
        return []
    }
    
    func createTodo(todo: Todo) async throws {
        do {
          let _ = try await Amplify.API.mutate(request: .create(todo))
        } catch {
            print("Error creating todo: \(error)")
        }
    }
    
    func createTodoSubscription() async throws -> Todo {
        let sequence = Amplify.API.subscribe(request: .subscription(of: Todo.self, type: .onCreate))
            subscription = Amplify.Publisher.create(sequence)
                .sink {
                if case let .failure(apiError) = $0 {
                    print("Subscription has terminated with \(apiError)")
                } else {
                    print("Subscription has been closed successfully")
                }
            }
            receiveValue: { result in
                switch result {
                    case .connection(let subscriptionConnectionState):
                        print("Subscription connect state is \(subscriptionConnectionState)")
                    case .data(let result):
                        switch result {
                        case .success(let createdTodo):
                            print("Successfully got todo from subscription: \(createdTodo)")
                            return createdTodo
                        case .failure(let error):
                            print("Got failed result with \(error.errorDescription)")
                    }
                }
            }
    }
}
