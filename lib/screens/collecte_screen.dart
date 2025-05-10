import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'categorisation_screen.dart';
import '../core/theme/app_colors.dart';

class CollecteScreen extends StatelessWidget {
  const CollecteScreen({Key? key}) : super(key: key);  @override
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
          'Collecte',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: _buildImageCard('assets/images/collecte_illustration.png'),
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Pour participer, ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: 'prends une photo',
                      style: TextStyle(
                        color: Color(0xFFEA9538),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: ' de ton geste écolo (collecte ou tri) ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: 'en cliquant',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: ' sur le ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: 'bouton en dessous',
                      style: TextStyle(
                        color: Color(0xFF2F9359),
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w700,
                        height: 1.20,
                      ),
                    ),
                    const TextSpan(
                      text: '.',
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
              ),
            ),            const Spacer(),
            FloatingActionButton.large(
              onPressed: () async {
                // Utiliser ImagePicker directement, sans passer par PhotoCaptureScreen
                final ImagePicker picker = ImagePicker();
                final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                
                if (photo != null && context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategorisationScreen(pickedFile: photo),
                    ),
                  );
                }
              },
              backgroundColor: AppColors.primaryColor,
              child: const Icon(Icons.camera_alt, size: 40, color: Colors.white),
              shape: const CircleBorder(),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          imagePath,
          width: 220,
          height: 220,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 220,
              height: 220,
              color: Colors.grey[200],
              child: const Icon(Icons.image, size: 40, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
