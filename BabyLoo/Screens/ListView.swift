//
//  ListView.swift
//  BabyLoo
//
//  Created by Selvarajan on 21/01/22.
//

import SwiftUI

struct ListView: View {
    @StateObject var looListVM = LooListViewModel()
    
    let yellow: Color = Color(hex: "EDC126")
    
    // check below url to get grouped records
    // https://www.hackingwithswift.com/forums/swiftui/grouped-table-by-object-s-date-property/4322
    
    var body: some View {
            List {
                ForEach(looListVM.looAllEntries, id:\.id) {loo in
                    HStack(spacing: 10) {
                        Image(loo.pee ? "baby": "baby-boy")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .padding(.horizontal, 5)
                        
                        Text("\(loo.pee ? "Pee" : "Poo")").font(.subheadline)
                        
                        Text("\(loo.timestamp.displayDate())")
                            .font(.subheadline)
                        
                        Spacer()
                        Text("\(loo.timestamp.displayTime())")
                            .font(.subheadline)
                    }
                }
            }
            .colorMultiply(yellow)
            .navigationTitle("All Loo Entries")
            .onAppear {
                looListVM.getAllLooEntries()
            }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
