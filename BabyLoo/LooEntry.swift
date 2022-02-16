//
//  LooEntry.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

struct LooEntry: View {
    @ObservedObject var looListVM: LooListViewModel
    
    @StateObject var addLooVM = AddLooViewModel()
    @Binding var listDate: Date
    
    func refreshEntries() {
        looListVM.getLooEntriesFor(date: listDate)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("TODAY")
                .font(.title3)
                .padding(5)
                .foregroundColor(.black)
                .background(
                    Rectangle()
                        .fill(.white.opacity(0.7)))

            HStack{
                Image("baby")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 10)
                VStack(alignment: .leading) {
                    Text("Pee")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                    Text("last at \(looListVM.lastPee)").font(.footnote).foregroundColor(.gray)
                }
                Spacer()

                Button {
                    addLooVM.pee = true
                    addLooVM.poo = false
                    addLooVM.timestamp = Date()
                    addLooVM.save()
                    refreshEntries()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .background(Circle().foregroundColor(.black).opacity(0.5))
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }
            }.padding(10).background(.white.opacity(0.35))

            HStack{
                Image("baby-boy")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 10)
                VStack(alignment: .leading) {
                    Text("Poo")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                    Text("last at \(looListVM.lastPoo)").font(.footnote).foregroundColor(.gray)
                }
                Spacer()

                Button {
                    addLooVM.pee = false
                    addLooVM.poo = true
                    addLooVM.timestamp = Date()
                    addLooVM.save()
                    refreshEntries()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .background(Circle().foregroundColor(.black).opacity(0.5))
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }
            }.padding(10).background(.white.opacity(0.35))
            //                        Divider()
        }
        .padding(15)
        .background(.white.opacity(0.25))
        .cornerRadius(15)
        .padding(.vertical, 10)
        .onAppear {
            refreshEntries()
        }
    }
}

//struct LooEntry_Previews: PreviewProvider {
//    static var previews: some View {
//        LooEntry(peeCount: .constant(0), pooCount: .constant(0))
//    }
//}
