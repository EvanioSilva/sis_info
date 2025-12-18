# 📱 APK Build e Distribuição - Resolução de Problemas

## 🚨 Problema Identificado

Quando o APK é baixado do Google Drive e instalado no dispositivo, ocorrem erros de conectividade (response null) devido a restrições de segurança do Android para apps não assinados adequadamente.

## ✅ Soluções Implementadas

### 1. **Configuração de Rede Segura**
- ✅ `AndroidManifest.xml` configurado com `networkSecurityConfig`
- ✅ `network_security_config.xml` criado permitindo conexões seguras

### 2. **Assinatura Temporária**
- ✅ Build release usa certificado de debug (compatível com distribuição)
- ✅ Permite instalação de fontes desconhecidas

### 3. **Script Automatizado**
- ✅ `build_apk.sh` criado para gerar APK automaticamente
- ✅ Validações e logs detalhados

## 🚀 Como Gerar APK para Distribuição

### **Método 1: Script Automatizado (Recomendado)**
```bash
# Na raiz do projeto Flutter
./build_apk.sh
```

### **Método 2: Comando Manual**
```bash
# Limpar builds anteriores
flutter clean

# Obter dependências
flutter pub get

# Build release
flutter build apk --release --target-platform android-arm64
```

### **Método 3: Se Flutter não estiver no PATH**
```bash
# Substitua pelo caminho do seu Flutter
export PATH="$PATH:/caminho/para/flutter/bin"

# Depois execute o script
./build_apk.sh
```

### **Método 4: Comandos Individuais**
Se o script falhar, execute um por vez:
```bash
flutter clean
flutter pub get
flutter analyze
flutter build apk --release --target-platform android-arm64
```

## 📲 Como Instalar no Dispositivo

### **Passos para Instalação:**
1. **Transfira o APK** gerado para seu dispositivo Android
2. **Habilite fontes desconhecidas:**
   - Configurações → Apps → Menu (⋮) → "Instalar apps desconhecidos"
   - Selecione o app de transferência de arquivos
   - Ative "Permitir desta fonte"
3. **Instale o APK** tocando nele
4. **Permita permissões** se solicitado

### **Solução de Problemas de Instalação:**

#### **Se aparecer "App não instalado":**
```bash
# Desinstale versões anteriores
adb uninstall com.example.sis_flutter

# Ou via Configurações → Apps → sis_flutter → Desinstalar
```

#### **Se aparecer "Aplicativo corrompido":**
- Certifique-se que o APK foi transferido completamente
- Tente gerar novamente: `./build_apk.sh`

## 🔧 Configurações Técnicas

### **Network Security Config**
```xml
<!-- android/app/src/main/res/xml/network_security_config.xml -->
<network-security-config>
    <domain-config cleartextTrafficPermitted="true">
        <domain includeSubdomains="true">unseraphic-nonselective-shantae.ngrok-free.dev</domain>
    </domain-config>
    <base-config cleartextTrafficPermitted="false" />
</network-security-config>
```

### **Build Config**
```gradle
// android/app/build.gradle
buildTypes {
    release {
        signingConfig = signingConfigs.debug  // Permite distribuição
        minifyEnabled false                   // Evita problemas de obfuscation
        shrinkResources false                 // Mantém todos recursos
    }
}
```

## 🧪 Teste de Conectividade

O app agora inclui um botão **"Testar Conexão"** na tela de login que:
- ✅ Testa conectividade com o servidor
- ✅ Mostra logs detalhados no console
- ✅ Ajuda a diagnosticar problemas de rede

## 📊 Verificação

### **Verificar APK Gerado:**
```bash
# Verificar se APK existe
ls -la *.apk

# Verificar tamanho (deve ser > 10MB)
du -h sis_flutter_*.apk

# Verificar assinatura
jarsigner -verify sis_flutter_*.apk
```

### **Testar no Dispositivo:**
1. Instale o APK
2. Abra o app
3. Toque em "Testar Conexão"
4. Verifique se aparece "Conectividade OK"

## 🔍 Logs de Debug

### **Ver Logs do App:**
```bash
# Conecte dispositivo via USB e veja logs
adb logcat | grep -i flutter
```

### **Logs Esperados no Sucesso:**
```
🔄 Fazendo requisição: POST https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis/autenticar
📥 Resposta recebida: 200
✅ Conectividade OK! Servidor respondendo.
```

## 🚨 Possíveis Problemas e Soluções

### **1. "Connection refused"**
- Servidor ngrok não está rodando
- URL expirou
- Solução: Atualizar URL no `usuario_service.dart`

### **2. "Certificate verify failed"**
- Problema de certificado HTTPS
- Solução: Verificar se ngrok está usando HTTPS

### **3. "Network is unreachable"**
- Sem internet no dispositivo
- Firewall bloqueando
- Solução: Testar em rede diferente

### **4. "Installation blocked"**
- Segurança Android bloqueando
- Solução: Seguir passos de "fontes desconhecidas"

## 📞 Suporte

Se ainda houver problemas:

1. **Execute:** `./build_apk.sh` e verifique se há erros
2. **Teste conectividade:** Use o botão "Testar Conexão" no app
3. **Verifique logs:** `adb logcat | grep -i flutter`
4. **Teste URL:** Abra `https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis` no navegador

---

**🎯 Resultado Esperado:** APK funcionando perfeitamente quando baixado do Google Drive! 🚀
