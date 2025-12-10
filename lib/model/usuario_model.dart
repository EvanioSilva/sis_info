class Usuario {
  String? login;
  String? senha;
  bool? autenticado;

  Usuario({
    this.login,
    this.senha,
    this.autenticado,
  });

  factory Usuario.fromMap(Map<String, dynamic> map) {
    // Função auxiliar para limpar strings (remover espaços extras)
    String? cleanString(String? value) {
      return value?.trim().isEmpty == true ? null : value?.trim();
    }

    return Usuario(
      login: cleanString(map['login']?.toString()),
      senha: cleanString(map['senha']?.toString()),
      autenticado: map['autenticado'] != null
          ? (map['autenticado'] is bool
              ? map['autenticado'] as bool
              : map['autenticado'].toString().toLowerCase() == 'true')
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'login': login,
      'senha': senha,
      'autenticado': autenticado,
    };
  }
}






