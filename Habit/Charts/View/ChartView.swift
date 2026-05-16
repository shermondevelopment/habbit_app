//
//  ChartView.swift
//  Habit
//
//  Created by VITOR SHERMON on 15/05/26.
//
import SwiftUI
import Foundation
import Charts

struct Sale: Identifiable {
    let id = UUID()
    let day: String
    let value: Int
}

struct ChartView: View {
    @ObservedObject var chartViewModel: ChartViewModel
    
    var body: some View {
        VStack {
            UILabelView(text: "Gráfico")
                .font(.title)
                .foregroundColor(.orange)
                .frame(height: 50)
                .padding(.horizontal, 20)
            Chart(chartViewModel.entries) { item in
                
                LineMark(
                    x: .value("Dia", item.date),
                    y: .value("Vendas", item.value)
                )
                .foregroundStyle(.orange.gradient)
                .interpolationMethod(.monotone)
                .lineStyle(StrokeStyle(lineWidth: 2))
                
                AreaMark(
                    x: .value("Dia", item.date),
                    y: .value("Vendas", item.value)
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [.orange.opacity(0.4), .clear],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                
                PointMark(
                    x: .value("Dia", item.date),
                    y: .value("Vendas", item.value)
                )
                .foregroundStyle(.orange)
                .symbolSize(40)
            }
            .animation(.easeInOut, value: chartViewModel.entries.count)
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 300)
            .padding(.horizontal, 20)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

// usar ui label do uikit no swift iu

struct UILabelView: UIViewRepresentable {
    typealias UIViewType = UILabel
    
    var text: String
    
    func makeUIView(context: Context) -> UILabel {
        let lb = UILabel()
        return lb
    }
    
    func updateUIView(_ uiView: UILabel, context: Context) {
        uiView.text = text
        uiView.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        uiView.textColor = UIColor.orange
    }
}

#Preview {
    ChartView(chartViewModel: ChartViewModel())
}
