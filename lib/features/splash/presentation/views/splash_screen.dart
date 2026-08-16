import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:wirid_al_busyro/core/constants/app_colors.dart';
import 'package:wirid_al_busyro/core/router/app_router.dart';

/// Animated splash — no Lottie asset exists for a custom "Al-Busyro"
/// wordmark (nothing pre-made could), so this is a staggered
/// fade/scale reveal built on Flutter's own animation framework:
/// Arabic wordmark first, Latin brand name a beat behind it. Swap in
/// a real Lottie file later by replacing the AnimatedBuilder's child
/// with a Lottie widget in the same center slot.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _wordmarkFade;
  late final Animation<double> _wordmarkScale;
  late final Animation<double> _brandFade;
  late final Animation<Offset> _brandSlide;

  Timer? _navigateTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _wordmarkFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.65, curve: Curves.easeOut),
    );
    _wordmarkScale = Tween<double>(begin: 0.82, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.65, curve: Curves.easeOutBack),
      ),
    );
    _brandFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.45, 1, curve: Curves.easeOut),
    );
    _brandSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1, curve: Curves.easeOutCubic),
      ),
    );

    _controller.forward();
    _navigateTimer = Timer(const Duration(milliseconds: 2200), () {
      if (mounted) context.go(AppRoutes.wiridList);
    });
  }

  @override
  void dispose() {
    _navigateTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.greenDark, AppColors.green],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _wordmarkFade,
                  child: ScaleTransition(
                    scale: _wordmarkScale,
                    child: const Text(
                      'البُشْرَى',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Amiri',
                        fontSize: 56,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeTransition(
                  opacity: _brandFade,
                  child: SlideTransition(
                    position: _brandSlide,
                    child: Text(
                      'AL-BUSYRO',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 6,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
