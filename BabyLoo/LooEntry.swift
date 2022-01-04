//
//  LooEntry.swift
//  BabyLoo
//
//  Created by Selvarajan on 01/01/22.
//

import SwiftUI

struct LooEntry: View {
    let coreDM = CoreDataProvider.shared
    @Binding var peeCount : Int
    @Binding var pooCount : Int
    @Binding var needsRefresh : Bool
    
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
                    Text("Pee (\(peeCount))")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                    Text("last at 9.30 am").font(.footnote).foregroundColor(.gray)
                }
                Spacer()

                Button {
                    peeCount = peeCount + 1
                    coreDM.saveLoo(poo: false, pee: true)
                    needsRefresh.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .background(Circle().foregroundColor(.black).opacity(0.5))
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }


//                Button {
//                    peeCount -= 1
//                } label: {
//                    Image(systemName: "minus.circle.fill")
//                        .resizable()
//                        .foregroundColor(.white)
//                        .background(Circle().opacity(0.4))
//                        .frame(width: 40, height: 40)
//                }

            }.padding(10).background(.white.opacity(0.35))

            HStack{
                Image("baby-boy")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 10)
                VStack(alignment: .leading) {
                    Text("Poo (\(pooCount))")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.black.opacity(0.7))
                    Text("last at 8.30 am").font(.footnote).foregroundColor(.gray)
                }
                Spacer()

                Button {
                    pooCount = pooCount + 1
                    coreDM.saveLoo(poo: true, pee: false)
                    needsRefresh.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                        .background(Circle().foregroundColor(.black).opacity(0.5))
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                }
//                Button {
//                    pooCount -= 1
//                } label: {
//                    Image(systemName: "minus.circle.fill")
//                        .resizable()
//                        .foregroundColor(.white)
//                        .background(Circle().opacity(0.4))
//                        .frame(width: 40, height: 40)
//                    //                            .background(Circle().stroke(.black, lineWidth: 2))
//                }

            }.padding(10).background(.white.opacity(0.35))
            //                        Divider()
        }
        .padding(15)
        .background(.white.opacity(0.25))
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

//struct LooEntry_Previews: PreviewProvider {
//    static var previews: some View {
//        LooEntry(peeCount: .constant(0), pooCount: .constant(0))
//    }
//}
