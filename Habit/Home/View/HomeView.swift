//
//  HomeView.swift
//  Habit
//
//  Created by VITOR SHERMON on 26/04/26.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Group {
            Menu {
                Button("Sair") {
                   print("Logout")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            Text("Olá home page")
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel())
}
