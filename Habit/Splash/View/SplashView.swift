//
//  SplashView.swift
//  Habit
//
//  Created by VITOR SHERMON on 25/04/26.
//

import SwiftUI
import Observation

struct SplashView: View {
    
    @ObservedObject var viewModel: SplashViewModel
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .loading:
                    loadingView()
                case .goToSignInScreen:
                    viewModel.signinView()
                case .goToHomeScreen:
                viewModel.homeView()
                case .error(let msg):
                    loadingView(error: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}
// var em envs
//extension SplashView {
//    var loading: some View {
//        ZStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .padding(40)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}


//struct LoadingView: View {
//    var body: some View {
//        ZStack {
//            Image("logo")
//                .resizable()
//                .scaledToFit()
//                .padding(40)
//                .background(Color.white)
//                .ignoresSafeArea()
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//    }
//}

extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .padding(40)
                .ignoresSafeArea()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .alert(isPresented: .constant(error != nil)) {
                Alert(title: Text("Habit"), message: Text(error ?? "default error"), dismissButton: .default(Text("Ok")))
            }
   }
}

#Preview {
    SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
}

#Preview {
    SplashView(viewModel: SplashViewModel(interactor: SplashInteractor())).preferredColorScheme(.dark)
}

