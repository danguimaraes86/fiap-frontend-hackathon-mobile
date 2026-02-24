import "package:flutter/material.dart";

class CustomTheme {
  final TextTheme textTheme;

  const CustomTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1e477b),
      surfaceTint: Color(0xff395f94),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff395f94),
      onPrimaryContainer: Color(0xffc4d9ff),
      secondary: Color(0xff254f3a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3d6751),
      onSecondaryContainer: Color(0xffb5e3c8),
      tertiary: Color(0xff633569),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d4d82),
      onTertiaryContainer: Color(0xfffec7ff),
      error: Color(0xff7f2922),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff9e4037),
      onErrorContainer: Color(0xffffccc6),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff45474b),
      outline: Color(0xff76777c),
      outlineVariant: Color(0xffc6c6cb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffa7c8ff),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001c3b),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff1e477b),
      secondaryFixed: Color(0xffbfedd1),
      onSecondaryFixed: Color(0xff002113),
      secondaryFixedDim: Color(0xffa3d1b6),
      onSecondaryFixedVariant: Color(0xff254f3a),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff32073a),
      tertiaryFixedDim: Color(0xffedb3f0),
      onTertiaryFixedVariant: Color(0xff633569),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff033669),
      surfaceTint: Color(0xff395f94),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff395f94),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff123e2a),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff3d6751),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff502457),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff7d4d82),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff681914),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff9e4037),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff111111),
      onSurfaceVariant: Color(0xff34363a),
      outline: Color(0xff515257),
      outlineVariant: Color(0xff6c6d72),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffa7c8ff),
      primaryFixed: Color(0xff496ea4),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff2f568a),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4b765f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff335d48),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff8d5b92),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff724378),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc9c6c5),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xffebe7e7),
      surfaceContainerHigh: Color(0xffdfdcdb),
      surfaceContainerHighest: Color(0xffd4d1d0),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002c58),
      surfaceTint: Color(0xff395f94),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff214a7d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff053321),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff27513c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff451a4c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff66386b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5a0e0b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff822c24),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2a2c30),
      outlineVariant: Color(0xff48494d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffa7c8ff),
      primaryFixed: Color(0xff214a7d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003364),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff27513c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff0e3a27),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff66386b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4c2153),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbbb8b7),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff4f0ef),
      surfaceContainer: Color(0xffe5e2e1),
      surfaceContainerHigh: Color(0xffd7d4d3),
      surfaceContainerHighest: Color(0xffc9c6c5),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffa7c8ff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff003060),
      primaryContainer: Color(0xff395f94),
      onPrimaryContainer: Color(0xffc4d9ff),
      secondary: Color(0xffa3d1b6),
      onSecondary: Color(0xff0b3825),
      secondaryContainer: Color(0xff3d6751),
      onSecondaryContainer: Color(0xffb5e3c8),
      tertiary: Color(0xffedb3f0),
      onTertiary: Color(0xff4a1e50),
      tertiaryContainer: Color(0xff7d4d82),
      onTertiaryContainer: Color(0xfffec7ff),
      error: Color(0xffffb4aa),
      onError: Color(0xff60120f),
      errorContainer: Color(0xff9e4037),
      onErrorContainer: Color(0xffffccc6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc6c6cb),
      outline: Color(0xff909095),
      outlineVariant: Color(0xff45474b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff395f94),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001c3b),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff1e477b),
      secondaryFixed: Color(0xffbfedd1),
      onSecondaryFixed: Color(0xff002113),
      secondaryFixedDim: Color(0xffa3d1b6),
      onSecondaryFixedVariant: Color(0xff254f3a),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff32073a),
      tertiaryFixedDim: Color(0xffedb3f0),
      onTertiaryFixedVariant: Color(0xff633569),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353534),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcbddff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff00264d),
      primaryContainer: Color(0xff6d92ca),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb9e7cb),
      onSecondary: Color(0xff002c1b),
      secondaryContainer: Color(0xff6f9a82),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xfffeccff),
      onTertiary: Color(0xff3e1345),
      tertiaryContainer: Color(0xffb37fb7),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff510606),
      errorContainer: Color(0xffde7165),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdcdce1),
      outline: Color(0xffb1b1b7),
      outlineVariant: Color(0xff8f9095),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff1f487c),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff001129),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff033669),
      secondaryFixed: Color(0xffbfedd1),
      onSecondaryFixed: Color(0xff00150b),
      secondaryFixedDim: Color(0xffa3d1b6),
      onSecondaryFixedVariant: Color(0xff123e2a),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff24002c),
      tertiaryFixedDim: Color(0xffedb3f0),
      onTertiaryFixedVariant: Color(0xff502457),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff454444),
      surfaceContainerLowest: Color(0xff070707),
      surfaceContainerLow: Color(0xff1e1d1d),
      surfaceContainer: Color(0xff282828),
      surfaceContainerHigh: Color(0xff333232),
      surfaceContainerHighest: Color(0xff3e3d3d),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeaf0ff),
      surfaceTint: Color(0xffa7c8ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffa0c4ff),
      onPrimaryContainer: Color(0xff000b1e),
      secondary: Color(0xffccfbde),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff9fcdb2),
      onSecondaryContainer: Color(0xff000e06),
      tertiary: Color(0xffffeafb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffe9b0ec),
      onTertiaryContainer: Color(0xff1b0021),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff0eff5),
      outlineVariant: Color(0xffc2c2c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff1f487c),
      primaryFixed: Color(0xffd5e3ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffa7c8ff),
      onPrimaryFixedVariant: Color(0xff001129),
      secondaryFixed: Color(0xffbfedd1),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffa3d1b6),
      onSecondaryFixedVariant: Color(0xff00150b),
      tertiaryFixed: Color(0xffffd6fe),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffedb3f0),
      onTertiaryFixedVariant: Color(0xff24002c),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff51504f),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff201f1f),
      surfaceContainer: Color(0xff313030),
      surfaceContainerHigh: Color(0xff3c3b3b),
      surfaceContainerHighest: Color(0xff474646),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
