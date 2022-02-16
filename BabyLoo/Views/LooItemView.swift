//
//  LooItemView.swift
//  BabyLoo
//
//  Created by Selvarajan on 04/01/22.
//

import SwiftUI

struct LooItemView: View {
    @Binding var looVM: LooViewModel
    @ObservedObject var looListVM : LooListViewModel
    @State var text: String = ""
    
    func getLooVM() -> Binding<LooViewModel> {
        if looListVM.looEntries.count > 0 {
            if let index = looListVM.looEntries.firstIndex(where: { $0.id == looVM.id }) {
                return $looListVM.looEntries[index]
            }
        }
        return $looVM
    }
    
    var body: some View {
        VStack {
            HStack {
                NavigationLink(destination:
                                LooDetail(looVM: getLooVM(),
                                          looListVM: looListVM)) {
                    Text(text)
                        .font(.subheadline)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button {
                    looListVM.deleteLoo(loo: looVM)
                } label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                        .foregroundColor(.red)
                        .opacity(0.6)
                        .frame(width: 20, height: 20)
                        .padding(.horizontal)
                }
            }
            Divider()
        }
    }
}

//struct LooItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        LooItemView()
//    }
//}
