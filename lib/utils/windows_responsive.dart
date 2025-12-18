import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class WindowsResponsive {
  /// Retorna true se estiver rodando no Windows
  static bool get isWindows => Platform.isWindows;

  /// Retorna o tamanho máximo de largura para conteúdo centralizado
  static double getMaxContentWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isWindows) {
      // No Windows, limitar largura máxima para melhor legibilidade
      if (width > 1600) return 1400;
      if (width > 1200) return 1200;
      return width * 0.9;
    }
    return width;
  }

  /// Retorna padding responsivo baseado no tamanho da tela
  static EdgeInsets getResponsivePadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isWindows) {
      if (width > 1600) {
        return const EdgeInsets.symmetric(horizontal: 80, vertical: 40);
      } else if (width > 1200) {
        return const EdgeInsets.symmetric(horizontal: 60, vertical: 30);
      } else if (width > 800) {
        return const EdgeInsets.symmetric(horizontal: 40, vertical: 20);
      }
    }
    return const EdgeInsets.all(20);
  }

  /// Retorna o número de colunas para grid baseado no tamanho da tela
  static int getGridCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isWindows) {
      if (width > 1600) return 4;
      if (width > 1200) return 3;
      if (width > 800) return 2;
    }
    return 2;
  }

  /// Retorna espaçamento responsivo
  static double getResponsiveSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (isWindows) {
      if (width > 1600) return 30;
      if (width > 1200) return 25;
      return 20;
    }
    return 15;
  }

  /// Retorna tamanho de fonte responsivo
  static double getResponsiveFontSize(BuildContext context, double baseSize) {
    final width = MediaQuery.of(context).size.width;
    if (isWindows) {
      if (width > 1600) return baseSize * 1.2;
      if (width > 1200) return baseSize * 1.1;
      return baseSize;
    }
    return baseSize;
  }

  /// Retorna se deve usar layout de desktop
  static bool isDesktopLayout(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return isWindows && width > 800;
  }

  /// Widget que centraliza conteúdo com largura máxima no Windows
  static Widget centerContent({
    required BuildContext context,
    required Widget child,
  }) {
    if (isWindows) {
      return Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: getMaxContentWidth(context),
          ),
          child: child,
        ),
      );
    }
    return child;
  }
}

