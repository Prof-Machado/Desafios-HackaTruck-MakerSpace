import Foundation

class APIService {
    static let shared = APIService()
    
    let baseURL = "http://SEU_IP:1880"
    
    func fetchJogos(completion: @escaping ([Jogo]) -> Void) {
        guard let url = URL(string: "http://127.0.0.1:1880/leituraUFPA") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let jogos = try? JSONDecoder().decode([Jogo].self, from: data)
                DispatchQueue.main.async {
                    completion(jogos ?? [])
                }
            }
        }.resume()
    }
    
    func criarJogo(jogo: Jogo, completion: @escaping () -> Void) {
        guard let url = URL(string: "http://127.0.0.1:1880/envioufpa") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(jogo)
        
        URLSession.shared.dataTask(with: request) { _, _, _ in
            DispatchQueue.main.async {
                completion()
            }
        }.resume()
    }
}
