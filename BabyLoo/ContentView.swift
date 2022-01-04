//
//  ContentView.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

struct RowItem: View {
    @State var text: String = ""
    @State var loo: Loo
    @Binding var needsRefresh: Bool
    
    let coreDM = CoreDataProvider.shared
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination: LooDetail(loo: loo, needsRefresh: $needsRefresh)) {
                    Text(text).font(.subheadline).foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    coreDM.deleteLoo(loo: loo)
                    needsRefresh.toggle()
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .opacity(0.6)
                        .frame(width: 20, height: 20)
                        .padding(.horizontal)
                    //                            .background(Circle().stroke(.black, lineWidth: 2))
                }
            }
            Divider()
        }
    }
}

struct ContentView: View {
    @State private var showHome = false
    @State private var looEntries: [Loo] = [Loo]()
    @State var peeCount: Int = 0
    @State var pooCount: Int = 0
    @State var needsRefresh: Bool = false
    
    let yellow: Color = Color(hex: "EDC126")
    let coreDM = CoreDataProvider.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                yellow.ignoresSafeArea()
                ScrollView {
                    VStack {
                        LooEntry(peeCount: $peeCount, pooCount: $pooCount, needsRefresh: $needsRefresh)
                            .background(yellow)
                            .padding(.vertical)
                        
                        VStack (alignment: .leading) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Spacer()
                                
                                VStack {
                                    Text("Jan 1, 2022").font(.title2).bold().foregroundColor(.black)
                                    Text("Entries").font(.caption)
                                }
                                
                                Spacer()
                                Image(systemName: "chevron.right")
                                
                            }.padding(.horizontal)
                            
                            Divider()
                            
                            HStack(alignment: .top) {
                                VStack(alignment: .leading) {
                                    Text("Poo").font(.title3).bold().padding(.vertical, 5).frame(maxWidth: .infinity, alignment: .leading)
                                        
                                    Divider()
                                    ForEach(looEntries, id:\.self) {loo in
                                        if loo.poo {
                                            RowItem(text: "\(loo.timestamp?.displayTime() ?? "")", loo: loo, needsRefresh: $needsRefresh)
                                        }
                                    }
                                }.padding()
                                
                                VStack(alignment: .leading) {
                                    Text("Pee").font(.title3).bold().padding(.vertical, 5).frame(maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                    
                                    ForEach(looEntries, id:\.self) {loo in
                                        if loo.pee {
                                            RowItem(text: "\(loo.timestamp?.displayTime() ?? "")", loo: loo, needsRefresh: $needsRefresh)
                                        }
                                    }
                                }.padding()
                            }
                            .onAppear {
                                getLooEntries()
                            }
                            .accentColor(needsRefresh && peeCount != 0 && pooCount != 0 ? .white : .black)
                            .onChange(of: needsRefresh) { poo in
                                getLooEntries()
                            }
//                            .onChange(of: peeCount) { pee in
//                                getLooEntries()
//                            }
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
                            getLooEntries()
                        }
                }
                
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Image(systemName: "chart.bar.fill")
                        .foregroundColor(.black)
                }
            }
            
            
        } // navigationview
        
    }
    
    func getLooEntries() {
        looEntries = coreDM.getAllLoo()
    }
    
    func gotoHomeScreen(time: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
            //            withAnimation {
            self.showHome = true
            //            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
