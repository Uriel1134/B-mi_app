import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // Ajout pour le Timer
import '../config/routes/app_routes.dart';
import '../core/theme/app_colors.dart';
import '../services/auth_service.dart';
import '../providers/user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String userName = '';
  bool _showWelcomeBonus = true;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
    // Variables pour la progression du défi plastique
  double _progressPercentage = 0.0; // 0% par défaut
  int _plasticCollected = 0; // 0g par défaut
  final int _plasticTarget = 2000; // objectif en grammes
  late Timer _progressTimer; // Timer pour mettre à jour la progression
  @override
  void initState() {
    super.initState();
    _loadUserData();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );    _animationController.forward();
    
    // Initialiser le timer pour mettre à jour la progression si nécessaire
    _progressTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Cette méthode sera remplacée par une vérification réelle des déchets collectés
      // à partir des données de l'application
      updateProgressBasedOnCollectedPlastic();
    });
  }
  
  // Méthode pour mettre à jour la progression basée sur les déchets plastiques identifiés
  void updateProgressBasedOnCollectedPlastic({int? newPlasticWeight}) {
    // Si un nouveau poids est fourni (par exemple quand un déchet est identifié)
    if (newPlasticWeight != null) {
      setState(() {
        _plasticCollected += newPlasticWeight;
        if (_plasticCollected > _plasticTarget) {
          _plasticCollected = _plasticTarget;
        }
        // Calculer le nouveau pourcentage
        _progressPercentage = _plasticCollected / _plasticTarget;
      });
    }
      // Vous pouvez aussi ajouter ici une logique pour récupérer le poids total depuis une source de données
    // Par exemple: _plasticCollected = await _getCollectedPlasticFromDatabase();
  }
  
  @override
  void dispose() {
    _animationController.dispose();
    _progressTimer.cancel(); // Annuler le timer pour éviter les fuites de mémoire
    super.dispose();
  }
  
  // Cette méthode peut être appelée quand un déchet plastique est identifié par l'application
  void onPlasticWasteIdentified(int weightInGrams, String wasteType) {
    // Mettre à jour la barre de progression
    updateProgressBasedOnCollectedPlastic(newPlasticWeight: weightInGrams);
    
    // Afficher une notification ou un message à l'utilisateur
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$weightInGrams g de $wasteType ajoutés à votre défi!'),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    
    // Vous pourriez aussi mettre à jour les Kwètché ici
    // en fonction du poids ou du type de déchets
    int kwetcheEarned = (weightInGrams / 100).ceil(); // Par exemple, 1 Kwètché pour 100g
    if (kwetcheEarned > 0) {
      Provider.of<UserProvider>(context, listen: false).addPoints(kwetcheEarned);
    }
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await AuthService.getUserData();
      if (mounted) {
        setState(() {
          userName = userData['name'] ?? 'Utilisateur';
        });
      }
    } catch (e) {
      print('Erreur lors du chargement des données utilisateur: $e');
    }
  }

  void _closeWelcomeBonus() {
    setState(() {
      _showWelcomeBonus = false;
    });
    // Ajouter 100 points au solde de l'utilisateur
    Provider.of<UserProvider>(context, listen: false).addPoints(100);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    // Récupérer le solde depuis le provider
    final userProvider = Provider.of<UserProvider>(context);
    final kwetcheBalance = userProvider.user.balance;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section profil et monnaie
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar profil - Cliquable pour aller au profil
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
                        child: CircleAvatar(
                          radius: isSmallScreen ? 20 : 24,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, color: Colors.white, size: isSmallScreen ? 24 : 30),
                        ),
                      ),

                      // Solde Kwetché
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2F9359),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BD1B8),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '$kwetcheBalance',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Kwètché',
                              style: TextStyle(
                                color: AppColors.JauneColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Image.asset(
                              'assets/images/4.png',
                              width: 34,
                              height: 34,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 60),

                  // Message de bienvenue
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 31,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                      children: [
                        const TextSpan(text: 'Bienvenue,\n'),
                        TextSpan(text: '$userName !'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Défi quotidien
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Défi quotidien',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 1.20,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 3,
                        width: 60,
                        color: const Color(0xFFFFA726),
                      ),                      const SizedBox(height: 12),
                      const Text(
                        'Collecter 2000g de déchets plastiques',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                          height: 1.20,
                        ),
                      ),
                      const SizedBox(height: 10),                      // Barre de progression dynamique pour les déchets plastiques
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Progrès: ${_plasticCollected}g/${_plasticTarget}g',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '${(_progressPercentage * 100).toInt()}%',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Stack(
                            children: [
                              Container(
                                height: 12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                height: 12,
                                width: MediaQuery.of(context).size.width * _progressPercentage * 0.9, // Largeur dynamique basée sur le pourcentage
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [AppColors.primaryColor, Color(0xFFEA9538)],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),                    ],
                  ),
                  
                  // Garder seulement la barre de progression comme nouvelle fonctionnalité

                  SizedBox(height: isSmallScreen ? 24 : 32),

                  // Grille des actions
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: isSmallScreen ? 16 : 20,
                      crossAxisSpacing: isSmallScreen ? 16 : 20,
                      childAspectRatio: 1.0,                      children: [                        _buildActionCard(
                          context,
                          'COLLECTER\n& TRIER',
                          'assets/images/collecter.png',
                          const Color(0xFF3F51B5),
                          () => Navigator.pushNamed(context, AppRoutes.collecte),
                          isSmallScreen,
                        ),
                        _buildActionCard(
                          context,
                          'TROUVER UN\nDÉPOT',
                          'assets/images/depot.png',
                          const Color(0xFFEA9538),
                          () => Navigator.pushNamed(context, AppRoutes.depots),
                          isSmallScreen,
                        ),
                        _buildActionCard(
                          context,
                          'SCANNE QR',
                          'assets/images/qr_code.png',
                          const Color(0xFF00A9CC),
                          () => Navigator.pushNamed(context, AppRoutes.scanQR),
                          isSmallScreen,
                        ),
                        _buildActionCard(
                          context,
                          'LES OFFRES',
                          'assets/images/offres.png',
                          const Color(0xFF2F9359),
                          () => Navigator.pushNamed(context, AppRoutes.offres),
                          isSmallScreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showWelcomeBonus)
            AnimatedBuilder(
              animation: Listenable.merge([_scaleAnimation, _opacityAnimation]),
              builder: (context, child) {
                return Positioned.fill(
                  child: GestureDetector(
                    onTap: _closeWelcomeBonus,
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _opacityAnimation.value,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.85,
                              padding: const EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Bandeau supérieur
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF1B7B3E),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        topRight: Radius.circular(18),
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Bonus d\'inscription',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle, color: Colors.yellow, size: 20),
                                            SizedBox(width: 4),
                                            Text(
                                              'Terminé',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 18),
                                  const Text(
                                    'Waouh Inscription réussie',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Image.asset(
                                    'assets/images/4.png',
                                  ),
                                  const SizedBox(height: 18),
                                  const Text(
                                    'Vous avez reçu',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '100 Kwètché',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFFFC700), // Jaune vif
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: _closeWelcomeBonus,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF1B7B3E),
                                          padding: const EdgeInsets.symmetric(vertical: 14),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: const Text(
                                          'Continuer',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    String imagePath,
    Color color,
    VoidCallback onPressed,
    bool isSmallScreen,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color, width: 2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 90,
              width: 90,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  _getIconForMissingImage(title),
                  size: 40,
                  color: color,
                );
              },
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
  IconData _getIconForMissingImage(String title) {
    if (title.contains('COLLECTER')) return Icons.delete;
    if (title.contains('DÉPOT')) return Icons.location_on;
    if (title.contains('QR')) return Icons.qr_code;
    if (title.contains('OFFRES')) return Icons.card_giftcard;
    return Icons.circle;
  }
}

