import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sis_flutter/model/usuario_model.dart';

class UsuarioService extends GetxService {
  static const String baseUrl = 'http://pray4ever.net/api';

  /// Busca a URL base dinamicamente do endpoint grok
  String _obterUrlBase() {
    return 'https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis';
    // try {
    //   final uri = Uri.parse('$baseUrl/servico/pesquisar/grok');

    //   final response = await http.get(
    //     uri,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //     },
    //   ).timeout(
    //     const Duration(seconds: 30),
    //     onTimeout: () {
    //       throw Exception('Tempo de requisição excedido ao buscar URL base');
    //     },
    //   );

    //   if (response.statusCode == 200) {
    //     final Map<String, dynamic> jsonResponse = json.decode(response.body);
    //     final String? urlBase = jsonResponse['valor'] as String?;

    //     if (urlBase == null || urlBase.isEmpty) {
    //       throw Exception('URL base não encontrada na resposta');
    //     }

    //     return urlBase;
    //   } else {
    //     throw Exception(
    //         'Erro ao buscar URL base: ${response.statusCode} - ${response.body}');
    //   }
    // } catch (e) {
    //   throw Exception('Erro ao obter URL base: ${e.toString()}');
    // }
  }

  /// Autentica um usuário na API
  /// [usuario] é o objeto Usuario com login e senha preenchidos
  /// Retorna um Usuario com o campo autenticado preenchido
  Future<Usuario> autenticar(Usuario usuario) async {
    try {
      // Obter a URL base dinamicamente
      final String urlBase = _obterUrlBase();
      final uri = Uri.parse('$urlBase/autenticar');

      // Converter o usuário para JSON
      final body = json.encode(usuario.toMap());

      // Fazer a requisição POST
      final response = await http
          .post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: body,
      )
          .timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('Tempo de requisição excedido');
        },
      );

      // Verificar se a requisição foi bem-sucedida
      if (response.statusCode == 200) {
        // Decodificar o JSON
        final Map<String, dynamic> jsonResponse =
            json.decode(response.body) as Map<String, dynamic>;

        // Converter para Usuario
        final Usuario usuarioAutenticado = Usuario.fromMap(jsonResponse);

        return usuarioAutenticado;
      } else {
        throw Exception(
            'Erro ao autenticar usuário: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro ao autenticar usuário: ${e.toString()}');
    }
  }
}
