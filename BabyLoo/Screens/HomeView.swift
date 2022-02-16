//
//  ContentView.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var looListVM = LooListViewModel()
    @State private var showHome = false
    @State var listDate: Date = Date()
    
    let yellow: Color = Color(hex: "EDC126")
    //    let yellow: Color = Color(.white)
//    let coreDM = CoreDataProvider.shared
    
    func displayListDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, YYYY"
        
        return dateFormatter.string(from: listDate)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                yellow.ignoresSafeArea()
                ScrollView {
                    VStack {
                        LooEntry(looListVM: looListVM, listDate: $listDate)
                            .background(yellow)
                            .padding(.vertical)
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Button {
                                    let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: listDate)!
                                    listDate = modifiedDate
                                    looListVM.getLooEntriesFor(date: modifiedDate)
                                } label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10.0)
                                                        .fill(.white.opacity(0.2)))
                                }
                                Spacer()
                                
                                VStack {
                                    Text(displayListDate()).font(.title2).bold().foregroundColor(.black)
                                    Text("Entries").font(.caption)
                                }
                                
                                Spacer()
                                Button {
                                    let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: listDate)!
                                    listDate = modifiedDate
                                    looListVM.getLooEntriesFor(date: modifiedDate)
                                } label: {
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.black)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10.0)
                                                        .fill(.white.opacity(0.2)))
                                }
                            }.padding(.horizontal)
                            
                            Divider()
                            
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Poo (\(looListVM.getPooCount()))")
                                        .font(.title3)
                                        .bold()
                                        .padding(.vertical, 5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    Divider()
                                    ForEach(looListVM.looEntries, id:\.id) {loo in
                                        if loo.poo {
                                            LooItemView(
                                                looVM: $looListVM.looEntries[looListVM.looEntries.firstIndex(where: { $0.id
                                                    == loo.id })!],
                                                looListVM: looListVM,
                                                text: "\(loo.timestamp.displayTime())")
                                        }
                                    }
                                }.padding()
                                
                                VStack(alignment: .leading) {
                                    Text("Pee (\(looListVM.getPeeCount()))")
                                        .font(.title3)
                                        .bold()
                                        .padding(.vertical, 5)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                    
                                    ForEach(looListVM.looEntries, id:\.id) {loo in
                                        if loo.pee {
                                            LooItemView(
                                                looVM: $looListVM.looEntries[looListVM.looEntries.firstIndex(where: { $0.id
                                                    == loo.id })!],
                                                looListVM: looListVM,
                                                text: "\(loo.timestamp.displayTime() )")
                                        }
                                    }
                                }.padding()
                            }
                            .onAppear {
                                withAnimation {
                                    looListVM.getLooEntriesFor(date: listDate)
                                    
                                }
                            }
                        }
                    } //vstack
                    .padding()
                    .background(yellow)
                } // scroll view
                
                //Splash screen
                if !showHome {
                    ZStack {
                        yellow.ignoresSafeArea()
                        VStack() {
                            LottieView().frame(width: 300, height: 400)
                            
                            Text("Baby LOO")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                            Text("Tracker")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                        }
                        .onAppear(perform: {
                            self.gotoHomeScreen(time: 2.5)
                        })
                    }
                }
                
            } //ZStack
            .background(yellow)
            .navigationTitle("Baby Loo Tracker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.black)
                        .onTapGesture {
                            looListVM.getLooEntriesFor(date: listDate)
                        }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    NavigationLink(destination: ListView()) {
                        Image(systemName: "chart.bar.fill")
                            .foregroundColor(.black)
                    }
                }
            }
        } // navigationview
    }
    
    func gotoHomeScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            //            withAnimation {
            self.showHome = true
            //            }
        }
    }
}

struct LooListView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
