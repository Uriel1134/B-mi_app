import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../config/routes/app_routes.dart';
import '../../services/token_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Démarrer l'animation
    _controller.forward();

    // Rediriger après l'animation selon le token
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final isLoggedIn = await TokenService.hasToken();
    if (!mounted) return;
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
                
                // Slogan
                const Text(
                  'Gagne avec tes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'gestes écolos !',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
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