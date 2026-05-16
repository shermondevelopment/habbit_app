//
//  HabitCardView.swift
//  Habit
//
//  Created by VITOR SHERMON on 04/05/26.
//

import SwiftUI
import Combine

struct HabitCardView: View {
    
    @State private var action: Bool = false
    
    let isCharts: Bool
    let viewModel: HabitCardViewModel
    
    init(isCharts: Bool, viewModel: HabitCardViewModel) {
        self.isCharts = isCharts
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        ZStack(alignment: .trailing) {
            
            if isCharts {
                NavigationLink(
                    destination: viewModel.chartView(),
                    isActive: self.$action,
                    label: {
                        EmptyView()
                    }
                )
            } else {
                NavigationLink(
                    destination: viewModel.HabitDetailView(),
                    isActive: self.$action,
                    label: {
                        EmptyView()
                    }
                )
            }
            
            Button(action: {
                self.action = true
            }, label: {
                HStack {
                    ImageView(url: viewModel.icon)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 32, height: 32)
                        .clipped()
//                    Image(systemName: "pencil")
//                        .padding(.horizontal, 8)
                    
                    Spacer()
                    
                    HStack(alignment: .top) {
                        Spacer()
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.name)
                                .foregroundColor(.orange)
                            Text(viewModel.label)
                                .foregroundColor(Color("textColor"))
                                .bold()
                            Text(
                                viewModel.date?.toBRString() ?? "sem data"
                            )
                            .foregroundColor(Color("textColor"))
                            .bold()
                        }.frame(maxWidth: 300, alignment: .leading)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4){
                            Text("Registrado").foregroundColor(.orange)
                                .bold()
                                .multilineTextAlignment(.leading)
                            Text(String(viewModel.value ?? 0)).foregroundColor(Color("textColor"))
                                .bold()
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
                .cornerRadius(4)
            })
            if !isCharts {
                Rectangle()
                    .frame(width: 8)
                    .foregroundColor(viewModel.state)
            }

        }
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(.orange, lineWidth: 1.4)
                .shadow(color: Color.gray, radius: 2, x: 2.0, y: 2.0)
            
        )
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationView {
        List {
            HabitCardView(
                isCharts: false,
                viewModel: HabitCardViewModel(
                    id: 1,
                    icon: "https://placehold.co/150",
                    date: Date(),
                    name: "Test",
                    label: "Rere",
                    value: 12,
                    state: .yellow,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                )
            )
            HabitCardView(
                isCharts: false,
                viewModel: HabitCardViewModel(
                    id: 1,
                    icon: "https://placehold.co/150",
                    date: Date(),
                    name: "Test",
                    label: "Rere",
                    value: 12,
                    state: .yellow,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                )
            )
        }
        .listStyle(.plain)
        .swipeActions {
            Button(role: .destructive) {
                // aqui
            } label: {
                Label("Apagar", systemImage: "trash")
            }
        }
        .frame(maxWidth: .infinity)
        .navigationTitle("Teste")
    }
}
#Preview {
    NavigationView {
        List {
            HabitCardView(
                isCharts: false,
                viewModel: HabitCardViewModel(
                    id: 1,
                    icon: "swift",
                    date: Date(),
                    name: "Test",
                    label: "Rere",
                    value: 12,
                    state: .yellow,
                    habitPublisher: PassthroughSubject<Bool, Never>()
                )
            )
        }.listStyle(.plain)
    }.preferredColorScheme(.dark)
}
