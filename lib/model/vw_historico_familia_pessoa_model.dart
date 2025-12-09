class VwHistoricoFamiliaPessoaModel {
  int? idfamilia;

  VwHistoricoFamiliaPessoaModel({this.idfamilia});

  factory VwHistoricoFamiliaPessoaModel.fromJson(Map<String, dynamic> json) {
    return VwHistoricoFamiliaPessoaModel(
      idfamilia: json['idfamilia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idfamilia': idfamilia,
    };
  }
}
