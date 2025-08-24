//
//  ContentView.swift
//  WishList
//
//  Created by Anderson Pereira Dos Santos on 24/08/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var desejos: [Wish]
    
    @State private var isAlertShowing: Bool = false
    @State private var titulo: String = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(desejos) { desejo in
                    Text(desejo.title)
                        .font(.title3.weight(.medium))
                        .padding(.vertical, 4)
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(desejo)
                            } label: {
                                Image(systemName: "trash")
                            }
                        }
                }
            }//: Lista
            .navigationTitle("Lista de Desejos")
            .toolbar {
                ToolbarItem {
                    Button {
                        isAlertShowing.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                }
                if !desejos.isEmpty {
                    ToolbarItem(placement: .bottomBar) {
                        Text("\(desejos.count) desejo\(desejos.count > 1 ? "s" : "")")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .alert("Adicionar novo desejo", isPresented: $isAlertShowing) {
                TextField("Escreva seu desejo...", text: $titulo)
                
                Button("Adicionar") {
                    modelContext.insert(Wish(title: titulo))
                    titulo = ""
                }
                Button("Cancelar", role: .cancel) {}
            }
            .overlay {
                if desejos.isEmpty {
                    ContentUnavailableView(
                        "Minha Lista de Desejos",
                        systemImage: "heart.circle.fill",
                        description: Text("Nenhum desejo adicionado ainda.\nQue tal adicionar o primeiro?")
                    )
                    .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview("Lista com Dados de Exemplo") {
    let container = try! ModelContainer(for: Wish.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    
    container.mainContext.insert(Wish(title: "Fazer um curso avançado de Swift"))
    container.mainContext.insert(Wish(title: "Comprar o novo iPhone"))
    container.mainContext.insert(Wish(title: "Aprofundar em SwiftUI"))
    container.mainContext.insert(Wish(title: "Comprar o novo MacBook"))
    container.mainContext.insert(Wish(title: "Viajar para a Europa"))
    container.mainContext.insert(Wish(title: "Assistir um jogo no Santiago Bernabéu"))
    
    return ContentView()
        .modelContainer(container)
}

#Preview("Lista Vazia") {
    ContentView()
        .modelContainer(for: Wish.self, inMemory: true)
}
