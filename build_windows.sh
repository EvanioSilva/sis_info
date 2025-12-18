#!/bin/bash

echo "🚀 Iniciando build do executável Windows..."
echo "=============================================="

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para log colorido
log() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Verificar Flutter
FLUTTER_CMD="flutter"  # Assumir que flutter está no PATH
if ! command -v flutter &> /dev/null; then
    warning "Flutter não está no PATH. Execute comandos manualmente:"
    echo ""
    echo "Comandos manuais:"
    echo "  flutter clean"
    echo "  flutter pub get"
    echo "  flutter build windows --release"
    echo ""
    FLUTTER_CMD="echo 'Execute manualmente: '"
fi

# Verificar se estamos no diretório correto
if [ ! -f "pubspec.yaml" ]; then
    error "Execute este script na raiz do projeto Flutter"
    exit 1
fi

# Verificar se Windows está habilitado
if [ ! -d "windows" ]; then
    warning "Suporte para Windows não encontrado. Criando..."
    $FLUTTER_CMD create --platforms=windows .
fi

log "Limpando builds anteriores..."
$FLUTTER_CMD clean

log "Obtendo dependências..."
$FLUTTER_CMD pub get

log "Verificando se há erros de análise..."
if $FLUTTER_CMD analyze; then
    success "Análise concluída sem erros"
else
    warning "Há warnings/erros de análise, mas continuando..."
fi

log "Construindo executável Windows (Release)..."
if $FLUTTER_CMD build windows --release; then
    success "Executável Windows construído com sucesso!"
else
    error "Falha ao construir executável Windows"
    exit 1
fi

# Localizar o executável gerado
EXE_PATH="build/windows/x64/runner/Release/sis_flutter.exe"

if [ -f "$EXE_PATH" ]; then
    success "Executável encontrado em: $EXE_PATH"

    # Calcular tamanho do arquivo
    FILE_SIZE=$(du -h "$EXE_PATH" | cut -f1)
    success "Tamanho do executável: $FILE_SIZE"

    # Criar nome com timestamp
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    FINAL_EXE="sis_flutter_windows_$TIMESTAMP.exe"
    
    # Copiar executável e pasta Release completa
    RELEASE_DIR="build/windows/x64/runner/Release"
    DIST_DIR="dist_windows_$TIMESTAMP"
    
    mkdir -p "$DIST_DIR"
    cp -r "$RELEASE_DIR"/* "$DIST_DIR/"
    
    success "Executável copiado para: $DIST_DIR/"
    success "=============================================="
    success "Executável Windows pronto para distribuição!"
    success "📁 Localização: $(pwd)/$DIST_DIR/"
    success ""
    success "Para distribuir:"
    success "1. Compacte a pasta '$DIST_DIR' em um arquivo ZIP"
    success "2. O executável principal é: $DIST_DIR/sis_flutter.exe"
    success "3. Todos os arquivos na pasta são necessários para execução"
    success "=============================================="

else
    error "Executável não encontrado no caminho esperado: $EXE_PATH"
    error "Verifique se o build foi concluído com sucesso"
    exit 1
fi

