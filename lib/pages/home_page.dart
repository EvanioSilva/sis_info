import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/app_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backgroundColor,
          child: Stack(
            children: [
              ListView(
                padding: const EdgeInsets.symmetric(vertical: 0),
                children: [
                  Stack(
                    children: [
                      _LoggedBarWidget(),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          margin: const EdgeInsets.only(top: 80.0),
                          child: _TrocarContaWidget(),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        _AcoesHistoricoWidget(),
                        _AcoesWidget(),
                        _OutrasAcoesWidget(),
                        const SizedBox(height: 20),
                        _AppVersionWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoggedBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: (controller) {
        final loginUsuario = controller.usuarioAutenticado?.login ?? '';
        final mensagemBemVindo =
            loginUsuario.isNotEmpty ? 'Bem vindo, $loginUsuario' : 'Bem vindo';

        return Container(
          color: primaryColor,
          height: 180,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              left: 0,
              right: 5,
            ),
            child: ListTile(
              title: Text(
                mensagemBemVindo,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: const Text(
                'Sistema',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
              leading: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: primaryColor,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const Flexible(
                    child: Text(
                      'Usuário',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TrocarContaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(3),
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, top: 0),
          child: Column(
            children: [
              _LogoWidget(),
              const Divider(
                height: 4,
                color: accentColor,
              ),
              Container(
                margin: const EdgeInsets.all(8),
                child: MaterialButton(
                  onPressed: () {},
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        onTap: () async {
                          _showEncerrarSessao();
                        },
                        minLeadingWidth: 0,
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        leading: const Icon(Icons.waving_hand_outlined),
                        title: const Text('Sair da Conta'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Future _showEncerrarSessao() async {
    return showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: const Text('ATENÇÃO'),
          content:
              const Text('Deseja realmente encerrar sessão deste usuário?'),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('NÃO'),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text('SIM'),
              onPressed: () {
                Get.back();
                // Implementar logout aqui
              },
            ),
          ],
        );
      },
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Center(
        child: Container(
          height: 120.0,
          width: 120.0,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              'assets/icons/familia_icon.svg',
              colorFilter: ColorFilter.mode(
                primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AcoesHistoricoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CardAcaoWidget(
                  title: 'Pesquisar Pessoa',
                  color: Colors.grey,
                  onTap: () {
                    Get.toNamed('/pesquisar-pessoa');
                  },
                  imagem:
                      Icon(Icons.person_search, size: 30, color: primaryColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CardAcaoWidget(
                  title: 'Ação 2',
                  color: Colors.grey,
                  onTap: () {
                    // Navegar para posts
                  },
                  imagem: Icon(Icons.article, size: 30, color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AcoesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CardAcaoWidget(
                  title: 'Ação 3',
                  color: Colors.grey,
                  onTap: () {
                    // Navegar para grupos
                  },
                  imagem: Icon(Icons.people, size: 40, color: primaryColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CardAcaoWidget(
                  title: 'Mensagens',
                  color: Colors.grey,
                  onTap: () {
                    // Navegar para mensagens
                  },
                  imagem: Icon(Icons.message, size: 30, color: primaryColor),
                  showBadge: false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OutrasAcoesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CardAcaoWidget(
                  title: 'Ação 4',
                  color: Colors.grey,
                  onTap: () {
                    // Navegar para eventos
                  },
                  imagem:
                      Icon(Icons.calendar_today, size: 40, color: primaryColor),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CardAcaoWidget(
                  title: 'Perfil',
                  color: Colors.grey,
                  onTap: () {
                    // Navegar para perfil
                  },
                  imagem: Icon(Icons.person, size: 50, color: primaryColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CardAcaoWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? imagem;
  final Color? color;
  final Function? onTap;
  final bool? showBadge;

  const CardAcaoWidget({
    Key? key,
    this.title,
    this.subTitle,
    this.imagem,
    this.color,
    this.onTap,
    this.showBadge = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10.0,
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              badges.Badge(
                showBadge: showBadge == true,
                badgeContent: const Text('0'),
                badgeColor: Colors.white,
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  width: 60,
                  height: 60,
                  child: imagem!,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                child: Text(
                  title!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        onTap: () => {onTap!()},
      ),
    );
  }
}

class _AppVersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.hasData
            ? '${snapshot.data!.version}+${snapshot.data!.buildNumber}'
            : '1.0.0+1';

        return Center(
          child: Container(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: backgroundColor,
                      ),
                      onPressed: () {
                        // Navegar para sobre
                      },
                      child: Icon(
                        Icons.info_outline,
                        size: 50,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Versão $version'),
              ],
            ),
          ),
        );
      },
    );
  }
}








