import 'package:get/get.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/service/pessoa_service.dart';

class PessoaStore {
  final PessoaService _pessoaService = Get.find<PessoaService>();

  /// Pesquisa pessoas na API
  /// [tipoPesquisa] pode ser: 'Domicilio', 'Nis', 'Cpf', 'Nome'
  /// [valorPesquisa] é o valor a ser pesquisado
  /// [somentePrograma] indica se deve filtrar apenas pessoas no programa
  Future<List<Pessoa>> pesquisarPessoas({
    required String tipoPesquisa,
    required String valorPesquisa,
    bool somentePrograma = false,
  }) async {
    if (valorPesquisa.trim().isEmpty) {
      return [];
    }

    // Mapear o tipo de pesquisa para os parâmetros da API
    String? codFamiliar;
    String? cpf;
    String? nis;
    String? nome;
    String? tipoResponsavel;

    switch (tipoPesquisa) {
      case 'Domicilio':
        codFamiliar = valorPesquisa.trim();
        break;
      case 'Cpf':
        cpf = valorPesquisa.trim();
        break;
      case 'Nis':
        nis = valorPesquisa.trim();
        break;
      case 'Nome':
        nome = valorPesquisa.trim();
        break;
    }

    // Buscar pessoas na API
    List<Pessoa> pessoas = await _pessoaService.pesquisarPessoas(
      codFamiliar: codFamiliar,
      cpf: cpf,
      nis: nis,
      nome: nome,
      tipoResponsavel: tipoResponsavel,
    );

    // Filtrar apenas pessoas no programa se solicitado
    if (somentePrograma) {
      pessoas = pessoas.where((p) => p.temCadunico == 'S').toList();
    }

    return pessoas;
  }
}
