class VwNovaRendaMesModel {
  int? idfamilia;

  VwNovaRendaMesModel({this.idfamilia});

  factory VwNovaRendaMesModel.fromJson(Map<String, dynamic> json) {
    return VwNovaRendaMesModel(
      idfamilia: json['idfamilia'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idfamilia': idfamilia,
    };
  }
}



