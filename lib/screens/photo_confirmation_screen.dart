import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../core/theme/app_colors.dart';
import 'success_screen.dart';

class PhotoConfirmationScreen extends StatefulWidget {
  final int points;
  
  const PhotoConfirmationScreen({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  State<PhotoConfirmationScreen> createState() => _PhotoConfirmationScreenState();
}

class _PhotoConfirmationScreenState extends State<PhotoConfirmationScreen> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _takePicture() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
    }
  }

  Future<void> _submitPhoto() async {
    if (_imageFile == null) return;
    
    setState(() {
      _isLoading = true;
    });
    
    // Simuler un appel API
    await Future.delayed(const Duration(seconds: 2));
    
    if (!mounted) return;
    
    setState(() {
      _isLoading = false;
    });
    
    // Naviguer vers la page de succès
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SuccessScreen(points: widget.points),
      ),
    );
  }

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
          'Confirmer le dépôt',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Prenez une photo de votre déchet dans la poubelle',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: _imageFile == null
                  ? Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 80,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _imageFile!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _takePicture,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(_imageFile == null ? 'Prendre une photo' : 'Reprendre'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                if (_imageFile != null)
                  ElevatedButton.icon(
                    onPressed: _isLoading ? null : _submitPhoto,
                    icon: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Icon(Icons.check),
                    label: const Text('Confirmer'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEA9538),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
} 