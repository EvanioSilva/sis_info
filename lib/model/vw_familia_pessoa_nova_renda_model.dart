class VwFamiliaPessoaNovaRendaModel {
  int? numOrdemPessoa;
  String? numNisPessoaAtual;
  String? numCpfPessoa;
  double? vlrrenda;
  double? vlRendaPercaptaOriginal;
  String? estadoCadastral;
  DateTime? dtaEntrevistaFam;
  DateTime? dtUltAtualizacao;
  DateTime? dtCdstrAtualFmla;
  String? edtStatusCadastro;
  String? temMenorAprendiz;
  DateTime? dtGradativo;

  VwFamiliaPessoaNovaRendaModel({
    this.numOrdemPessoa,
    this.numNisPessoaAtual,
    this.numCpfPessoa,
    this.vlrrenda,
    this.vlRendaPercaptaOriginal,
    this.estadoCadastral,
    this.dtaEntrevistaFam,
    this.dtUltAtualizacao,
    this.dtCdstrAtualFmla,
    this.edtStatusCadastro,
    this.temMenorAprendiz,
    this.dtGradativo,
  });

  factory VwFamiliaPessoaNovaRendaModel.fromJson(Map<String, dynamic> json) {
    return VwFamiliaPessoaNovaRendaModel(
      numOrdemPessoa: json['num_ordem_pessoa'],
      numNisPessoaAtual: json['num_nis_pessoa_atual'],
      numCpfPessoa: json['num_cpf_pessoa'],
      vlrrenda: json['vlrrenda']?.toDouble(),
      vlRendaPercaptaOriginal: json['vl_renda_percapta_original']?.toDouble(),
      estadoCadastral: json['estado_cadastral'],
      dtaEntrevistaFam: json['dta_entrevista_fam'] != null
          ? DateTime.tryParse(json['dta_entrevista_fam'])
          : null,
      dtUltAtualizacao: json['dt_ult_atualizacao'] != null
          ? DateTime.tryParse(json['dt_ult_atualizacao'])
          : null,
      dtCdstrAtualFmla: json['dt_cdstr_atual_fmla'] != null
          ? DateTime.tryParse(json['dt_cdstr_atual_fmla'])
          : null,
      edtStatusCadastro: json['EdtStatusCadastro'],
      temMenorAprendiz: json['tem_menor_aprendiz'],
      dtGradativo: json['dt_gradativo'] != null
          ? DateTime.tryParse(json['dt_gradativo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'num_ordem_pessoa': numOrdemPessoa,
      'num_nis_pessoa_atual': numNisPessoaAtual,
      'num_cpf_pessoa': numCpfPessoa,
      'vlrrenda': vlrrenda,
      'vl_renda_percapta_original': vlRendaPercaptaOriginal,
      'estado_cadastral': estadoCadastral,
      'dta_entrevista_fam': dtaEntrevistaFam?.toIso8601String(),
      'dt_ult_atualizacao': dtUltAtualizacao?.toIso8601String(),
      'dt_cdstr_atual_fmla': dtCdstrAtualFmla?.toIso8601String(),
      'EdtStatusCadastro': edtStatusCadastro,
      'tem_menor_aprendiz': temMenorAprendiz,
      'dt_gradativo': dtGradativo?.toIso8601String(),
    };
  }
}



