//
//  HomeView.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.habitView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Habitos")
                }
                .tag(0)
            Text("Conteúdo de gráficos \(selection)")
                 .tabItem {
                     Image(systemName: "chart.bar")
                     Text("Gráficos")
                 }.tag(1)
            Text("Conteúdo do perfil \(selection)")
                .tabItem() {
                     Image(systemName: "person.crop.circle")
                     Text("Perfil")
                }.tag(2)
        }
        .background(.white)
            .accentColor(.orange)
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
