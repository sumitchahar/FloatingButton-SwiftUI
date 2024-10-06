//
//  Utils.swift
//  ListWithFloatingButton
//
//  Created by Sumit on 24/07/24.
//

import SwiftUI

extension View {

    func sizeGetter(_ size: Binding<CGSize>) -> some View {
        modifier(SizeGetter(size: size))
    }
 }

extension Collection where Element == CGPoint {
    
    subscript (safe index: Index) -> CGPoint {
        return indices.contains(index) ? self[index] : .zero
    }
}

struct SizeGetter: ViewModifier {
    @Binding var size: CGSize

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy -> Color in
                    if proxy.size != self.size {
                        DispatchQueue.main.async {
                            self.size = proxy.size
                        }
                    }
                    return Color.clear
                }
            )
    }
 }

struct SubmenuButtonPreferenceKey: PreferenceKey {
    typealias Value = [CGSize]

    static var defaultValue: Value = []

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.append(contentsOf: nextValue())
    }
}

struct SubmenuButtonPreferenceViewSetter: View {

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: SubmenuButtonPreferenceKey.self,
                            value: [geometry.frame(in: .global).size])
        }
    }
 }

struct MockData {

    static let colors = [
        "e84393",
        "0984e3",
        "964B00",
        "00b894"
    ].map { Color(hex: $0) }

    static let iconImageNames = [
        "camera.rotate.fill",
        "doc.fill",
        "photo.circle.fill",
        "cloud.snow.fill"
    ]

    static let iconAndTextImageNames = [
        "plus.circle.fill",
        "minus.circle.fill",
        "pencil.circle.fill"
    ]

    static let iconAndTextTitles = [
        "Add New",
        "Remove",
        "Rename"
    ]
}

struct IconButton: View {

    var imageName: String
    var color: Color
    let imageWidth: CGFloat = 26
    let buttonWidth: CGFloat = 45

    var body: some View {
        ZStack {
            color
            Image(systemName: imageName)
                .frame(width: imageWidth, height: imageWidth)
                .foregroundColor(.white)
        }
        .frame(width: buttonWidth, height: buttonWidth)
        .cornerRadius(buttonWidth / 2)
    }
}


struct MainButton: View {

    var imageName: String
    var colorHex: String
    var width: CGFloat = 64

    var body: some View {
        ZStack {
            Color(hex: colorHex)
                .frame(width: width, height: width)
                .cornerRadius(width / 2)
                .shadow(color: Color(hex: colorHex).opacity(0.3), radius: 15, x: 0, y: 15)
            Image(systemName: imageName)
                .foregroundColor(.white)
        }
    }
}

 extension Color {

    init(hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
 }
