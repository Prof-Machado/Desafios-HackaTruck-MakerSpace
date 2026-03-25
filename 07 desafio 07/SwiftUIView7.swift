//
//  SwiftUIView7.swift
//  desafio7
//
//  Created by Turma02-10 on 17/03/26.
//

import SwiftUI

struct WonderDetailView: View {
    let wonder: Wonder

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                AsyncImage(url: URL(string: wonder.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 250)
                }

                VStack(alignment: .leading, spacing: 8) {

                    Text(wonder.name)
                        .font(.title)
                        .bold()

                    Text("\(wonder.flag) \(wonder.country)")
                        .font(.headline)

                    Text("📅 Ano: \(wonder.year)")
                    Text("👷 Construído por: \(wonder.builder)")

                    Divider()

                    Text(wonder.description)
                        .font(.body)
                }
                .padding()

                Spacer()
            }
        }
    }
}
