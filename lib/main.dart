import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sis_flutter/application/application.dart';
import 'package:sis_flutter/app_controller.dart';
import 'package:sis_flutter/pages/detalhes_pessoa_page.dart';
import 'package:sis_flutter/pages/home_page.dart';
import 'package:sis_flutter/pages/login_page.dart';
import 'package:sis_flutter/pages/pesquisar_pessoa_page.dart';
import 'package:sis_flutter/pages/splash_page.dart';
import 'package:sis_flutter/model/pessoa_model.dart';
import 'package:sis_flutter/service/pessoa_service.dart';
import 'package:sis_flutter/service/usuario_service.dart';
import 'package:sis_flutter/values/theme_dark.dart';
import 'package:sis_flutter/values/theme_light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Application.initialize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: GetMaterialApp(
        locale: const Locale('pt', 'BR'),
        title: 'sis',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        darkTheme: appThemeDark,
        themeMode: ThemeMode.light,
        theme: appThemeLight,
        home: const SplashPage(),
        initialBinding: BindingsBuilder(() {
          Get.put(AppController());
          Get.put(PessoaService());
          Get.put(UsuarioService());
        }),
        getPages: [
          GetPage(name: '/', page: () => const SplashPage()),
          GetPage(name: '/login', page: () => const LoginPage()),
          GetPage(name: '/home', page: () => const HomePage()),
          GetPage(
              name: '/pesquisar-pessoa',
              page: () => const PesquisarPessoaPage()),
          GetPage(
            name: '/detalhes-pessoa',
            page: () {
              final pessoa = Get.arguments as Pessoa;
              return DetalhesPessoaPage(pessoa: pessoa);
            },
          ),
        ],
      ),
    );
  }
}
