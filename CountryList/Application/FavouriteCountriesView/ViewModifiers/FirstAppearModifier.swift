//
//  FirstAppearModifier.swift
//  CountryList
//
//  Created by Neel on 12/06/25.
//

import SwiftUI

struct FirstAppearModifier: ViewModifier {
    @State private var hasAppeared = false
    let perform: () -> Void

    func body(content: Content) -> some View {
        content.onAppear {
            if !hasAppeared {
                hasAppeared = true
                perform()
            }
        }
    }
}
extension View {
    func onFirstAppear(perform: @escaping () -> Void) -> some View {
        self.modifier(FirstAppearModifier(perform: perform))
    }
}
