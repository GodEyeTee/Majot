import 'package:flutter/material.dart';

// Custom Theme Properties
@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
    required this.primaryButtonColor,
    required this.secondaryButtonColor,
    required this.cardBorderColor,
    required this.accentColor,
    required this.defaultBorderRadius,
    required this.defaultPadding,
  });
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final Color cardBorderColor;
  final Color accentColor;
  final BorderRadius defaultBorderRadius;
  final EdgeInsets defaultPadding;

  @override
  ThemeExtension<AppThemeExtension> copyWith({
    Color? primaryButtonColor,
    Color? secondaryButtonColor,
    Color? cardBorderColor,
    Color? accentColor,
    BorderRadius? defaultBorderRadius,
    EdgeInsets? defaultPadding,
  }) {
    return AppThemeExtension(
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
      secondaryButtonColor: secondaryButtonColor ?? this.secondaryButtonColor,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      accentColor: accentColor ?? this.accentColor,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      defaultPadding: defaultPadding ?? this.defaultPadding,
    );
  }

  @override
  ThemeExtension<AppThemeExtension> lerp(
      covariant ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      primaryButtonColor:
          Color.lerp(primaryButtonColor, other.primaryButtonColor, t)!,
      secondaryButtonColor:
          Color.lerp(secondaryButtonColor, other.secondaryButtonColor, t)!,
      cardBorderColor: Color.lerp(cardBorderColor, other.cardBorderColor, t)!,
      accentColor: Color.lerp(accentColor, other.accentColor, t)!,
      defaultBorderRadius:
          BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
      defaultPadding: EdgeInsets.lerp(defaultPadding, other.defaultPadding, t)!,
    );
  }
}

// Extension เพื่อเข้าถึง Theme Extension ได้ง่าย
extension AppThemeExtensionX on ThemeData {
  AppThemeExtension get appTheme => extension<AppThemeExtension>()!;
}
