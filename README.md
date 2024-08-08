# ClipboardHistory

ClipboardHistory é um aplicativo macOS que armazena o histórico de textos copiados para a área de transferência, permitindo que você navegue e selecione facilmente itens copiados anteriormente para reutilizá-los. É uma ferramenta útil para quem trabalha com múltiplas cópias de texto e deseja economizar tempo ao alternar entre diferentes conteúdos copiados.

## Funcionalidades

- **Armazenamento de Histórico de Clipboard**: Mantém um registro de todos os textos copiados para a área de transferência.
- **Navegação Rápida**: Use as teclas de seta para navegar rapidamente pelo histórico.
- **Seleção e Cópia**: Clique em um item para copiá-lo de volta para a área de transferência, ou use `Enter` para copiar o item selecionado.
- **Limpar Histórico**: Botão para limpar todo o histórico de itens copiados.
- **Atalho de Teclado**: Use `fn + command + v` para abrir rapidamente o aplicativo.

## Documentos do Projeto

### 1. `ClipboardHistoryApp.swift`

Este arquivo contém a estrutura principal do aplicativo e é responsável por iniciar o aplicativo e configurar o ambiente para a interface do usuário.

### 2. `AppDelegate.swift`

O `AppDelegate` gerencia o ciclo de vida do aplicativo. Ele configura um temporizador para verificar novos itens copiados na área de transferência e adicioná-los ao histórico.

### 3. `ClipboardHistory.swift`

Esta classe gerencia o histórico do clipboard, permitindo adicionar novos itens e limpar o histórico. É observável para que a interface do usuário possa atualizar automaticamente quando o histórico é modificado.

### 4. `ContentView.swift`

O `ContentView` define a interface principal do aplicativo. Ele exibe a lista de itens copiados e permite a interação do usuário para selecionar, copiar e limpar itens. Também gerencia os atalhos de teclado.

### 5. `ViewController.swift`

Este arquivo gerencia a interface de usuário usando `NSTableView`. É responsável por atualizar a tabela com o histórico e lidar com eventos de teclado, como cópia de itens selecionados.

## Utilidade no Dia a Dia

ClipboardHistory é especialmente útil para profissionais que precisam trabalhar com múltiplos trechos de texto ao mesmo tempo, como programadores, escritores, e gerentes de projeto. Ele permite que você copie e cole rapidamente sem perder o controle sobre o que já foi copiado anteriormente.

## Instalação e Execução

Como o aplicativo não está assinado com um certificado de desenvolvedor Apple, você precisará seguir algumas etapas extras para instalá-lo e executá-lo.

### Passos para Instalação

1. **Baixar o Aplicativo**: Baixe o arquivo `ClipboardHistory.zip` do repositório ou receba-o diretamente do desenvolvedor.

2. **Descompactar o Arquivo**: Clique com o botão direito no arquivo `ClipboardHistory.zip` e selecione "Abrir com" > "Utilitário de Arquivo" para descompactá-lo.

3. **Mover para Aplicativos**: Arraste o aplicativo `ClipboardHistory.app` para a pasta `Applications`.

### Como Rodar o Aplicativo

1. **Primeira Execução**:
    - Vá até a pasta `Applications`.
    - Clique com o botão direito (ou Ctrl + clique) em `ClipboardHistory.app`.
    - Selecione "Abrir". Você verá uma mensagem informando que o aplicativo é de um desenvolvedor não identificado.
    - Clique em "Abrir" novamente para confirmar.

2. **Execução Posterior**:
    - Após a primeira execução, você pode abrir o aplicativo normalmente clicando duas vezes nele na pasta `Applications`.

## Contribuições

Se você quiser contribuir com o projeto, sinta-se à vontade para abrir issues ou enviar pull requests. Qualquer melhoria, sugestão ou correção é muito bem-vinda!

## Licença

Este projeto está licenciado sob os termos da licença MIT. Consulte o arquivo `LICENSE` para mais detalhes.
