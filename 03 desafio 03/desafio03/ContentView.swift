import SwiftUI



struct ContentView: View {
    
    @State private var nome: String = ""
    @State private var mostrarAlerta = false
    
    var body: some View {
        VStack {
            
            // Texto do topo
            Text("Bem vindo, \(nome)")
                .font(.title)
                .padding(.top, 10)
            Spacer()
            // Campo para digitar o nome
            TextField("Digite seu nome", text: $nome)
                .textFieldStyle(.roundedBorder)
                .padding()
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Imagem no meio
            Image("download_IMG_desafio02")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: 220)
                .clipped()
                .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 5)

            Text("UFPA")
                .font(.title)
                .fontWeight(.bold)

            Text("Universidade Federal do Pará")
                .font(.headline)

            Text("Belém/PA")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
            
            // Botão embaixo
            Button("Entrar") {
                mostrarAlerta = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .alert("Olá \(nome)!", isPresented: $mostrarAlerta) {
                Button("INICIAR", role: .cancel) { }
            } message: {
                Text("Vamos lá!!")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
