//  UserList.swift
//  ListWithFloatingButton
//  Created by Sumit on 24/07/24.

import SwiftUI

struct UserList: View {
    
    @State private var title = "Messages"
    @StateObject var modelView = UserListModelView()
    
    var body: some View {
        
        let mainButton2 = MainButton(imageName: "plus", colorHex: "e44b8d")
        let buttonsImage = MockData.iconImageNames.enumerated().map { index, value in
            IconButton(imageName: value, color: MockData.colors[index])
                .tag(index)
        }

        let menu1 = FloatingButton(mainButtonView: mainButton2, buttons: buttonsImage.dropLast())
            .circle()
            .layoutDirection(.counterClockwise)
            .startAngle(3/2 * .pi)
            .endAngle(2 * .pi)
            .radius(70)
        
        NavigationStack {
            ZStack {
                List(modelView.userListModel, id: \.itemId) { items in
                    HStack {
                        Image(items.img)
                            .resizable()
                            .frame(width:70,height:70)
                            .cornerRadius(35)
                        VStack(alignment:.leading, spacing: 10) {
                            HStack {
                                Text(items.name)
                                    .font(.system(size: 18, weight: .semibold, design: .default))
                                Spacer()
                                Text(items.time)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .semibold, design: .default))
                            }
                            Text(items.description)
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular, design: .default))
                                .lineSpacing(6)
                        }.padding([.leading],14)
                    }
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        menu1
                    }.padding([.trailing])
                }
            }
            .navigationTitle($title)
        }
    }
 }

#Preview {
    UserList()
}



