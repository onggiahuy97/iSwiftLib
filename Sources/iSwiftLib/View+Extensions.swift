//
//  File.swift
//  
//
//  Created by Huy Ong on 5/4/23.
//

import SwiftUI

public struct FilteringList<T: Identifiable, Content: View>: View {
    @FocusState private var isTextFieldFocused: Bool
    @State private var filteredItems = [T]()
    @State private var filterString = ""
    
    let listItems: [T]
    let filterKeyPaths: [KeyPath<T, String>]
    let content: (T) -> Content
    
    public var body: some View {
        VStack {
            TextField("Filter", text: $filterString.onChange {
                withAnimation {
                    applyFilter()
                }
            })
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal)
            .focused($isTextFieldFocused)
            
            List(filteredItems, rowContent: content)
        }
        .onAppear(perform: applyFilter)
    }
    
    
    public init(
        _ data: [T],
        filterKeys: KeyPath<T, String>...,
        focus isSearchTextFocused: Bool = false,
        @ViewBuilder rowContent: @escaping (T) -> Content
    ) {
        listItems = data
        filterKeyPaths = filterKeys
        content = rowContent
        isTextFieldFocused = isSearchTextFocused
    }
    
    private func applyFilter() {
        let cleanedFilter = filterString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanedFilter.isEmpty {
            filteredItems = listItems
        } else {
            filteredItems = listItems.filter { element in
                filterKeyPaths.contains {
                    element[keyPath: $0]
                        .localizedCaseInsensitiveContains(cleanedFilter)
                }
            }
        }
    }
}
