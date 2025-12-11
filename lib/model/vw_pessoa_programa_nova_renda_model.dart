class VwPessoaProgramaNovaRendaModel {
  int? idfamilia;

  VwPessoaProgramaNovaRendaModel({this.idfamilia});

  factory VwPessoaProgramaNovaRendaModel.fromJson(Map<String, dynamic> json) {
    return VwPessoaProgramaNovaRendaModel(
      idfamilia: json['idfamilia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idfamilia': idfamilia,
    };
  }
}




