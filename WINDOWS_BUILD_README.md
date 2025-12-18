# Build para Windows Desktop

Este documento explica como gerar uma versão executável do aplicativo para Windows Desktop.

## Pré-requisitos

1. **Flutter SDK** instalado e configurado
2. **Visual Studio** com componentes C++ para Windows (recomendado)
   - Ou **Visual Studio Build Tools**
   - Incluir "Desktop development with C++" workload
3. **CMake** (geralmente incluído com Visual Studio)

## Verificar Suporte Windows

Para verificar se o Flutter tem suporte para Windows configurado:

```bash
flutter doctor
```

Se Windows não estiver listado, você pode habilitar:

```bash
flutter config --enable-windows-desktop
```

## Build do Executável

### Opção 1: Script Automatizado (Recomendado)

#### No Windows:
```cmd
build_windows.bat
```

#### No macOS/Linux:
```bash
./build_windows.sh
```

### Opção 2: Comandos Manuais

```bash
# Limpar builds anteriores
flutter clean

# Obter dependências
flutter pub get

# Build release
flutter build windows --release
```

## Localização do Executável

Após o build, o executável estará em:

```
build/windows/x64/runner/Release/sis_flutter.exe
```

**Importante:** Todos os arquivos na pasta `Release` são necessários para executar o aplicativo. Não copie apenas o `.exe`.

## Distribuição

1. **Copiar pasta completa**: Copie toda a pasta `Release` para distribuição
2. **Compactar**: Crie um arquivo ZIP com todos os arquivos
3. **Instalar**: O usuário pode extrair e executar `sis_flutter.exe`

## Estrutura de Arquivos Necessários

```
Release/
├── sis_flutter.exe          # Executável principal
├── data/                    # Dados do aplicativo
│   └── flutter_assets/      # Assets (imagens, ícones, etc.)
├── *.dll                    # Bibliotecas necessárias
└── outros arquivos          # Dependências do Flutter
```

## Troubleshooting

### Erro: "CMake not found"
- Instale Visual Studio com componentes C++
- Ou instale CMake separadamente

### Erro: "MSBuild not found"
- Instale Visual Studio Build Tools
- Configure o PATH para incluir MSBuild

### Erro: "Windows desktop development not available"
```bash
flutter config --enable-windows-desktop
flutter create --platforms=windows .
```

### Build Debug (para desenvolvimento)
```bash
flutter build windows --debug
```

O executável debug estará em: `build/windows/x64/runner/Debug/`

## Notas Importantes

- O executável é específico para arquitetura x64 (64-bit)
- Para outras arquiteturas, use flags apropriadas no build
- O tamanho do executável pode ser grande devido às dependências do Flutter
- Considere usar ferramentas de compressão para distribuição

## Scripts Disponíveis

- `build_windows.sh` - Script para macOS/Linux
- `build_windows.bat` - Script para Windows
- `build_apk.sh` - Script para Android (referência)

