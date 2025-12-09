import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sis_flutter/values/colors.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navegar para a tela de login após um delay
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed('/login');
    });

    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/familia.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(height: 30),
              const Text(
                'SIS - Sistema de Informação Social',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
