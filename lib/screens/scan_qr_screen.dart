import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../core/theme/app_colors.dart';
import 'photo_confirmation_screen.dart';
import 'package:image_picker/image_picker.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({Key? key}) : super(key: key);

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> with WidgetsBindingObserver {
  bool _isScanning = false;
  final MobileScannerController controller = MobileScannerController();
  String? scanResult;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!mounted) return;

    if (state == AppLifecycleState.resumed) {
      controller.start();
    } else if (state == AppLifecycleState.inactive) {
      controller.stop();
    }
  }

  void _handleDetection(BarcodeCapture capture) {
    if (!mounted || !_isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isEmpty) return;

    final String? code = barcodes.first.rawValue;
    if (code == null) return;

    setState(() {
      scanResult = code;
      _isScanning = false;
      controller.stop();
    });
    _handleScanResult(code);
  }

  void _handleScanResult(String code) {
    if (!mounted) return;
    
    // Vérifier si c'est la bonne poubelle (simulé)
    // En réalité, cette vérification serait faite avec le backend
    final bool isCorrectBin = code.contains("PET") || code.contains("plastique") || code.contains("plastic");
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          isCorrectBin ? 'Bravo !' : 'Attention !',
          style: TextStyle(
            color: isCorrectBin ? const Color(0xFF2F9359) : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isCorrectBin ? Icons.check_circle : Icons.error,
              color: isCorrectBin ? const Color(0xFF2F9359) : Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            Text(
              isCorrectBin 
                ? 'Vous avez scanné la bonne poubelle pour votre déchet plastique.'
                : 'Cette poubelle ne correspond pas à votre type de déchet (plastique).',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          if (!isCorrectBin)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  scanResult = null;
                  controller.start();
                  _isScanning = true;
                });
              },
              child: const Text('Scanner à nouveau'),
            ),
          if (isCorrectBin)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Naviguer vers la page de capture photo
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PhotoConfirmationScreen(points: 750),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2F9359),
              ),
              child: const Text('Continuer'),
            ),
        ],
      ),
    );
  }

  void _startScanning() {
    setState(() => _isScanning = true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FFF0),
      appBar: AppBar(
        title: const Text('Scanner QR'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (_isScanning) {
              setState(() => _isScanning = false);
            } else {
              Navigator.of(context).pop();
            }
          },
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: _isScanning
          ? _buildQRScanner()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildImageCard('assets/images/scan_poubelle.png'),
                      _buildImageCard('assets/images/scan_partenaire.png'),
                    ],
                  ),
                  const SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'Veuillez ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'scanner le code QR',
                            style: TextStyle(
                              color: Color(0xFFEA9538),
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: ' se trouvant sur la ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'poubelle correspondant à la catégorie de votre déchet',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: ' ou chez ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'un partenaire ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'en ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'cliquant',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: ' sur le ',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
                            text: 'bouton en dessous',
                            style: TextStyle(
                              color: Color(0xFF2F9359),
                              fontSize: 20,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
                              height: 1.20,
                            ),
                          ),
                          TextSpan(
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
                  ),
                  const Spacer(),
                  FloatingActionButton.large(
                    onPressed: _startScanning,
                    backgroundColor: AppColors.primaryColor,
                    child: const Icon(Icons.qr_code_scanner, size: 40, color: Colors.white),
                    shape: const CircleBorder(),
                  ),
                  const SizedBox(height: 70),
                ],
              ),
            ),
    );
  }

  Widget _buildQRScanner() {
    return Stack(
      children: [
        MobileScanner(
          controller: controller,
          onDetect: _handleDetection,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Placez le code QR dans le cadre',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          left: 0,
          child: Center(
            child: ElevatedButton.icon(
              onPressed: _pickImageFromGallery,
              icon: const Icon(Icons.photo_library),
              label: const Text('Uploader un QR code'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                elevation: 5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null && mounted) {
      // Simuler un scan réussi
      setState(() {
        _isScanning = false;
        controller.stop();
      });
      
      // Utiliser un QR code fictif pour le plastique
      _handleScanResult("PET-plastique-recyclable");
    }
  }

  Widget _buildImageCard(String imagePath) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          height: 120,
          width: MediaQuery.of(context).size.width * 0.35,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 120,
            width: MediaQuery.of(context).size.width * 0.35,
            color: Colors.grey[300],
            child: const Center(child: Text('Image ?')),
          ),
        ),
      ),
    );
  }
} 