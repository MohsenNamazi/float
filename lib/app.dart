import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:float/routing/app_router.dart';
import 'package:float/theme/app_theme.dart';
import 'package:float/theme/theme_provider.dart';

class FloatApp extends ConsumerWidget {
  const FloatApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final themeVariant = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      title: 'Float',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.build(themeVariant),
      routerConfig: router,
    );
  }
}
