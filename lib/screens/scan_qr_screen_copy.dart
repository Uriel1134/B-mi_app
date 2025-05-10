import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:image_picker/image_picker.dart';
import '../core/theme/app_colors.dart';

class ScanQrScreenCopy extends StatefulWidget {
  const ScanQrScreenCopy({Key? key}) : super(key: key);

  @override
  State<ScanQrScreenCopy> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreenCopy>
    with WidgetsBindingObserver {
  bool _isScanning = true;
  final MobileScannerController controller = MobileScannerController();
  String? scanResult;
  final ImagePicker _picker = ImagePicker();

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
    _showTransactionConfirmation();
  }

  Future<void> _pickQRImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _isScanning = false;
        controller.stop();
      });

      // En pratique, ici vous analyseriez l'image pour y détecter un QR code
      // Pour l'exemple, nous simulons juste la détection d'un code
      _showTransactionConfirmation();
    }
  }

  void _showTransactionConfirmation() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation de Transaction'),
        content: const Text(
            'Vous vous apprêtez à faire une transaction de 1000 kwètché.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isScanning = true;
                controller.start();
              });
            },
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: _showTransactionSuccess,
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Approuver'),
          ),
        ],
      ),
    );
  }

  void _showTransactionSuccess() {
    Navigator.pop(context); // Ferme le dialogue de confirmation

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Succès'),
        content: const Text('Transaction de Kwètché effectuée avec succès!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _navigateToNextScreen();
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    // Option: naviguer automatiquement après quelques secondes
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    // Remplacez 'NextScreen()' par la page vers laquelle vous souhaitez naviguer
    Navigator.pushReplacementNamed(context, '/offres');
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
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Stack(
        children: [
          // Scanner QR toujours visible
          MobileScanner(
            controller: controller,
            onDetect: _handleDetection,
          ),

          // Overlay avec instructions
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Placez le code QR du partenaire dans le cadre',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Bouton pour uploader une image
          Positioned(
            bottom: 40,
            right: 0,
            left: 0,
            child: Center(
              child: FloatingActionButton.extended(
                onPressed: _pickQRImage,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primaryColor,
                icon: const Icon(Icons.photo_library),
                label: const Text('Uploader une image QR'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
