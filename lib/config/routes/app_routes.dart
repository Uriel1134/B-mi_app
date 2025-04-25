// lib/config/routes/app_routes.dart
import 'package:flutter/material.dart';
import '../../screens/home_screen.dart';
import '../../screens/collecte_screen.dart';
import '../../screens/photo_capture_screen.dart';
import '../../screens/categorisation_screen.dart';
import '../../screens/depot_screen.dart';
import '../../splash/screens/splash_screen.dart';
import '../../onboarding/screens/onboarding_screen.dart';
import '../../auth/screens/login_screen.dart';
import '../../auth/screens/register_screen.dart';

class AppRoutes {
  // Définition des noms de routes
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String collecte = '/collecte';
  static const String photoCapture = '/photo-capture';
  static const String categorisation = '/categorisation';
  static const String depots = '/depots';
  static const String scanQR = '/scan-qr';
  static const String offres = '/offres';
  static const String profile = '/profile';

  // Map de toutes les routes disponibles
  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    home: (context) => const HomeScreen(),
    collecte: (context) => const CollecteScreen(),
    photoCapture: (context) => const PhotoCaptureScreen(),
    categorisation: (context) => const CategorisationScreen(),
    // Ajoutez vos autres routes ici au fur et à mesure
    depots: (context) => const DepotScreen(),
    // scanQR: (context) => const ScanQRScreen(),
    // offres: (context) => const OffresScreen(),
    // profile: (context) => const ProfileScreen(),
  };

  // Méthode pour générer des routes dynamiques (si nécessaire)
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Récupérer les arguments passés à la route
    final args = settings.arguments;

    switch (settings.name) {
      // Exemple de route avec paramètres
      // case '/product-detail':
      //   return MaterialPageRoute(
      //     builder: (_) => ProductDetailScreen(productId: args as String),
      //   );
      default:
        // Route par défaut ou route inconnue
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route non trouvée')),
          ),
        );
    }
  }

  // Méthode pour gérer les routes inconnues
  static Route<dynamic> unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Page non trouvée')),
        body: const Center(child: Text('La page demandée n\'existe pas.')),
      ),
    );
  }
}
