class Utils {
  /// Ofusca CPF e NIS conforme LGPD: mostra 3 primeiros e 2 últimos dígitos
  /// CPF Exemplo: "09311682690" -> "093.***.***-90"
  /// NIS Exemplo: "12345678901" -> "123.***.***-01"
  static String ofuscarDocumento(String? documento) {
    if (documento == null || documento.isEmpty) {
      return 'Não informado';
    }

    // Remove caracteres não numéricos
    final apenasNumeros = documento.replaceAll(RegExp(r'[^0-9]'), '');

    // Se não tiver pelo menos 5 dígitos, retorna mascarado
    if (apenasNumeros.length < 5) {
      return '***';
    }

    // Extrai os 3 primeiros e 2 últimos dígitos
    final primeiros3 = apenasNumeros.substring(0, 3);
    final ultimos2 = apenasNumeros.substring(apenasNumeros.length - 2);

    // Calcula quantos dígitos devem ser ofuscados
    final totalOcultos = apenasNumeros.length - 5;

    // Formata: 093.***.***-90 (para CPF) ou 123.***.***-01 (para NIS)
    return '$primeiros3.${'*' * totalOcultos}-$ultimos2';
  }

  static Map<String, String> getDeParaLabelsViews() {
    Map<String, String> dePara = {};

    // DE_PARA para EntidadeVwFamiliaResponsavelNovaRenda
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.cod_familiar_fam'] =
        'Cod. familiar -> Codigo familiar federal';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.num_nis_pessoa_atual'] =
        'Nis -> Numero do nis do responsável';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.num_cpf_pessoa'] =
        'Cpf -> Cpf do responsável';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.vlrrenda'] =
        'RPC calculada -> Renda percapta calculada';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.vl_renda_percapta_original'] =
        'RPC Cadastro -> Renda percapta do cadastro unico';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.estado_cadastral'] =
        'Estado cadastral -> Estado cadastral do responsável da familia';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.dta_entrevista_fam'] =
        'Dt. Entrevista -> Data da entrevista da familia';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.dt_ult_atualizacao'] =
        'Ult.Atualização -> Data da ultima atualização';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.dt_cdstr_atual_fmla'] =
        'Dt. Limite -> Data limite para atualização do cadastro';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.EdtStatusCadastro'] =
        'Status Cadastro';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.tem_menor_aprendiz'] =
        'Tem jovem aprendiz -> informa se a familia jovem aprendiz';
    dePara['EntidadeVwFamiliaResponsavelNovaRenda.dt_gradativo'] =
        'Dt. gradativo -> Data do acompanhamento gradativo';

    // DE_PARA para EntidadeVwFamiliaPessoaNovaRenda
    dePara['EntidadeVwFamiliaPessoaNovaRenda.num_ordem_pessoa'] = 'Ordem';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.num_nis_pessoa_atual'] =
        'Nis -> Numero do nis do responsável';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.num_cpf_pessoa'] =
        'Cpf -> Cpf do responsável';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.vlrrenda'] =
        'RPC calculada -> Renda percapta calculada';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.vl_renda_percapta_original'] =
        'RPC Cadastro -> Renda percapta do cadastro unico';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.estado_cadastral'] =
        'Estado cadastral -> Estado cadastral do responsável da familia';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.dta_entrevista_fam'] =
        'Dt. Entrevista -> Data da entrevista da familia';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.dt_ult_atualizacao'] =
        'Ult.Atualização -> Data da ultima atualização';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.dt_cdstr_atual_fmla'] =
        'Dt. Limite -> Data limite para atualização do cadastro';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.EdtStatusCadastro'] =
        'Status Cadastro';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.tem_menor_aprendiz'] =
        'Tem jovem aprendiz -> informa se a familia jovem aprendiz';
    dePara['EntidadeVwFamiliaPessoaNovaRenda.dt_gradativo'] =
        'Dt. gradativo -> Data do acompanhamento gradativo';

    // DE_PARA para EntidadeVwPessoaProgramaNovaRenda
    dePara['EntidadeVwPessoaProgramaNovaRenda.idfamilia'] = 'ID Familia';

    // DE_PARA para EntidadeVwNovaRendaMes
    dePara['EntidadeVwNovaRendaMes.idfamilia'] = 'ID Familia';

    // DE_PARA para EntidadeVwHistoricoFamiliaPessoa
    dePara['EntidadeVwHistoricoFamiliaPessoa.idfamilia'] = 'ID Familia';

    return dePara;
  }
}
