#!/bin/bash

echo "🚀 Iniciando build do APK para distribuição..."
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
    echo "  flutter build apk --release --target-platform android-arm64"
    echo ""
    FLUTTER_CMD="echo 'Execute manualmente: '"
fi

# Verificar se estamos no diretório correto
if [ ! -f "pubspec.yaml" ]; then
    error "Execute este script na raiz do projeto Flutter"
    exit 1
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

log "Construindo APK release..."
if $FLUTTER_CMD build apk --release --target-platform android-arm64; then
    success "APK construído com sucesso!"
else
    error "Falha ao construir APK"
    exit 1
fi

# Localizar o APK gerado
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"

if [ -f "$APK_PATH" ]; then
    success "APK encontrado em: $APK_PATH"

    # Calcular tamanho do arquivo
    FILE_SIZE=$(du -h "$APK_PATH" | cut -f1)
    success "Tamanho do APK: $FILE_SIZE"

    # Criar nome com timestamp
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    FINAL_APK="sis_flutter_$TIMESTAMP.apk"

    cp "$APK_PATH" "$FINAL_APK"

    success "APK copiado para: $FINAL_APK"
    success "=============================================="
    success "APK pronto para distribuição!"
    success "📁 Localização: $(pwd)/$FINAL_APK"
    success ""
    success "Para instalar:"
    success "1. Transfira o APK para seu dispositivo Android"
    success "2. Habilite 'Instalação de fontes desconhecidas'"
    success "3. Toque no APK para instalar"
    success "=============================================="

else
    error "APK não encontrado no caminho esperado: $APK_PATH"
    exit 1
fi
