import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/app_controller.dart';
import 'package:sis_flutter/utils/windows_responsive.dart';

class _FadeInAnimation extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const _FadeInAnimation({
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<_FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<_FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final padding = WindowsResponsive.getResponsivePadding(context);
    final spacing = WindowsResponsive.getResponsiveSpacing(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: WindowsResponsive.centerContent(
          context: context,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _LoggedBarWidget(),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColor,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: spacing),
                      _FadeInAnimation(
                        delay: const Duration(milliseconds: 200),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding.horizontal),
                          child: _TrocarContaWidget(),
                        ),
                      ),
                      SizedBox(height: spacing),
                      _FadeInAnimation(
                        delay: const Duration(milliseconds: 400),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding.horizontal),
                          child: _AcoesGridWidget(),
                        ),
                      ),
                      SizedBox(height: spacing),
                      _FadeInAnimation(
                        delay: const Duration(milliseconds: 600),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: padding.horizontal),
                          child: _AppVersionWidget(),
                        ),
                      ),
                      SizedBox(height: spacing),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoggedBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    final padding = WindowsResponsive.getResponsivePadding(context);
    final fontSize = WindowsResponsive.getResponsiveFontSize(context, 16);

    return GetBuilder<AppController>(
      builder: (controller) {
        final loginUsuario = controller.usuarioAutenticado?.login ?? '';

        return Container(
          height: isDesktop ? 130 : 110,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                primaryColor,
                primaryColor.withOpacity(0.9),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: primaryColor.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: padding.horizontal,
                  vertical: isDesktop ? 20 : 12),
              child: Row(
                children: [
                  // Avatar minimalista
                  Container(
                    width: isDesktop ? 60 : 45,
                    height: isDesktop ? 60 : 45,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      size: isDesktop ? 28 : 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: isDesktop ? 16 : 12),

                  // Informações do usuário - mais compactas
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Olá, ${loginUsuario.isNotEmpty ? loginUsuario : 'Visitante'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: isDesktop ? 4 : 2),
                        Row(
                          children: [
                            Icon(
                              Icons.business,
                              size: isDesktop ? 16 : 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                            SizedBox(width: isDesktop ? 6 : 4),
                            Text(
                              'SIS',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: isDesktop ? 14 : 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Ações rápidas
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white.withOpacity(0.8),
                          size: isDesktop ? 26 : 22,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: isDesktop ? 12 : 8),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.white.withOpacity(0.8),
                          size: isDesktop ? 26 : 22,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
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
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    final padding = WindowsResponsive.getResponsivePadding(context);
    final spacing = WindowsResponsive.getResponsiveSpacing(context);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isDesktop ? 24 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: isDesktop ? 25 : 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? padding.horizontal * 0.5 : 20),
        child: Column(
          children: [
            _LogoWidget(),
            SizedBox(height: spacing),
            Container(
              width: double.infinity,
              height: isDesktop ? 60 : 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(isDesktop ? 18 : 15),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  _showEncerrarSessao();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(isDesktop ? 18 : 15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout,
                        color: Colors.white, size: isDesktop ? 24 : 20),
                    SizedBox(width: isDesktop ? 12 : 10),
                    Text(
                      'Sair da Conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: WindowsResponsive.getResponsiveFontSize(
                            context, 16),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    final size = isDesktop ? 140.0 : 100.0;

    return Center(
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(0.2),
              primaryColor.withOpacity(0.1),
            ],
          ),
          shape: BoxShape.circle,
          border: Border.all(
            color: primaryColor.withOpacity(0.3),
            width: isDesktop ? 4 : 3,
          ),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.2),
              blurRadius: isDesktop ? 20 : 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: CircleAvatar(
          radius: isDesktop ? 65 : 45,
          backgroundImage: const AssetImage('assets/icons/familia.png'),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}

class _AcoesGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> acoes = [
      {
        'title': 'Pesquisar Pessoa',
        'icon': Icons.person_search,
        'color': primaryColor,
        'onTap': () => Get.toNamed('/pesquisar-pessoa'),
        'showBadge': false,
      },
      {
        'title': 'Relatórios',
        'icon': Icons.article,
        'color': Colors.blue,
        'onTap': () {},
        'showBadge': false,
      },
      {
        'title': 'Famílias',
        'icon': Icons.people,
        'color': Colors.green,
        'onTap': () {},
        'showBadge': false,
      },
      {
        'title': 'Mensagens',
        'icon': Icons.message,
        'color': Colors.orange,
        'onTap': () {},
        'showBadge': true,
      },
      {
        'title': 'Calendário',
        'icon': Icons.calendar_today,
        'color': Colors.purple,
        'onTap': () {},
        'showBadge': false,
      },
      {
        'title': 'Perfil',
        'icon': Icons.person,
        'color': Colors.teal,
        'onTap': () {},
        'showBadge': false,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              bottom: WindowsResponsive.getResponsiveSpacing(context)),
          child: Text(
            'Ações Disponíveis',
            style: TextStyle(
              fontSize: WindowsResponsive.getResponsiveFontSize(context, 20),
              fontWeight: FontWeight.w700,
              color: Colors.grey.shade800,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount =
                WindowsResponsive.getGridCrossAxisCount(context);
            final spacing = WindowsResponsive.getResponsiveSpacing(context);

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 1.0,
              ),
              itemCount: acoes.length,
              itemBuilder: (context, index) {
                final acao = acoes[index];
                return CardAcaoWidget(
                  title: acao['title'],
                  color: acao['color'],
                  onTap: acao['onTap'],
                  showBadge: acao['showBadge'],
                  imagem: Icon(
                    acao['icon'],
                    size: WindowsResponsive.isDesktopLayout(context) ? 32 : 28,
                    color: Colors.white,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class CardAcaoWidget extends StatefulWidget {
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
  State<CardAcaoWidget> createState() => _CardAcaoWidgetState();
}

class _CardAcaoWidgetState extends State<CardAcaoWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: _onTapCancel,
            onTap: () => widget.onTap?.call(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.grey.shade50,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(0.8),
                    blurRadius: 15,
                    offset: const Offset(-5, -5),
                  ),
                ],
                border: Border.all(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          widget.color ?? primaryColor,
                          (widget.color ?? primaryColor).withOpacity(0.7),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color:
                              (widget.color ?? primaryColor).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: badges.Badge(
                      showBadge: widget.showBadge == true,
                      badgeContent:
                          const Text('0', style: TextStyle(fontSize: 10)),
                      badgeColor: Colors.red,
                      position: badges.BadgePosition.topEnd(top: -5, end: -5),
                      child: IconTheme(
                        data: const IconThemeData(size: 24),
                        child: widget.imagem!,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.title!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                    textAlign: TextAlign.center,
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

class _AppVersionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        final version = snapshot.hasData
            ? '${snapshot.data!.version}+${snapshot.data!.buildNumber}'
            : '1.0.0+1';

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sobre o App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Versão $version',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [primaryColor, primaryColor.withOpacity(0.8)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: IconButton(
                  onPressed: () {
                    // Navegar para sobre
                  },
                  icon: const Icon(
                    Icons.info_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
