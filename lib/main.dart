import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme.dart';
import 'core/constants.dart';
import 'state/providers.dart';
import 'features/auth/login_screen.dart';
import 'features/home/home_screen.dart';
import 'features/search/search_screen.dart';
import 'features/product/product_detail_screen.dart';
import 'features/kit_builder/kit_builder_screen.dart';
import 'features/watchlist/watchlist_screen.dart';

void main() {
  runApp(const ProviderScope(child: ShopParvaApp()));
}

final _router = GoRouter(
  initialLocation: '/login', // Start at login for demo
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/search', builder: (context, state) => const SearchScreen()),
    GoRoute(path: '/kit-builder', builder: (context, state) => const KitBuilderScreen()),
    GoRoute(path: '/watchlist', builder: (context, state) => const WatchlistScreen()),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) => ProductDetailScreen(productId: state.pathParameters['id']!),
    ),
  ],
);

class ShopParvaApp extends ConsumerWidget {
  const ShopParvaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHighContrast = ref.watch(highContrastProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      theme: isHighContrast ? AppTheme.highContrastLightTheme : AppTheme.lightTheme,
      darkTheme: isHighContrast ? AppTheme.highContrastDarkTheme : AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
