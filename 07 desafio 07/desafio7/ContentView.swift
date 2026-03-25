//
//  SwiftUIView7.swift
//  desafio7
//
//  Created by Turma02-10 on 17/03/26.
//

import SwiftUI
import MapKit


//DEFINIR
struct Wonder: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let country: String
    let flag: String
    let year: String
    let builder: String
    let description: String
    let image: String
    let coordinate: CLLocationCoordinate2D

//FUNCTION
    static func == (lhs: Wonder, rhs: Wonder) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//MARAVILHAS (PAISE,ANOS,CONSTRUTORES)
let wonders: [Wonder] = [
    
//Cristo Redentor
    Wonder(
        name: "Cristo Redentor",
        country: "Brasil",
        flag: "🇧🇷",
        year: "1926–1931",
        builder: "Heitor da Silva Costa, Paul Landowski",
        description: "O Cristo Redentor é uma das estátuas mais famosas do mundo, localizada no topo do Morro do Corcovado, no Rio de Janeiro. Com 30 metros de altura (sem contar o pedestal), representa Jesus Cristo de braços abertos, simbolizando paz e acolhimento. Foi construído com concreto armado e pedra-sabão e se tornou um dos maiores símbolos do Brasil e do cristianismo no mundo.",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/Santa_Teresa%2C_Rio_de_Janeiro_-_State_of_Rio_de_Janeiro%2C_Brazil_-_panoramio_%2810%29.jpg/500px-Santa_Teresa%2C_Rio_de_Janeiro_-_State_of_Rio_de_Janeiro%2C_Brazil_-_panoramio_%2810%29.jpg",
        coordinate: CLLocationCoordinate2D(latitude: -22.9519, longitude: -43.2105)
    ),

    
//Machu Picchu
    Wonder(
        name: "Machu Picchu",
        country: "Peru",
        flag: "🇵🇪",
        year: "Século XV",
        builder: "Civilização Inca (Imperador Pachacuti)",
        description: "Machu Picchu é uma antiga cidade inca localizada nas montanhas dos Andes. Construída no século XV, acredita-se que tenha sido uma residência real ou um importante centro religioso. É famosa por suas construções de pedra perfeitamente encaixadas, sem uso de argamassa, e por sua localização impressionante entre montanhas e nuvens.",
        image: "https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg",
        coordinate: CLLocationCoordinate2D(latitude: -13.1631, longitude: -72.5450)
    ),

    
//Chichén Itzá
    Wonder(
        name: "Chichén Itzá",
        country: "México",
        flag: "🇲🇽",
        year: "Séculos V–XIII",
        builder: "Civilização Maia",
        description: "Chichén Itzá é um dos mais importantes sítios arqueológicos da civilização maia. Seu principal destaque é a pirâmide de Kukulcán, que demonstra conhecimentos avançados de astronomia. Durante os equinócios, a sombra forma uma serpente descendo pela escadaria da pirâmide.",
        image: "https://upload.wikimedia.org/wikipedia/commons/5/51/Chichen_Itza_3.jpg",
        coordinate: CLLocationCoordinate2D(latitude: 20.6843, longitude: -88.5678)
    ),

    
//Coliseu
    Wonder(
        name: "Coliseu",
        country: "Itália",
        flag: "🇮🇹",
        year: "72–82 d.C.",
        builder: "Imperador Vespasiano e Tito",
        description: "O Coliseu é um enorme anfiteatro localizado em Roma, utilizado para espetáculos públicos como lutas de gladiadores. Podia abrigar cerca de 50 mil pessoas e é considerado uma das maiores obras da engenharia romana. Representa o poder e a grandiosidade do Império Romano.",
        image: "https://super.abril.com.br/wp-content/uploads/2018/07/566f1d4c82bee174ca031716thinkstockphotos-4689787521.jpeg?quality=70&strip=info&w=1280&h=720&crop=1",
        coordinate: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922)
    ),

    
//Taj Mahal
    Wonder(
        name: "Taj Mahal",
        country: "Índia",
        flag: "🇮🇳",
        year: "1632–1653",
        builder: "Imperador Shah Jahan",
        description: "O Taj Mahal é um mausoléu construído em homenagem à esposa do imperador Shah Jahan. Feito de mármore branco, é considerado uma das construções mais bonitas do mundo. Sua arquitetura combina elementos islâmicos, persas e indianos, sendo símbolo de amor eterno.",
        image: "https://upload.wikimedia.org/wikipedia/commons/d/da/Taj-Mahal.jpg",
        coordinate: CLLocationCoordinate2D(latitude: 27.1751, longitude: 78.0421)
    ),

    
//Petra
    Wonder(
        name: "Petra",
        country: "Jordânia",
        flag: "🇯🇴",
        year: "Século IV a.C. – II d.C.",
        builder: "Civilização Nabateia",
        description: "Petra é uma cidade histórica esculpida em rochas rosadas no deserto da Jordânia. Foi um importante centro comercial na antiguidade. Sua estrutura mais famosa é o Tesouro (Al-Khazneh), esculpido diretamente na rocha.",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Al_Deir_Petra.JPG/330px-Al_Deir_Petra.JPG",
        coordinate: CLLocationCoordinate2D(latitude: 30.3285, longitude: 35.4444)
    ),

    
//Muralha da China
    Wonder(
        name: "Grande Muralha da China",
        country: "China",
        flag: "🇨🇳",
        year: "220 a.C. – 1644 d.C.",
        builder: "Diversas dinastias chinesas",
        description: "A Grande Muralha da China é uma das maiores construções já feitas pelo ser humano. Foi construída ao longo de séculos para proteger o território chinês contra invasões. Possui milhares de quilômetros de extensão e atravessa montanhas, desertos e planícies.",
        image: "https://static.nationalgeographicbrasil.com/files/styles/image_3200/public/nationalgeographic2710344.webp?w=760&h=509",
        coordinate: CLLocationCoordinate2D(latitude: 40.4319, longitude: 116.5704)
    )
]


// mapa e coordenadas
struct ContentView: View {

    @State private var selectedWonder: Wonder = wonders[0]

    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: wonders[0].coordinate,
            span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
        )
    )

    @State private var selectedAnnotation: Wonder?

    var body: some View {
        ZStack {

            Map(position: $position) {
                ForEach(wonders) { wonder in
                    Annotation(wonder.name, coordinate: wonder.coordinate) {
                        Button {
                            selectedAnnotation = wonder
                        } label: {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .ignoresSafeArea()

            VStack {
                Picker("Selecione", selection: $selectedWonder) {
                    ForEach(wonders) { wonder in
                        Text(wonder.name).tag(wonder)
                    }
                }
                .pickerStyle(.menu)
                .padding()
                .background(Color.white.opacity(0.9))
                .cornerRadius(10)
                .onChange(of: selectedWonder) {
                    withAnimation {
                        position = .region(
                            MKCoordinateRegion(
                                center: selectedWonder.coordinate,
                                span: MKCoordinateSpan(latitudeDelta: 40, longitudeDelta: 40)
                            )
                        )
                    }
                }

                Spacer()

                Text("Maravilhas do Mundo Moderno")
                    .padding(8)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
            }
        }
        .sheet(item: $selectedAnnotation) { wonder in
            WonderDetailView(wonder: wonder)
        }
    }
}

#Preview {
    ContentView()
}

