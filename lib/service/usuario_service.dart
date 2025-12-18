import 'package:get/get.dart';
import 'package:sis_flutter/model/usuario_model.dart';

class UsuarioService extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    baseUrl = 'https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis';

    // Configurações de timeout e headers padrão
    timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Content-Type'] = 'application/json';
      request.headers['Accept'] = 'application/json';
      print('🔄 Fazendo requisição: ${request.method} ${request.url}');
      return request;
    });

    // Adicionar interceptor para debug
    httpClient.addResponseModifier<dynamic>((request, response) {
      print('📥 Resposta recebida: ${response.statusCode}');
      if (response.statusCode != 200) {
        print('❌ Corpo da resposta: ${response.body}');
      }
      return response;
    });
  }

  /// Testa a conectividade com o servidor
  Future<bool> testarConectividade() async {
    try {
      print('🧪 Testando conectividade...');
      final response = await get('/autenticar', query: {'teste': 'true'});
      print('✅ Servidor respondeu: ${response.statusCode}');
      return response.statusCode != null;
    } catch (e) {
      print('❌ Erro de conectividade: $e');
      return false;
    }
  }

  /// Autentica um usuário na API
  /// [usuario] é o objeto Usuario com login e senha preenchidos
  /// Retorna um Usuario com o campo autenticado preenchido
  /// Pode lançar exceção em caso de erro
  Future<Usuario> autenticar(Usuario usuario) async {
    try {
      final response = await post('/autenticar', usuario.toMap());

      if (response.statusCode == 200) {
        return Usuario.fromMap(response.body as Map<String, dynamic>);
      } else {
        // Verifica se response não é null antes de acessar propriedades
        final statusCode = response.statusCode ?? 'desconhecido';
        final body = response.body?.toString() ?? 'sem resposta';
        print('❌ Erro ao autenticar usuário: Status $statusCode - $body');
        throw Exception('Erro ao autenticar usuário: $statusCode - $body');
      }
    } catch (e) {
      print('❌ Erro ao autenticar usuário: $e');
      // Propaga a exceção para que o controller possa tratar
      rethrow;
    }
  }
}
