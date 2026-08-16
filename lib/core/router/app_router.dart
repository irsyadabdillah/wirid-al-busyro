import 'package:go_router/go_router.dart';
import 'package:wirid_al_busyro/features/splash/presentation/views/splash_screen.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/views/wirid_detail_screen.dart';
import 'package:wirid_al_busyro/features/wirid/presentation/views/wirid_list_screen.dart';

abstract final class AppRoutes {
  static const splash = '/splash';
  static const wiridList = '/';
  static String wiridDetail(String itemId) => '/wirid/$itemId';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.wiridList,
      builder: (context, state) => const WiridListScreen(),
    ),
    GoRoute(
      path: '/wirid/:id',
      // No page transition — next/prev between items should feel like
      // an instant swap, not a slide/fade navigation.
      pageBuilder: (context, state) => NoTransitionPage(
        child: WiridDetailScreen(itemId: state.pathParameters['id']!),
      ),
    ),
  ],
);
