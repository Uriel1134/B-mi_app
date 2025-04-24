import 'package:flutter/material.dart';
import '../config/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
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
                    onTap:
                        () => Navigator.pushNamed(context, AppRoutes.profile),
                    child: const CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                  ),

                  // Solde Kwetché
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Text(
                          '2500',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Kwetché',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.yellow,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Message de bienvenue
              RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(text: 'Bienvenue,\n'),
                    TextSpan(text: 'Koffi !'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Défi quotidien
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text(
                        'Défi quotidien',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Divider(color: Color(0xFFFF9800), thickness: 2),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Collecter 2000 déchet plastique',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Grille des actions avec images au lieu d'icônes
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    _buildActionCard(
                      context,
                      'COLLECTER\n& TRIER',
                      'assets/images/collecter.png', // Chemin vers l'image de collecte
                      Colors.blue,
                      () => Navigator.pushNamed(context, AppRoutes.collecte),
                    ),
                    _buildActionCard(
                      context,
                      'TROUVER UN\nDÉPOT',
                      'assets/images/depot.png', // Chemin vers l'image de dépôt
                      Colors.orange,
                      () => Navigator.pushNamed(context, AppRoutes.depots),
                    ),
                    _buildActionCard(
                      context,
                      'SCANNE QR',
                      'assets/images/qr_code.png', // Chemin vers l'image de QR code
                      Colors.cyan,
                      () => Navigator.pushNamed(context, AppRoutes.scanQR),
                    ),
                    _buildActionCard(
                      context,
                      'LES OFFRES',
                      'assets/images/offres.png', // Chemin vers l'image des offres
                      Colors.purple,
                      () => Navigator.pushNamed(context, AppRoutes.offres),
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

  // Méthode modifiée pour utiliser des images au lieu d'icônes
  Widget _buildActionCard(
    BuildContext context,
    String title,
    String imagePath,
    Color color,
    VoidCallback onPressed,
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
              height: 48,
              width: 48,
              // Si vous n'avez pas encore les images, utilisez ce placeholder
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  _getIconForMissingImage(title),
                  size: 40,
                  color: color,
                );
              },
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
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
