import 'package:flutter/material.dart';
import 'photo_capture_screen.dart';

class CollecteScreen extends StatelessWidget {
  const CollecteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupération des dimensions de l'écran
    final Size screenSize = MediaQuery.of(context).size;
    final bool isSmallScreen = screenSize.width < 600;
    
    return Scaffold(
      backgroundColor: const Color(0xFFECF5EC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.black,
            radius: 15,
            child: Icon(Icons.arrow_back, color: Colors.white, size: 18),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Collecté',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image d'illustration
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/collecte_illustration.png',
                height: screenSize.height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenSize.height * 0.3,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB3E5FC),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 60, color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ),

          // Texte explicatif
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(fontSize: isSmallScreen ? 14 : 16, color: Colors.black),
                children: [
                  const TextSpan(
                    text: 'Prêt à contribuer à un environnement propre ? Cliquer sur ',
                  ),
                  TextSpan(
                    text: 'le bouton en dessous',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                  const TextSpan(text: ' pour prendre une photo de votre '),
                  TextSpan(
                    text: 'EcoGeste',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Spacer pour pousser le bouton vers le bas
          const Spacer(),

          // Bouton pour prendre une photo
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: ElevatedButton(
              onPressed: () {
                // Naviguer vers l'écran de capture photo
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PhotoCaptureScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 24 : 32,
                  vertical: isSmallScreen ? 10 : 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Prendre une photo',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
