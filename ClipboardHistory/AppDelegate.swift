import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var clipboardHistory = ClipboardHistory()
    var timer: Timer?
    var eventMonitor: Any?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(checkClipboard), userInfo: nil, repeats: true)
        startMonitoringKeyboard()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        timer?.invalidate()
        if let eventMonitor = eventMonitor {
            NSEvent.removeMonitor(eventMonitor)
        }
    }

    @objc func checkClipboard() {
        if let clipboardString = NSPasteboard.general.string(forType: .string) {
            clipboardHistory.addClipboardItem(clipboardString)
            print("Novo item copiado: \(clipboardString)")
        }
    }

    func startMonitoringKeyboard() {
        eventMonitor = NSEvent.addGlobalMonitorForEvents(matching: .keyDown) { [weak self] event in
            self?.handleKeyEvent(event: event)
        }
    }

    func handleKeyEvent(event: NSEvent) {
        if event.modifierFlags.contains([.command, .function]) && event.charactersIgnoringModifiers == "v" {
            // fn + command + v was pressed
            NSApplication.shared.activate(ignoringOtherApps: true)
            if let window = NSApplication.shared.windows.first {
                window.makeKeyAndOrderFront(nil)
            }
        }
    }
}
