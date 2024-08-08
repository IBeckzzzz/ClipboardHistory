//
//  ClipboardHistory.swift
//  ClipboardHistory
//
//  Created by Thiago Beck De Andrade.T_STEFANINI on 20/06/24.
//

import SwiftUI
import Combine

class ClipboardHistory: ObservableObject {
    @Published var history: [String] = []

    func addClipboardItem(_ item: String) {
        if history.isEmpty || history.last != item {
            history.append(item)
            NotificationCenter.default.post(name: NSNotification.Name("ClipboardHistoryUpdated"), object: history)
        }
    }

    func clearHistory() {
        history.removeAll()
        // Limpa a área de transferência para evitar que o último item reapareça
        NSPasteboard.general.clearContents()
        NotificationCenter.default.post(name: NSNotification.Name("ClipboardHistoryUpdated"), object: history)
    }
}




