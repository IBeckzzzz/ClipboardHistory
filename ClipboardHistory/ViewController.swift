import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    
    var clipboardHistory: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Registra para receber notificações quando o histórico for atualizado
        NotificationCenter.default.addObserver(self, selector: #selector(updateClipboardHistory(_:)), name: NSNotification.Name("ClipboardHistoryUpdated"), object: nil)
        // Permite que a tabela aceite eventos de teclado
        tableView.window?.makeFirstResponder(tableView)
    }

    @objc func updateClipboardHistory(_ notification: Notification) {
        // Atualiza o histórico com os novos dados recebidos na notificação
        if let history = notification.object as? [String] {
            clipboardHistory = history
            tableView.reloadData() // Recarrega os dados na tabela
        }
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return clipboardHistory.count
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = "ClipboardCell"
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(cellIdentifier), owner: nil) as? NSTableCellView {
            cell.textField?.stringValue = clipboardHistory[row]
            return cell
        }
        return nil
    }

    func tableViewSelectionDidChange(_ notification: Notification) {
        // Verifique se um item está selecionado
        if tableView.selectedRow >= 0 {
            // Imprime o item selecionado (opcional)
            print("Item selecionado: \(clipboardHistory[tableView.selectedRow])")
        }
    }

    override func keyDown(with event: NSEvent) {
        // Verifique se a tecla Enter foi pressionada
        if event.keyCode == 36 { // 36 é o keyCode para Enter
            if tableView.selectedRow >= 0 {
                let selectedItem = clipboardHistory[tableView.selectedRow]
                // Copia o item selecionado para a área de transferência
                NSPasteboard.general.clearContents()
                NSPasteboard.general.setString(selectedItem, forType: .string)
                print("Item copiado: \(selectedItem)")
            }
        } else {
            super.keyDown(with: event)
        }
    }
}
