//
//  LooDetail.swift
//  BabyLoo
//
//  Created by Selvarajan on 03/01/22.
//

import SwiftUI

struct LooDetail: View {
    @Binding var looVM: LooViewModel
    @ObservedObject var looListVM : LooListViewModel
    
    @State var looTimestamp : Date = Date()
    @State private var activityType = 1
    let coreDM = CoreDataProvider.shared
    
    let yellow: Color = Color(hex: "EDC126")
//    let yellow: Color = Color(.white)
    
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
                    DatePicker("When ", selection: $looTimestamp, displayedComponents: [.date, .hourAndMinute])
                        .padding(.horizontal)
                    Divider()
                    Button(action: {
                        looListVM.updateLoo(id: looVM.id,
                                            looTimestamp: looTimestamp,
                                            poo: activityType == 0,
                                            pee: activityType == 1)
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
            looTimestamp = looVM.timestamp
            activityType = looVM.poo ? 0 : 1
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
