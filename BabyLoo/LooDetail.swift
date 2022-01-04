//
//  LooDetail.swift
//  BabyLoo
//
//  Created by Selvarajan on 03/01/22.
//

import SwiftUI

struct LooDetail: View {
    let loo: Loo
    @State var timestamp : Date = Date()
    @State var poo : Bool = true
    @State var pee : Bool = false
    @State private var activityType = 0
    @Binding var needsRefresh : Bool
    
    let coreDM = CoreDataProvider.shared
    
    let yellow: Color = Color(hex: "EDC126")
    
    var body: some View {
        ZStack{
            yellow.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("You may change the values here.").padding(.horizontal, 10).font(.caption)
                VStack {
                    HStack(alignment: .center , spacing: 5) {
                        Text("Activity ").padding(.horizontal)
                        Picker(selection: $activityType, label: Text("Segment Control").padding(10.0)) {
                            Text("Poo").tag(0)
                            Text("Pee").tag(1)
                        }.pickerStyle(SegmentedPickerStyle()).padding(10.0)
                    }
                    Divider()
                    DatePicker("When ", selection: $timestamp, displayedComponents: [.date, .hourAndMinute])
                        .padding(.horizontal)
                    Divider()
                    Button(action: {
                        loo.timestamp = timestamp
                        loo.poo = activityType == 0
                        loo.pee = activityType == 1
                        
                        coreDM.updateLoo(loo: loo)
                        needsRefresh.toggle()
                    }) {
                        Text("Update")
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .foregroundColor(.black)
                            .background(RoundedRectangle(cornerRadius: 5)
                                            .fill(.white.opacity(0.6)))
                        }
                    .padding()
                    
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.25)))
                
                Spacer()
            }
            .padding(20)
        }
        .background(yellow)
        .onAppear {
            // initializing from db value
            timestamp = loo.timestamp ?? Date()
            activityType = loo.poo ? 0 : 1
        }
        .navigationTitle("Activity Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}

//struct LooDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        LooDetail(loo: Loo())
//    }
//}
