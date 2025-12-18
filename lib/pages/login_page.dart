import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis_flutter/controller/login_controller.dart';
import 'package:sis_flutter/values/colors.dart';
import 'package:sis_flutter/utils/windows_responsive.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    final isDesktop = WindowsResponsive.isDesktopLayout(context);
    final padding = WindowsResponsive.getResponsivePadding(context);
    final spacing = WindowsResponsive.getResponsiveSpacing(context);
    final maxWidth = WindowsResponsive.getMaxContentWidth(context);
    
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: GetBuilder<LoginController>(
          id: 'login',
          builder: (controller) {
            return Center(
              child: SingleChildScrollView(
                padding: padding,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 500 : maxWidth,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo ou ícone
                      Container(
                        height: isDesktop ? 150.0 : 120.0,
                        width: isDesktop ? 150.0 : 120.0,
                        decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.lock_outline,
                          size: isDesktop ? 75 : 60,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spacing * 2),
                      
                      // Título
                      Text(
                        'Login',
                        style: TextStyle(
                          fontSize: WindowsResponsive.getResponsiveFontSize(context, 32),
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      SizedBox(height: spacing * 2),

                      // Campo de usuário
                      TextField(
                        controller: controller.usuarioController,
                        style: TextStyle(
                          fontSize: WindowsResponsive.getResponsiveFontSize(context, 16),
                        ),
                        decoration: InputDecoration(
                          labelText: 'Usuário',
                          hintText: 'Digite seu usuário',
                          prefixIcon: Icon(Icons.person, color: primaryColor, size: isDesktop ? 28 : 24),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                            borderSide: BorderSide(color: primaryColor, width: 2),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: isDesktop ? 20 : 16,
                            vertical: isDesktop ? 20 : 16,
                          ),
                        ),
                        enabled: !controller.isWaiting,
                      ),
                      SizedBox(height: spacing),

                      // Campo de senha
                      GetBuilder<LoginController>(
                        id: 'password',
                        builder: (controller) {
                          return TextField(
                            controller: controller.senhaController,
                            obscureText: controller.obscurePassword,
                            style: TextStyle(
                              fontSize: WindowsResponsive.getResponsiveFontSize(context, 16),
                            ),
                            decoration: InputDecoration(
                              labelText: 'Senha',
                              hintText: 'Digite sua senha',
                              prefixIcon: Icon(Icons.lock, color: primaryColor, size: isDesktop ? 28 : 24),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: primaryColor,
                                  size: isDesktop ? 28 : 24,
                                ),
                                onPressed: controller.togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                                borderSide: BorderSide(color: primaryColor, width: 2),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: isDesktop ? 20 : 16,
                                vertical: isDesktop ? 20 : 16,
                              ),
                            ),
                            enabled: !controller.isWaiting,
                          );
                        },
                      ),
                      SizedBox(height: spacing),

                      // Botão de teste de conectividade
                      GetBuilder<LoginController>(
                        id: 'connectivity',
                        builder: (controller) {
                          return SizedBox(
                            width: double.infinity,
                            height: isDesktop ? 50 : 40,
                            child: controller.isWaiting
                                ? Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.orange,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : TextButton.icon(
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                                        side: const BorderSide(color: Colors.orange),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: isDesktop ? 16 : 12,
                                      ),
                                    ),
                                    onPressed: controller.testarConectividade,
                                    icon: Icon(Icons.wifi_tethering, size: isDesktop ? 22 : 18),
                                    label: Text(
                                      'Testar Conexão',
                                      style: TextStyle(
                                        fontSize: WindowsResponsive.getResponsiveFontSize(context, 14),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: spacing),

                      // Botão de login
                      SizedBox(
                        width: double.infinity,
                        height: isDesktop ? 60 : 50,
                        child: controller.isWaiting
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: primaryColor,
                                ),
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(isDesktop ? 12 : 8),
                                  ),
                                  elevation: 2,
                                ),
                                onPressed: controller.fazerLogin,
                                child: Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: WindowsResponsive.getResponsiveFontSize(context, 18),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

