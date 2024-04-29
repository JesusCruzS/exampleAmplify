//
//  TodoViewModel.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 23/04/24.
//

import Foundation
import Amplify

class TodoViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var error: Error?
    
    private let getTodosUseCase: GetTodosUseCaseProtocol
    private let createTodoUseCase: CreateTodoUseCaseProtocol
    private let createTodoSubscriptionUseCase: CreateTodoSubscriptionUseCaseProtocol
    private var subscription: AmplifyAsyncThrowingSequence<GraphQLSubscriptionEvent<Todo>>

    init(
        getTodosUseCase: GetTodosUseCaseProtocol,
        createTodoUseCase: CreateTodoUseCaseProtocol,
        createTodoSubscriptionUseCase: CreateTodoSubscriptionUseCaseProtocol,
        subscription: AmplifyAsyncThrowingSequence<GraphQLSubscriptionEvent<Todo>>) {
        self.getTodosUseCase = getTodosUseCase
        self.createTodoUseCase = createTodoUseCase
        self.createTodoSubscriptionUseCase = createTodoSubscriptionUseCase
        self.subscription = subscription
    }

    @MainActor
    func getTodos() async {
        do {
            self.todos = try await getTodosUseCase.execute()
        } catch {
            self.error = error
        }
    }
    
    func createTodo() async {
        do {
            try await createTodoUseCase.execute(todo: Todo(name: name, description: description))
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func createSubscription() {
        subscription = Amplify.API.subscribe(request: .subscription(of: Todo.self, type: .onCreate))
        Task {
            do {
                for try await subscriptionEvent in subscription {
                    switch subscriptionEvent {
                    case .connection(let subscriptionConnectionState):
                        print("Subscription connect state is \(subscriptionConnectionState)")
                    case .data(let result):
                        switch result {
                        case .success(let createdTodo):
                            self.todos.append(createdTodo)
                            print("Successfully got todo from subscription: \(createdTodo)")
                        case .failure(let error):
                            print("Got failed result with \(error.errorDescription)")
                        }
                    }
                }
            } catch {
                print("Subscription has terminated with \(error)")
            }
        }
    }
    
    func cancelSubscription() {
        print("Cancel subscription")
        subscription.cancel()
    }
    
    func resetFields() {
        name = ""
        description = ""
    }

}
