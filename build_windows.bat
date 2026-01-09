@echo off
echo 🚀 Iniciando build do executável Windows...
echo ==============================================

REM Verificar se estamos no diretório correto
if not exist "pubspec.yaml" (
    echo [ERROR] Execute este script na raiz do projeto Flutter
    exit /b 1
)

REM Verificar se Windows está habilitado
if not exist "windows" (
    echo [WARNING] Suporte para Windows não encontrado. Criando...
    flutter create --platforms=windows .
)

echo [INFO] Limpando builds anteriores...
flutter clean

echo [INFO] Obtendo dependências...s
flutter pub get

echo [INFO] Verificando se há erros de análise...
flutter analyze
if %errorlevel% neq 0 (
    echo [WARNING] Há warnings/erros de análise, mas continuando...
)

echo [INFO] Construindo executável Windows (Release)...
flutter build windows --release
if %errorlevel% neq 0 (
    echo [ERROR] Falha ao construir executável Windows
    exit /b 1
)

REM Localizar o executável gerado
set EXE_PATH=build\windows\x64\runner\Release\sis_flutter.exe

if exist "%EXE_PATH%" (
    echo [SUCCESS] Executável encontrado em: %EXE_PATH%
    
    REM Criar nome com timestamp
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set datetime=%%I
    set TIMESTAMP=%datetime:~0,8%_%datetime:~8,6%
    set DIST_DIR=dist_windows_%TIMESTAMP%
    
    REM Copiar pasta Release completa
    xcopy /E /I /Y "build\windows\x64\runner\Release" "%DIST_DIR%"
    
    echo [SUCCESS] ==============================================
    echo [SUCCESS] Executável Windows pronto para distribuição!
    echo [SUCCESS] 📁 Localização: %CD%\%DIST_DIR%\
    echo [SUCCESS] 
    echo [SUCCESS] Para distribuir:
    echo [SUCCESS] 1. Compacte a pasta '%DIST_DIR%' em um arquivo ZIP
    echo [SUCCESS] 2. O executável principal é: %DIST_DIR%\sis_flutter.exe
    echo [SUCCESS] 3. Todos os arquivos na pasta são necessários para execução
    echo [SUCCESS] ==============================================
) else (
    echo [ERROR] Executável não encontrado no caminho esperado: %EXE_PATH%
    echo [ERROR] Verifique se o build foi concluído com sucesso
    exit /b 1
)

pause


