//
//  CreateTodoSubscription.swift
//  Todo
//
//  Created by Jesus Cruz Suárez on 26/04/24.
//

import Combine

public protocol CreateTodoSubscriptionUseCaseProtocol {
    func execute() async throws -> Todo
}
