//
//  HabitDetailView.swift
//  Habit
//
//  Created by VITOR SHERMON on 06/05/26.
//
import SwiftUI
import Combine

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitDetailViewModel
    
    @FocusState private var isFocused: Bool
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .center, spacing: 12) {
                Text("View model")
                    .foregroundColor(Color.orange)
                    .font(.title.bold())
                Text("Unidades: \(viewModel.label)\n")
            }
            VStack {
                TextField("Escreva aqui  o valor contido na habit", text: $viewModel.value)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.numberPad)
                    .focused($isFocused)
                
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                
            }.padding(.horizontal, 32)
            
            VStack(spacing: 12){
                Text("Todos os registros devem ser feitos em até 24 horas\n Habitos se constroem todos os dias 👌🏻")
                    .multilineTextAlignment(.center)
            }.padding(.top, 20)
            
            LoadingButtonView(action: {
                viewModel.save()
            }, text: "Salvar",
                              disabled: viewModel.value.isEmpty,
                              loading: viewModel.uiState == .loading
            ).padding(.horizontal, 16)
                .padding(.vertical, 8)
            
            Button("Cancelar") {
                // dimiss or pop exit
                isFocused = false
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 2)) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .modifier(ButtonStyle())
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            
            Spacer()
        }
        .padding(.horizontal, 10)
        .padding(.top, 22)
        .onAppear {
            viewModel.$uiState.sink { uiState in
                if uiState == .success {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }.store(in: &viewModel.cancellables)
        }
    }
}

#Preview {
    HabitDetailView(viewModel: HabitDetailViewModel(
        id: 1,
        name: "Test",
        label: "Test",
        interactor: HabitDetailInteractor()
    )).preferredColorScheme(.light)
}

#Preview() {
    HabitDetailView(viewModel: HabitDetailViewModel(
        id: 1,
        name: "Test",
        label: "Test",
        interactor: HabitDetailInteractor()
    )).preferredColorScheme(.dark)
}
