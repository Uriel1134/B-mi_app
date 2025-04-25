import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'depot_screen.dart';

class CategorisationScreen extends StatefulWidget {
  final dynamic pickedFile;
  
  const CategorisationScreen({Key? key, this.pickedFile}) : super(key: key);

  @override
  State<CategorisationScreen> createState() => _CategorisationScreenState();
}

class _CategorisationScreenState extends State<CategorisationScreen> {
  Uint8List? _webImage;
  bool _isLoading = true;
  bool _isConfirmed = false;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    if (widget.pickedFile != null) {
      try {
        // Suppression du code spécifique au web
        // Uniquement version mobile
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        debugPrint('Erreur lors du chargement de l\'image: $e');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xFFECF5EC),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête "Collecté"
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);  // Retour à l'écran précédent
                      },
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 12,
                            child: Icon(Icons.arrow_back, color: Colors.white, size: 16),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Collecté',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Image prise/sélectionnée
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: _buildImageWidget(),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Type de déchet identifié
                    Row(
                      children: [
                        const Text(
                          'Type de déchet identifié : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Plastique',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 12),
                    
                    // Quantité estimée
                    Row(
                      children: [
                        const Text(
                          'Quantité estimée : ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Petit',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Afficher le message et le bouton "Voir" si confirmé, sinon le bouton "Confirmer"
                    _isConfirmed 
                      ? Column(
                          children: [
                            const Text(
                              'Veuillez appuyer sur le bouton en dessous pour voir l\'itinéraire le plus proche',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  // Naviguer vers l'écran des dépôts
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DepotScreen(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.map, color: Colors.white),
                                label: const Text('Voir'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Changer l'état au lieu de naviguer
                              setState(() {
                                _isConfirmed = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              minimumSize: const Size(200, 40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Confirmer',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                  ],
                ),
        ),
      ),
    );
  }
  
  Widget _buildImageWidget() {
    if (widget.pickedFile == null) {
      return Container(
        width: double.infinity,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.image_not_supported, size: 50),
        ),
      );
    }
    
    // Suppression du code spécifique au web
    // Uniquement version mobile
    return Image.file(
      File(widget.pickedFile.path),
      fit: BoxFit.cover,
      width: double.infinity,
    );
  }
} 