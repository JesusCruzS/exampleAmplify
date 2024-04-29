import SwiftUI

struct TodoView: View {
    @StateObject private var todoViewModel = Resolver.shared.resolve(TodoViewModel.self)

    var body: some View {
        VStack(spacing: 20) {
            Text("Create Todo")
                .font(.title2)
            
            VStack(spacing: 10) {
                InputField(label: "Name", text: $todoViewModel.name)
                InputField(label: "Description", text: $todoViewModel.description)
                
                Button(action: {
                    Task {
                        await todoViewModel.createTodo()
                        todoViewModel.resetFields()
                    }
                }) {
                    Text("Create")
                }
                .padding(.top, 10)
                .buttonStyle(DefaultButtonStyle())
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("All Todos")
                    .font(.title2)
                    .padding(.horizontal, 30)
                
                List {
                    ForEach(todoViewModel.todos.indices, id: \.self) { index in
                        Text(todoViewModel.todos[index].name)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }.listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
            }
            .onAppear {
                Task {
                    await todoViewModel.getTodos()
                }
            }
        }.onAppear {
            Task {
                await todoViewModel.createSubscription()
            }
        }
    }
}

struct InputField: View {
    var label: String
    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label).font(.system(size: 16))
            TextField(label, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}
