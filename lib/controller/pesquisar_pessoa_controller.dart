import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis_flutter/app_controller.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/store/pessoa_store.dart';

class PesquisarPessoaController extends GetxController {
  final AppController appController = Get.find<AppController>();
  final PessoaStore pessoaStore = PessoaStore();

  final TextEditingController pesquisaController = TextEditingController();

  bool isWaiting = false;
  String tipoPesquisa = 'Nome'; // Domicilio, Nis, Cpf, Nome
  bool somentePrograma = false;
  bool pesquisaExpandida = true;
  List<Pessoa> pessoasEncontradas = [];

  @override
  void onClose() {
    pesquisaController.dispose();
    super.onClose();
  }

  void setTipoPesquisa(String tipo) {
    tipoPesquisa = tipo;
    update(['tipo_pesquisa']);
  }

  void toggleSomentePrograma(bool? value) {
    somentePrograma = value ?? false;
    update(['checkbox_programa']);
  }

  Future<void> pesquisar() async {
    if (pesquisaController.text.trim().isEmpty) {
      appController.showSnackbar(
        'Atenção',
        'Por favor, informe um valor para pesquisa',
        cor: Colors.orange,
      );
      return;
    }

    isWaiting = true;
    update(['pesquisa']);

    try {
      final resultado = await pessoaStore.pesquisarPessoas(
        tipoPesquisa: tipoPesquisa,
        valorPesquisa: pesquisaController.text.trim(),
        somentePrograma: somentePrograma,
      );

      pessoasEncontradas = resultado;

      if (pessoasEncontradas.isEmpty) {
        appController.showInfo('Nenhuma pessoa encontrada');
      }

      update(['resultado']);
    } catch (e) {
      appController.showSnackbar(
        'Erro',
        'Erro ao pesquisar pessoas: ${e.toString()}',
        cor: Colors.red,
      );
    } finally {
      isWaiting = false;
      update(['pesquisa']);
    }
  }

  void limparPesquisa() {
    pesquisaController.clear();
    pessoasEncontradas = [];
    somentePrograma = false;
    tipoPesquisa = 'Nome';
    update(['pesquisa', 'resultado', 'tipo_pesquisa', 'checkbox_programa']);
  }

  void togglePesquisaExpandida() {
    pesquisaExpandida = !pesquisaExpandida;
    update(['pesquisa']);
  }
}
