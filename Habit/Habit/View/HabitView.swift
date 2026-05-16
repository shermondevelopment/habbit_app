//
//  HabitView.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//
import SwiftUI

struct HabitView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    
    
    
    var body: some View {
        
        ZStack {
            if case HabitUIState.loading = viewModel.uiState {
                progress
            } else {
                NavigationView {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 12) {
                            if !viewModel.isCharts {
                                topContainer
                                addButton
                            }   
                            if case HabitUIState.emptyList = viewModel.uiState {
                                Spacer(minLength: 40)
                                VStack {
                                    Image(systemName: "exclamationmark.octagon.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24, alignment: .center)
                                    Text("Nenhum hábito Encontrado 😞.")
                                }
                            } else if case HabitUIState.fullList(let rows) = viewModel.uiState {
                                LazyVStack {
                                    //ForEach(rows, content: HabitCardView.init(viewModel:))
                                    ForEach(rows) { row in
                                        HabitCardView(isCharts: viewModel.isCharts,
                                                      viewModel: row)
                                    }
                                } .padding(.horizontal, 10)
                            }
                        }
                    }.navigationTitle("Meus Hábitos")
                }
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(
                        title: Text("Ops"),
                        message: Text("Falha"),
                        primaryButton: .default(Text("Sim")) {
                            viewModel.onAppear()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }
        }
        .onAppear {
            if !viewModel.opened {
                self.viewModel.onAppear()
            }
        }
    }
}

extension HabitView {
    var progress: some View {
        ProgressView()
    }
}

extension HabitView {
    var topContainer: some View {
        VStack(alignment: .center, spacing: 12) {
            Image(systemName: "exclamationmark.triangle")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            
            Text(viewModel.title).font(.title).bold().foregroundColor(.orange)
            Text(viewModel.description).font(.title3).bold().foregroundColor(Color("textColor"))
            Text(viewModel.headLine).font(.subheadline).foregroundColor(Color("textColor"))
        }.frame(maxWidth: .infinity)
            .padding(.vertical, 32)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }
}

extension HabitView {
    var addButton: some View {
        NavigationLink(
            destination: Text("tela de adicionar")
                .frame(maxWidth: .infinity, maxHeight: .infinity)) {
                    Label("Criar Hábito", systemImage: "plus.app")
                        .modifier(ButtonStyle())
                }.padding(.horizontal, 16)
    }
}

#Preview {
    HabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor()))
}

#Preview {
    HabitView(viewModel: HabitViewModel(isCharts: false, interactor: HabitInteractor())).preferredColorScheme(.dark)
}

