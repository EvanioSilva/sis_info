import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sis_flutter/model/usuario_model.dart';

class UsuarioService extends GetxService {
  static const String baseUrl =
      'https://unseraphic-nonselective-shantae.ngrok-free.dev/api/sis';

  /// Autentica um usuário na API
  /// [usuario] é o objeto Usuario com login e senha preenchidos
  /// Retorna um Usuario com o campo autenticado preenchido
  Future<Usuario> autenticar(Usuario usuario) async {
    try {
      final uri = Uri.parse('$baseUrl/autenticar');

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
