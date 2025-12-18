import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis_flutter/app_controller.dart';
import 'package:sis_flutter/model/usuario_model.dart';
import 'package:sis_flutter/service/usuario_service.dart';

class LoginController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final UsuarioService usuarioService = Get.find<UsuarioService>();

  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  bool isWaiting = false;
  bool obscurePassword = true;

  @override
  void onClose() {
    usuarioController.dispose();
    senhaController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update(['password']);
  }

  Future<void> testarConectividade() async {
    isWaiting = true;
    update(['connectivity']);

    try {
      final conectado = await usuarioService.testarConectividade();

      if (conectado) {
        appController.showInfo('Conectividade OK! Servidor respondendo.');
      } else {
        appController.showSnackbar(
          'Erro de Conexão',
          'Não foi possível conectar ao servidor. Verifique se o servidor está rodando.',
          cor: Colors.red,
        );
      }
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao testar conectividade: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaiting = false;
      update(['connectivity']);
    }
  }

  Future<void> fazerLogin() async {
    if (usuarioController.text.isEmpty || senhaController.text.isEmpty) {
      appController.showSnackbar(
        'Atenção',
        'Por favor, preencha todos os campos',
        cor: Colors.orange,
      );
      return;
    }

    isWaiting = true;
    update(['login']);

    try {
      // Criar objeto Usuario com login e senha
      final usuario = Usuario(
        login: usuarioController.text.trim(),
        senha: senhaController.text.trim(),
      );

      // Autenticar o usuário
      final usuarioAutenticado = await usuarioService.autenticar(usuario);

      // Verificar se a autenticação foi bem-sucedida usando o campo autenticado
      if (usuarioAutenticado.autenticado == true) {
        // Salvar o usuário autenticado no AppController
        appController.setUsuarioAutenticado(usuarioAutenticado);

        appController.showInfo('Login realizado com sucesso!');

        // Navegar para a home após login bem-sucedido
        Get.offAllNamed('/home');
      } else {
        // Se autenticado for false ou null, login falhou
        appController.showSnackbar(
          'Erro',
          'Usuário ou senha inválidos',
          cor: Colors.red,
        );
      }
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao realizar login: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaiting = false;
      update(['login']);
    }
  }
}
