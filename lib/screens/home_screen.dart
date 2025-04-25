import 'package:flutter/material.dart';
import '../config/routes/app_routes.dart';
import '../core/theme/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
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
                            '2500',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Kwètché',
                          style: TextStyle(
                            color: AppColors.JauneColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 3),
                        Image.asset(
                          'assets/images/Coins.png',
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
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 31,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                    height: 1.20,
                  ),
                  children: const [
                    TextSpan(text: 'Bienvenue,\n'),
                    TextSpan(text: 'Koffi !'),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Défi quotidien
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Texte "Défi quotidien"
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
                  // Ajouter un espace et la ligne en dessous
                  const SizedBox(height: 4), // Ajuster la hauteur si besoin
                  Container(
                    height: 3, 
                    width: 60, // Ajuster la largeur si besoin
                    color: const Color(0xFFFFA726), // Orange
                  ),
                  const SizedBox(height: 12), // Espace avant le texte du défi
                  const Text(
                    'Collecter 2000 déchet plastique',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.20,
                    ),
                  ),
                ],
              ),

              SizedBox(height: isSmallScreen ? 24 : 32),

              // Grille des actions avec images au lieu d'icônes
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: isSmallScreen ? 16 : 20,
                  crossAxisSpacing: isSmallScreen ? 16 : 20,
                  childAspectRatio: 1.0,
                  children: [
                    _buildActionCard(
                      context,
                      'COLLECTER\n& TRIER',
                      'assets/images/collecter.png', // Chemin vers l'image de collecte
                      const Color(0xFF3F51B5),
                      () => Navigator.pushNamed(context, AppRoutes.collecte),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'TROUVER UN\nDÉPOT',
                      'assets/images/depot.png', // Chemin vers l'image de dépôt
                      const Color(0xFFEA9538),
                      () => Navigator.pushNamed(context, AppRoutes.depots),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'SCANNE QR',
                      'assets/images/qr_code.png', // Chemin vers l'image de QR code
                      const Color(0xFF00A9CC),
                      () => Navigator.pushNamed(context, AppRoutes.scanQR),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'LES OFFRES',
                      'assets/images/offres.png', // Chemin vers l'image des offres
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
    );
  }

  // Méthode modifiée pour utiliser des images plus grandes
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
            // Image au lieu d'icône
            Image.asset(
              imagePath,
              height: 90,
              width: 90,
              // Si vous n'avez pas encore les images, utilisez ce placeholder
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
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              SizedBox(height: isSmallScreen ? 8 : 12),
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
      ),
    );
  }

  // Méthode auxiliaire pour fournir des icônes de secours si les images ne sont pas trouvées
  IconData _getIconForMissingImage(String title) {
    if (title.contains('COLLECTER')) return Icons.delete;
    if (title.contains('DÉPOT')) return Icons.location_on;
    if (title.contains('QR')) return Icons.qr_code;
    if (title.contains('OFFRES')) return Icons.card_giftcard;
    return Icons.circle;
  }
}
