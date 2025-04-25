import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'categorisation_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PhotoCaptureScreen extends StatefulWidget {
  const PhotoCaptureScreen({Key? key}) : super(key: key);

  @override
  State<PhotoCaptureScreen> createState() => _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends State<PhotoCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  dynamic _pickedFile;
  bool _isWeb = kIsWeb;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        setState(() {
          _pickedFile = photo;
        });
        // Naviguer vers l'écran de catégorisation avec l'image
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorisationScreen(pickedFile: _pickedFile),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Erreur lors de la prise de photo: $e');
      // Afficher un message d'erreur à l'utilisateur
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible de prendre une photo: $e')),
        );
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _pickedFile = image;
        });
        // Naviguer vers l'écran de catégorisation avec l'image
        if (context.mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategorisationScreen(pickedFile: _pickedFile),
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Erreur lors de la sélection d\'image: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Impossible de sélectionner une image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Espace pour le statut
          const SizedBox(height: 40),
          
          // Barre supérieure
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                const Text(
                  'AI',
                  style: TextStyle(
                    color: Colors.amber,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          
          // Zone principale pour l'aperçu de la caméra
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black87,
              child: const Center(
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white54,
                  size: 80,
                ),
              ),
            ),
          ),
          
          // Barre inférieure avec les contrôles de caméra
          Container(
            color: Colors.black,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Bouton gallerie
                IconButton(
                  icon: const Icon(
                    Icons.photo_library,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: _pickImageFromGallery,
                ),
                
                // Bouton de capture
                GestureDetector(
                  onTap: _takePhoto,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey, width: 3),
                    ),
                  ),
                ),
                
                // Bouton pour changer de caméra
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    // Logique pour basculer entre caméra avant/arrière
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 