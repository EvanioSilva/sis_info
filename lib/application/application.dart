import 'package:flutter/material.dart';

abstract class Application {
  static GlobalKey<NavigatorState> navKey = GlobalKey();

  /// Inicialização das definições do app.
  static Future initialize() async {
    // Configurações iniciais do app podem ser adicionadas aqui
  }
}











