import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis_flutter/controller/login_controller.dart';
import 'package:sis_flutter/values/colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: GetBuilder<LoginController>(
          id: 'login',
          builder: (controller) {
            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo ou ícone
                    Container(
                      height: 120.0,
                      width: 120.0,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline,
                        size: 60,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Título
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Campo de usuário
                    TextField(
                      controller: controller.usuarioController,
                      decoration: InputDecoration(
                        labelText: 'Usuário',
                        hintText: 'Digite seu usuário',
                        prefixIcon: Icon(Icons.person, color: primaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: primaryColor, width: 2),
                        ),
                      ),
                      enabled: !controller.isWaiting,
                    ),
                    const SizedBox(height: 20),

                    // Campo de senha
                    GetBuilder<LoginController>(
                      id: 'password',
                      builder: (controller) {
                        return TextField(
                          controller: controller.senhaController,
                          obscureText: controller.obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Digite sua senha',
                            prefixIcon: Icon(Icons.lock, color: primaryColor),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: primaryColor,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          enabled: !controller.isWaiting,
                        );
                      },
                    ),
                    const SizedBox(height: 40),

                    // Botão de login
                    SizedBox(
                      width: double.infinity,
                      height: 50,
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
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: controller.fazerLogin,
                              child: const Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

