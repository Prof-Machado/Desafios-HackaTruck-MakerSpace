import SwiftUI

struct Conteudo: Identifiable {

    let id = UUID()
    let nome: String
    let ano: String
    let genero: String
    let categoria: String
    let pais: String
    let imdb: String
    let imagem: String
}



let filmes: [Conteudo] = [

    Conteudo(nome: "O Poderoso Chefão",
             ano: "1972",
             genero: "Crime",
             categoria: "Filme",
             pais: "🇺🇸",
             imdb: "9.2",
             imagem: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg"),

    Conteudo(nome: "Parasita",
             ano: "2019",
             genero: "Drama",
             categoria: "Filme",
             pais: "🇰🇷",
             imdb: "8.5",
             imagem: "https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg"),

    Conteudo(nome: "Flow",
             ano: "2024",
             genero: "Aventura",
             categoria: "Filme",
             pais: "🇱🇻",
             imdb: "7.9",
             imagem: "https://preview.redd.it/poster-to-the-movie-flow-2024-a-feature-animated-film-with-v0-7dlhihi8r85e1.jpeg?auto=webp&s=e0de7a3fa3dd73fbdae471235b6b27569a823463"),

    Conteudo(nome: "Ainda Estou Aqui",
             ano: "2024",
             genero: "Drama",
             categoria: "Filme",
             pais: "🇧🇷",
             imdb: "8.4",
             imagem: "https://upload.wikimedia.org/wikipedia/pt/thumb/5/57/Ainda_Estou_Aqui_2024_poster.jpg/330px-Ainda_Estou_Aqui_2024_poster.jpg"),

    Conteudo(nome: "Nada de Novo no Front",
             ano: "2022",
             genero: "Guerra",
             categoria: "Filme",
             pais: "🇩🇪",
             imdb: "7.8",
             imagem: "https://image.tmdb.org/t/p/w500/hYqOjJ7Gh1fbqXrxlIao1g8ZehF.jpg")
]



let series: [Conteudo] = [

    Conteudo(nome: "Stranger Things",
             ano: "2016",
             genero: "Ficção",
             categoria: "Série",
             pais: "🇺🇸",
             imdb: "8.7",
             imagem: "https://image.tmdb.org/t/p/w500/49WJfeN0moxb9IPfGn8AIqMGskD.jpg"),

    Conteudo(nome: "The Office",
             ano: "2005",
             genero: "Comédia",
             categoria: "Série",
             pais: "🇺🇸",
             imdb: "9.0",
             imagem: "https://image.tmdb.org/t/p/w500/qWnJzyZhyy74gjpSjIXWmuk0ifX.jpg"),

    Conteudo(nome: "La Casa de Papel",
             ano: "2017",
             genero: "Crime",
             categoria: "Série",
             pais: "🇪🇸",
             imdb: "8.2",
             imagem: "https://image.tmdb.org/t/p/w500/reEMJA1uzscCbkpeRJeTT2bjqUp.jpg"),

    Conteudo(nome: "The Last of Us",
             ano: "2023",
             genero: "Drama",
             categoria: "Série",
             pais: "🇺🇸",
             imdb: "8.8",
             imagem: "https://image.tmdb.org/t/p/w500/uKvVjHNqB5VmOrdxqAt2F7J78ED.jpg"),

    Conteudo(nome: "Breaking Bad",
             ano: "2008",
             genero: "Crime",
             categoria: "Série",
             pais: "🇺🇸",
             imdb: "9.5",
             imagem: "https://image.tmdb.org/t/p/w500/ggFHVNu6YYI5L9pCfOacjizRGt.jpg")
]



struct CardLista: View {

    let item: Conteudo

    var body: some View {

        HStack {

            AsyncImage(url: URL(string: item.imagem)) { image in
                image
                    .resizable()
                    .scaledToFill()

            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .cornerRadius(6)

            VStack(alignment: .leading) {

                Text(item.nome)
                    .font(.headline)

                Text(item.ano)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(item.pais)
        }
        .padding(8)
        .background(.white.opacity(0.9))
        .cornerRadius(10)
    }
}



struct ContentView: View {

    var body: some View {

        NavigationStack {

            ZStack {

                LinearGradient(
                    gradient: Gradient(colors: [.white, .black]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {

                    VStack(alignment: .leading, spacing: 15) {

                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                            )
                            .shadow(radius: 5)
                            .frame(maxWidth: .infinity)
                        Spacer()
                        Spacer()

                        Text("FILMES")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)

                        ForEach(filmes) { filme in

                            NavigationLink(destination: DetalheView(item: filme)) {

                                CardLista(item: filme)
                            }
                        }
                        Spacer()

                        Text("SÉRIES")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)

                        ForEach(series) { serie in

                            NavigationLink(destination: DetalheView(item: serie)) {

                                CardLista(item: serie)
                            }
                        }
                        Spacer()
                        Text("Recomendados")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.white)
                            .padding(.top)

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 15) {

                                ForEach(filmes) { item in

                                    AsyncImage(url: URL(string: item.imagem)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()

                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 120, height: 170)
                                    .cornerRadius(12)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}



struct DetalheView: View {

    let item: Conteudo

    var body: some View {

        ZStack {

            Color("Background")
                .ignoresSafeArea()

            VStack(spacing: 20) {

                AsyncImage(url: URL(string: item.imagem)) { image in
                    image
                        .resizable()
                        .scaledToFit()

                } placeholder: {
                    ProgressView()
                }
                .frame(height: 350)
                .cornerRadius(20)

                Text(item.nome)
                    .font(.title)
                    .foregroundColor(.white) // texto amarelo

                Text("Categoria: \(item.categoria)")
                    .foregroundColor(.gray)

                Text("Ano: \(item.ano)")
                    .foregroundColor(.gray)

                Text("Gênero: \(item.genero)")
                    .foregroundColor(.gray)

                Text("País: \(item.pais)")
                    .foregroundColor(.gray)

                // IMDb com contorno e sombra amarela
                Text("IMDb: \(item.imdb)")
                    .font(.title2)
                    .bold()
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.yellow, lineWidth: 2)
                            .shadow(color: .yellow, radius: 4)
                    )
                    .foregroundColor(.white)

                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
