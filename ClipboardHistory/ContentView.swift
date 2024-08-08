import SwiftUI

struct ContentView: View {
    @EnvironmentObject var clipboardHistory: ClipboardHistory
    @State private var selectedItemIndex: Int? = nil

    var body: some View {
        VStack(alignment: .leading) {
            Text("Clipboard History")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding(.bottom, 20)

            ScrollViewReader { proxy in
                List(clipboardHistory.history.indices.reversed(), id: \.self, selection: $selectedItemIndex) { index in
                    HStack {
                        Text(clipboardHistory.history[index])
                            .padding()
                            .background(selectedItemIndex == index ? Color.gray.opacity(0.3) : Color.clear)
                            .cornerRadius(5)
                            .onTapGesture {
                                selectedItemIndex = index
                            }

                        Spacer()

                        Button(action: {
                            copyItemToClipboard(at: index)
                        }) {
                            Image(systemName: "doc.on.doc")
                                .foregroundColor(.blue)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                    .tag(index)
                    .id(index)
                }
                .listStyle(PlainListStyle())
                .frame(maxHeight: 400)
                .onKeyPress { event in
                    handleKeyPress(event: event, proxy: proxy)
                }
                .onChange(of: clipboardHistory.history) { _ in
                    selectMostRecentItem(proxy: proxy)
                }
            }

            HStack {
                Button(action: {
                    clipboardHistory.clearHistory()
                    selectedItemIndex = nil
                }) {
                    Text("Clear History")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
            .padding(.top, 10)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 10)
        .frame(maxWidth: 600)
    }

    private func handleKeyPress(event: NSEvent, proxy: ScrollViewProxy) {
        switch event.keyCode {
        case 125: // Down arrow key
            if let selectedItemIndex = selectedItemIndex, selectedItemIndex > 0 {
                self.selectedItemIndex = selectedItemIndex - 1
                withAnimation {
                    proxy.scrollTo(self.selectedItemIndex)
                }
            } else if selectedItemIndex == nil, !clipboardHistory.history.isEmpty {
                self.selectedItemIndex = clipboardHistory.history.count - 1
                withAnimation {
                    proxy.scrollTo(self.selectedItemIndex)
                }
            }
        case 126: // Up arrow key
            if let selectedItemIndex = selectedItemIndex, selectedItemIndex < clipboardHistory.history.count - 1 {
                self.selectedItemIndex = selectedItemIndex + 1
                withAnimation {
                    proxy.scrollTo(self.selectedItemIndex)
                }
            } else if selectedItemIndex == nil, !clipboardHistory.history.isEmpty {
                self.selectedItemIndex = 0
                withAnimation {
                    proxy.scrollTo(self.selectedItemIndex)
                }
            }
        case 36: // Return key
            if let selectedItemIndex = selectedItemIndex {
                copySelectedItemToClipboard(at: selectedItemIndex)
            }
        default:
            break
        }
    }

    private func copySelectedItemToClipboard(at index: Int) {
        let item = clipboardHistory.history[index]
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(item, forType: .string)
        print("Copied to clipboard: \(item)")
    }

    private func copyItemToClipboard(at index: Int) {
        let item = clipboardHistory.history[index]
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(item, forType: .string)
        print("Copied to clipboard: \(item)")
    }

    private func selectMostRecentItem(proxy: ScrollViewProxy) {
        selectedItemIndex = clipboardHistory.history.count - 1
        withAnimation {
            proxy.scrollTo(selectedItemIndex)
        }
    }
}

extension View {
    func onKeyPress(_ perform: @escaping (NSEvent) -> Void) -> some View {
        self.background(KeyPressHandlingView(perform: perform))
    }
}

struct KeyPressHandlingView: NSViewRepresentable {
    var perform: (NSEvent) -> Void

    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        view.addSubview(ResponderView(perform: perform))
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    class ResponderView: NSView {
        var perform: (NSEvent) -> Void

        init(perform: @escaping (NSEvent) -> Void) {
            self.perform = perform
            super.init(frame: .zero)
            becomeFirstResponder()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override var acceptsFirstResponder: Bool {
            true
        }

        override func keyDown(with event: NSEvent) {
            perform(event)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ClipboardHistory())
    }
}
