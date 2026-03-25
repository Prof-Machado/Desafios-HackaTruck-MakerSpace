 //
//  ContentView.swift
//  desafio12
//
//  Created by Turma02-10 on 24/03/26.
//

import SwiftUI
import Charts

struct SensorData: Identifiable, Hashable {
    let id = UUID()
    let umidade: Double
    let timestamp: Date
    
    init(from dict: [String: Any]) {
        if let u = dict["umidade"] as? Double {
            self.umidade = u
        } else if let uStr = dict["umidade"] as? String, let u = Double(uStr) {
            self.umidade = u
        } else {
            self.umidade = 0
        }
        self.timestamp = Date()
    }
}

class APIService {
    static let shared = APIService()
    
    func fetchDados(completion: @escaping ([SensorData]) -> Void) {
        guard let url = URL(string: "http://192.168.128.26:1880/leituraUFPA") else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
            
            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
                    let dados = jsonArray.map { SensorData(from: $0) }
                    DispatchQueue.main.async {
                        completion(dados)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            } catch {
                print("Erro ao decodificar JSON: \(error)")
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }.resume()
    }
}

struct ContentView: View {
    @State private var dados: [SensorData] = []
    @State private var carregando = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Umidade")
                .font(.title)
            
            if carregando {
                Text("Carregando...")
                    .foregroundColor(.gray)
            } else if dados.isEmpty {
                Text("Nenhum dado disponível")
                    .foregroundColor(.gray)
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(dados.sorted(by: { $0.timestamp < $1.timestamp })) { item in
                            HStack {
                                Text("\(item.timestamp.formatted(date: .omitted, time: .shortened))")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text(String(format: "%.2f %%", item.umidade))
                                    .bold()
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 200)
                
                Chart(dados.sorted(by: { $0.timestamp < $1.timestamp })) { item in
                    LineMark(
                        x: .value("Tempo", item.timestamp),
                        y: .value("Umidade", item.umidade)
                    )
                }
                .frame(height: 300)
            }
            
            Button("Atualizar") {
                carregar()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            carregar()
        }
    }
    
    func carregar() {
        carregando = true
        APIService.shared.fetchDados { retorno in
            dados = retorno
            carregando = false
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

