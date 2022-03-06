//
//  ResultView.swift
//  GroupGenerator
//
//  Created by peter wi on 3/5/22.
//

import SwiftUI

struct ResultView: View {
    @Binding var people: [String]
    @Binding var numberPerPerson: Int
    @State private var groups: [[String]] = []
    
    var body: some View {
        List {
            ForEach(groups.indices, id: \.self) { index in
                Section("Group \(index+1)") {
                    ForEach(groups[index], id: \.self) { person in
                        Text(person)
                    }
                }
            }
        }
        .onAppear {
            let shuffledPeople = people.shuffled()
            groups = shuffledPeople.chunked(into: numberPerPerson)
        }
        .navigationTitle("Result")
    }
    
}

//struct ResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultView()
//    }
//}

extension Array {
    func chunked(into size: Int) -> [[Element]]{
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size,count)])
        }
    }
}
