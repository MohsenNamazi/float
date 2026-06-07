import 'package:flutter/material.dart';

enum AppThemeVariant {
  pastelOcean('Muted Pastel Ocean'),
  sageGarden('Soft Sage Garden'),
  terracotta('Warm Terracotta'),
  midnightLavender('Midnight Lavender');

  const AppThemeVariant(this.displayName);
  final String displayName;
}

abstract class ThemeColors {
  const ThemeColors();
  Color get seed;
  Color get surface;
  Color get cardFront;
  Color get cardBack;
  bool get isDark;
}

abstract final class AppColors {
  // ── Muted Pastel Ocean ──────────────────────────────────────────────────
  static const ocean = _OceanColors();

  // ── Soft Sage Garden ────────────────────────────────────────────────────
  static const sage = _SageColors();

  // ── Warm Terracotta ─────────────────────────────────────────────────────
  static const terracotta = _TerracottaColors();

  // ── Midnight Lavender ───────────────────────────────────────────────────
  static const lavender = _LavenderColors();

  static ThemeColors of(AppThemeVariant variant) => switch (variant) {
        AppThemeVariant.pastelOcean => ocean,
        AppThemeVariant.sageGarden => sage,
        AppThemeVariant.terracotta => terracotta,
        AppThemeVariant.midnightLavender => lavender,
      };
}

class _OceanColors extends ThemeColors {
  const _OceanColors();
  @override
  Color get seed => const Color(0xFF5B9BD5);
  @override
  Color get surface => const Color(0xFFF0F6FC);
  @override
  Color get cardFront => const Color(0xFFDAEBF7);
  @override
  Color get cardBack => const Color(0xFFB8D8EF);
  @override
  bool get isDark => false;
}

class _SageColors extends ThemeColors {
  const _SageColors();
  @override
  Color get seed => const Color(0xFF7BA05B);
  @override
  Color get surface => const Color(0xFFF2F7EE);
  @override
  Color get cardFront => const Color(0xFFD8EBD0);
  @override
  Color get cardBack => const Color(0xFFBDD9B2);
  @override
  bool get isDark => false;
}

class _TerracottaColors extends ThemeColors {
  const _TerracottaColors();
  @override
  Color get seed => const Color(0xFFB5634A);
  @override
  Color get surface => const Color(0xFFFBF2EE);
  @override
  Color get cardFront => const Color(0xFFF2D9CF);
  @override
  Color get cardBack => const Color(0xFFE8C4B5);
  @override
  bool get isDark => false;
}

class _LavenderColors extends ThemeColors {
  const _LavenderColors();
  @override
  Color get seed => const Color(0xFF8B7FC4);
  @override
  Color get surface => const Color(0xFF1E1B2E);
  @override
  Color get cardFront => const Color(0xFF2D2645);
  @override
  Color get cardBack => const Color(0xFF3D3560);
  @override
  bool get isDark => true;
}

/// Deck accent colors — one per palette option, used in DeckCard and create dialog.
const Map<String, Color> deckAccentColors = {
  'pastelOcean': Color(0xFF5B9BD5),
  'sageGarden': Color(0xFF7BA05B),
  'terracotta': Color(0xFFB5634A),
  'midnightLavender': Color(0xFF8B7FC4),
  'coral': Color(0xFFE07070),
  'honey': Color(0xFFD4A842),
  'mint': Color(0xFF5BB89B),
  'blush': Color(0xFFCE7E9B),
};
