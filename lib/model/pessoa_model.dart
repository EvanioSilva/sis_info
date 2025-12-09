class Pessoa {
  String? codFamiliarFam;
  int? numOrdemPessoa;
  String? numNisPessoaAtual;
  String? numCpfPessoa;
  String? nomPessoa;
  DateTime? dtaNascPessoa;
  String? temCadunico;
  String? nomCompletoMaePessoa;
  int? idfamilia;
  int? idpessoa;
  int? idestadocadastral;
  String? tipoResponsavel;

  Pessoa({
    this.codFamiliarFam,
    this.numOrdemPessoa,
    this.numNisPessoaAtual,
    this.numCpfPessoa,
    this.nomPessoa,
    this.dtaNascPessoa,
    this.temCadunico,
    this.nomCompletoMaePessoa,
    this.idfamilia,
    this.idpessoa,
    this.idestadocadastral,
    this.tipoResponsavel,
  });

  factory Pessoa.fromMap(Map<String, dynamic> map) {
    // Função auxiliar para limpar strings (remover espaços extras)
    String? cleanString(String? value) {
      return value?.trim().isEmpty == true ? null : value?.trim();
    }

    return Pessoa(
      codFamiliarFam: cleanString(map['cod_familiar_fam']?.toString()),
      numOrdemPessoa: map['num_ordem_pessoa'] != null
          ? int.tryParse(map['num_ordem_pessoa'].toString())
          : null,
      numNisPessoaAtual: cleanString(map['num_nis_pessoa_atual']?.toString()),
      numCpfPessoa: cleanString(map['num_cpf_pessoa']?.toString()),
      nomPessoa: cleanString(map['nom_pessoa']?.toString()),
      dtaNascPessoa: map['dta_nasc_pessoa'] != null
          ? DateTime.tryParse(map['dta_nasc_pessoa'].toString())
          : null,
      temCadunico: cleanString(map['tem_cadunico']?.toString()),
      nomCompletoMaePessoa:
          cleanString(map['nom_completo_mae_pessoa']?.toString()),
      idfamilia: map['idfamilia'] != null
          ? int.tryParse(map['idfamilia'].toString())
          : null,
      idpessoa: map['idpessoa'] != null
          ? int.tryParse(map['idpessoa'].toString())
          : null,
      idestadocadastral: map['idestadocadastral'] != null
          ? int.tryParse(map['idestadocadastral'].toString())
          : null,
      tipoResponsavel: cleanString(map['tipo_responsavel']?.toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cod_familiar_fam': codFamiliarFam,
      'num_ordem_pessoa': numOrdemPessoa,
      'num_nis_pessoa_atual': numNisPessoaAtual,
      'num_cpf_pessoa': numCpfPessoa,
      'nom_pessoa': nomPessoa,
      'dta_nasc_pessoa': dtaNascPessoa?.toIso8601String(),
      'tem_cadunico': temCadunico,
      'nom_completo_mae_pessoa': nomCompletoMaePessoa,
      'idfamilia': idfamilia,
      'idpessoa': idpessoa,
      'idestadocadastral': idestadocadastral,
      'tipo_responsavel': tipoResponsavel,
    };
  }
}
