//
//  ContentView.swift
//  GroupGenerator
//
//  Created by peter wi on 3/5/22.
//

import SwiftUI

struct ContentView: View {
    @State private var people: [String] = []
    @State private var person: String = ""
    @State private var numberPerGroup: Int = 2
    
    private enum Field: Int, Hashable {
        case name, number
    }
    @FocusState private var focusedField: Field?
    
    var body: some View {
        NavigationView {
            List {
                Section("How many people in each group?") {
                    TextField("Type Number", value: $numberPerGroup, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .onSubmit {
                            focusedField = .name
                        }
                        .focused($focusedField, equals: .number)
                }
                
                Section("Who wants to be grouped?") {
                    TextField("Type Name", text: $person)
                        .disableAutocorrection(true)
                        .onSubmit {
                            people.append(person)
                            person = ""
                            focusedField = .name
                        }
                        .focused($focusedField, equals: .name)
                }
                
                NavigationLink(destination: ResultView(people: $people, numberPerPerson: $numberPerGroup)) {
                    HStack{
                        Spacer()
                        Text("GET THE RESULT")
                            .foregroundColor(.blue)
                            .font(.headline)
                        Spacer()
                    }
                }
                .disabled(numberPerGroup==0 || people.count==0)
                
                Section("List of signed people - \(people.count) people") {
                    ForEach(people.reversed(), id: \.self) { person in
                        Text(person)
                    }
                    .onDelete(perform: removeRows)
                }
                
                
            }
            .navigationTitle("Group Us")
            .onAppear {
                focusedField = .name
            }
        }
    }
    func removeRows(at offsets: IndexSet) {
        people.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
