import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:float/core/constants/app_constants.dart';
import 'app_colors.dart';

part 'theme_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  @override
  AppThemeVariant build() {
    // Kick off async load; returns default immediately to avoid blocking.
    _loadSaved();
    return AppThemeVariant.pastelOcean;
  }

  Future<void> _loadSaved() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(AppConstants.themePrefKey);
    if (saved == null) return;
    final variant = AppThemeVariant.values.firstWhere(
      (v) => v.name == saved,
      orElse: () => AppThemeVariant.pastelOcean,
    );
    state = variant;
  }

  Future<void> select(AppThemeVariant variant) async {
    state = variant;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.themePrefKey, variant.name);
  }
}
