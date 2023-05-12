//
//  File.swift
//  
//
//  Created by Huy Ong on 4/28/23.
//

import SwiftUI

public extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding {
            return self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
            handler()
        }

    }
}
