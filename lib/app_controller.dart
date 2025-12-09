import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/model/usuario_model.dart';

class AppController extends GetxController {
  /// A referência ao objeto de sessão do aplicativo
  late SharedPreferences _session;

  bool isWaiting = false;

  final GlobalKey<ScaffoldState> scaffoldKeyMenuDrawer =
      GlobalKey<ScaffoldState>();

  int idxPage = 0;

  List<String> pagesNavBar = [];

  Usuario? usuarioAutenticado;

  @override
  Future<void> onInit() async {
    super.onInit();
    await GetStorage.init('sis');

    await initSession();
  }

  /// Inicializa a sessão do aplicativo
  Future initSession() async {
    _session = await SharedPreferences.getInstance();
    await initializeDateFormatting('pt_BR');
  }

  /// Referência ao objeto da sessão do aplicativo
  SharedPreferences get session => _session;

  /// Exibe uma [mensagem] com um [titulo] e [cor] específica interrompendo o
  /// fluxo de interação do usuário
  void showSnackbar(
    String titulo,
    String mensagem, {
    Color cor = Colors.red,
    Color textColor = Colors.white,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 5),
  }) {
    Get.snackbar(
      titulo,
      mensagem,
      backgroundColor: cor,
      colorText: textColor,
      snackPosition: snackPosition,
      duration: duration,
    );
  }

  /// Exibe uma [mensagem] de alerta na [cor] no centro da tela sem
  /// interromper o usuário
  void showAlert(
    String mensagem, {
    Color cor = Colors.red,
    Duration duration = const Duration(seconds: 2),
  }) {
    showToast(
      mensagem,
      backgroundColor: cor,
      textPadding: const EdgeInsets.all(12),
      duration: duration,
    );
  }

  void showInfo(
    String mensagem, {
    Duration duration = const Duration(seconds: 2),
  }) {
    showToast(
      mensagem,
      backgroundColor: primaryColor,
      textPadding: const EdgeInsets.all(12),
      duration: duration,
    );
  }

  /// Exibe o indicador de progresso com uma [mensagem]
  void showIndicator(String mensagem) {
    Get.dialog(
      PopScope(
        canPop: false,
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(mensagem)
            ],
          ),
        ),
      ),
    );
  }

  void closeDrawer() {
    scaffoldKeyMenuDrawer.currentState?.openEndDrawer();
  }

  void goToPage(pageName) {
    int tmp = pagesNavBar.indexOf(pageName);
    if (tmp >= 0) {
      idxPage = tmp;
      closeDrawer();
      update();
    }
  }

  void setIdxPage(index) {
    idxPage = index;
    update();
  }

  /// Define o usuário autenticado
  void setUsuarioAutenticado(Usuario usuario) {
    usuarioAutenticado = usuario;
    update();
  }

  /// Limpa o usuário autenticado (logout)
  void limparUsuarioAutenticado() {
    usuarioAutenticado = null;
    update();
  }
}
