import 'package:flutter/material.dart';

class CollecteScreen extends StatelessWidget {
  const CollecteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF5EC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Collecté',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image d'illustration
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/images/collecte_illustration.png',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // Fallback en cas d'image manquante
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: const Color(0xFFB3E5FC),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(Icons.image, size: 80, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // Texte explicatif
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                  children: [
                    const TextSpan(
                      text:
                          'Prêt à contribuer à un environnement propre ? Cliquer sur ',
                    ),
                    TextSpan(
                      text: 'le bouton en dessous',
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const TextSpan(text: ' pour prendre une photo de votre '),
                    const TextSpan(
                      text: 'EcoGeste',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Bouton pour prendre une photo
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {
                    // Fonction pour prendre une photo
                    _takePicture(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    'Prendre une photo',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour gérer la prise de photo
  void _takePicture(BuildContext context) {
    // Ici, vous pouvez implémenter la logique pour prendre une photo
    // Pour l'instant, affichons simplement une boîte de dialogue
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Fonctionnalité à venir'),
            content: const Text(
              'La fonctionnalité de prise de photo sera implémentée lorsque vous connecterez le frontend au backend.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );

    // Note: Pour implémenter réellement cette fonctionnalité, vous aurez besoin du package camera:
    // https://pub.dev/packages/camera
    // Ou image_picker: https://pub.dev/packages/image_picker
  }
}
