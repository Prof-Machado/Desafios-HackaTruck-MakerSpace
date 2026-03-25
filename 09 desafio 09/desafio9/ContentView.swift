import SwiftUI

// MARK: - MODEL
struct Jogo: Identifiable, Codable {
    var id: Int?
    var nome: String
    var jogadores: Int
    var tempo: Int
    var descricao: String
}

// MARK: - LISTA
struct ListaJogosView: View {
    @State private var jogos: [Jogo] = [
        Jogo(id: 1, nome: "Coup", jogadores: 6, tempo: 30, descricao: ""),
        Jogo(id: 2, nome: "Catan", jogadores: 5, tempo: 60, descricao: ""),
        Jogo(id: 3, nome: "Root", jogadores: 4, tempo: 120, descricao: ""),
        Jogo(id: 4, nome: "Pandemic", jogadores: 4, tempo: 45, descricao: "")
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                
                Image("boardgames")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Jogos de Tabuleiro")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    ForEach(jogos) { jogo in
                        NavigationLink(destination: DetalheJogoView(jogo: jogo)) {
                            HStack {
                                Text(jogo.nome)
                                    .foregroundColor(.white)
                                
                                Spacer()
                                
                                Text("\(jogo.tempo) min")
                                    .foregroundColor(.white)
                                
                                Text("\(jogo.jogadores) Jogadores")
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: NovoJogoView()) {
                        Text("Adicionar Novo Jogo")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.red)
                            .cornerRadius(25)
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.red)
            }
            .ignoresSafeArea(edges: .top)
        }
        .onAppear {
            APIService.shared.fetchJogos { jogosAPI in
                self.jogos = jogosAPI
            }
        }
    }
}

// MARK: - DETALHE
struct DetalheJogoView: View {
    var jogo: Jogo
    
    var body: some View {
        VStack(spacing: 0) {
            
            Image("boardgames")
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
            
            VStack(spacing: 16) {
                
                Text(jogo.nome)
                    .font(.title)
                    .foregroundColor(.red)
                
                HStack {
                    Text("\(jogo.jogadores) Jogadores")
                    Text("\(jogo.tempo) minutos")
                }
                .foregroundColor(.red)
                
                Text(jogo.descricao.isEmpty ?
                     "Jogo competitivo que ganha o último jogador a sobreviver"
                     : jogo.descricao)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Button("Baixar") {}
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
                Spacer()
                
                NavigationLink(destination: NovoJogoView()) {
                    Text("Adicionar Novo Jogo")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
            }
            .padding()
            .frame(maxHeight: .infinity)
        }
    }
}

// MARK: - NOVO JOGO
struct NovoJogoView: View {
    @State private var nome = ""
    @State private var jogadores = ""
    @State private var tempo = ""
    @State private var descricao = ""
    
    var body: some View {
        VStack {
            
            Text("Novo Jogo")
                .font(.title)
                .foregroundColor(.red)
                .padding()
            
            VStack(spacing: 12) {
                
                TextField("Nome do Jogo", text: $nome)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Qtd de Jogadores", text: $jogadores)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                TextField("Tempo de Jogo", text: $tempo)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                
                TextField("Descrição do Jogo", text: $descricao)
                    .textFieldStyle(.roundedBorder)
            }
            .padding()
            
            Spacer()
            
            Button("Criar Novo Jogo") {
                criarJogo() // 👈 chama a função
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(25)
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    // 👇 FUNÇÃO CRIAR JOGO
    func criarJogo() {
        // Cria o objeto Jogo
        let novo = Jogo(
            id: nil,
            nome: nome,
            jogadores: Int(jogadores) ?? 0,
            tempo: Int(tempo) ?? 0,
            descricao: descricao
        )
        
        // Chama o serviço da API
        APIService.shared.criarJogo(jogo: novo) {
            print("Salvo no Node-RED")
        }
    }
}
#Preview {
    ListaJogosView() // 
}





