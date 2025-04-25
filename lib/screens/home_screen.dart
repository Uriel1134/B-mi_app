import 'package:flutter/material.dart';
import '../config/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFECF5EC),
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 12 : 16,
                      vertical: isSmallScreen ? 6 : 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '2500',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 6 : 8),
                        Text(
                          'Kwetché',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: isSmallScreen ? 14 : 16,
                          ),
                        ),
                        SizedBox(width: isSmallScreen ? 3 : 4),
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.monetization_on,
                            color: Colors.amber,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: isSmallScreen ? 16 : 24),

              // Message de bienvenue
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: isSmallScreen ? 20 : 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: const [
                    TextSpan(text: 'Bienvenue,\n'),
                    TextSpan(text: 'Koffi !'),
                  ],
                ),
              ),

              SizedBox(height: isSmallScreen ? 16 : 24),

              // Défi quotidien
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Défi quotidien',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 6 : 8),
                  Text(
                    'Collecter 2000 déchet plastique',
                    style: TextStyle(fontSize: isSmallScreen ? 14 : 16),
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
                      'assets/images/collecter.png',
                      Colors.blue,
                      () => Navigator.pushNamed(context, AppRoutes.collecte),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'TROUVER UN\nDÉPOT',
                      'assets/images/depot.png',
                      Colors.orange,
                      () => Navigator.pushNamed(context, AppRoutes.depots),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'SCANNE QR',
                      'assets/images/qr_code.png',
                      Colors.cyan,
                      () => Navigator.pushNamed(context, AppRoutes.scanQR),
                      isSmallScreen,
                    ),
                    _buildActionCard(
                      context,
                      'LES OFFRES',
                      'assets/images/offres.png',
                      Colors.purple,
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
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 8 : 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image plus grande
              Image.asset(
                imagePath,
                height: isSmallScreen ? 60 : 70,
                width: isSmallScreen ? 60 : 70,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    _getIconForMissingImage(title),
                    size: isSmallScreen ? 40 : 50,
                    color: color,
                  );
                },
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
