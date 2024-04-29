//
//  Resolver.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 25/04/24.
//

import Foundation
import Swinject
import Amplify

class Resolver {
    public static let shared = Resolver()

    private var container = Container()
    
    @MainActor
    func injectModules() {
        injectRepositories()
        injectUseCases()
        injectViewModels()
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

extension Resolver {
    private func injectRepositories() {
        container.register(TodoRepositoryProtocol.self){ resolver in
            TodoRepository()
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectUseCases() {
        container.register(GetTodosUseCaseProtocol.self) { resolver in
            GetTodosUseCase(todoRepository:
                                resolver.resolve(TodoRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        container.register(CreateTodoUseCaseProtocol.self) { resolver in
            CreateTodoUseCase(todoRepository:
                                resolver.resolve(TodoRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
        container.register(CreateTodoSubscriptionUseCaseProtocol.self) { resolver in
            CreateTodoSubscriptionUseCase(todoRepository:
                                resolver.resolve(TodoRepositoryProtocol.self)!
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {

    @MainActor
    private func injectViewModels() {
        container.register(TodoViewModel.self) { resolver in
            TodoViewModel(
                getTodosUseCase: resolver.resolve(GetTodosUseCaseProtocol.self)!,
                createTodoUseCase: resolver.resolve(CreateTodoUseCaseProtocol.self)!,
                createTodoSubscriptionUseCase: resolver.resolve(CreateTodoSubscriptionUseCaseProtocol.self)!
            )
        }
    }
}
