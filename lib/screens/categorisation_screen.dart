import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:typed_data';
import 'dart:math' as math;
import 'depot_screen.dart';

class CategorisationScreen extends StatefulWidget {
  final dynamic pickedFile;
  
  const CategorisationScreen({Key? key, this.pickedFile}) : super(key: key);

  @override
  State<CategorisationScreen> createState() => _CategorisationScreenState();
}

class _CategorisationScreenState extends State<CategorisationScreen> with TickerProviderStateMixin {
  Uint8List? _webImage;
  bool _isLoading = true;
  bool _isConfirmed = false;
  bool _showRewardOverlay = true;
  
  // Animations pour l'overlay de récompense
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  
  late AnimationController _opacityController;
  late Animation<double> _opacityAnimation;
  
  // Animations pour les pièces de monnaie
  late List<AnimationController> _coinControllers = [];
  late List<Animation<double>> _coinAnimations = [];
  late List<Animation<Offset>> _coinPositions = [];
  
  final int _rewardAmount = 50; // Montant de la récompense

  @override
  void initState() {
    super.initState();
    _loadImage();
    _initializeAnimations();
  }
  
  void _initializeAnimations() {
    // Animation d'échelle
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.elasticOut,
      ),
    );
    
    // Animation de rotation
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(
        parent: _rotationController,
        curve: Curves.easeInOut,
      ),
    );
    
    // Animation d'opacité
    _opacityController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _opacityController,
        curve: Curves.easeIn,
      ),
    );
    
    // Animation des pièces
    final random = math.Random();
    for (int i = 0; i < 10; i++) {
      final controller = AnimationController(
        duration: Duration(milliseconds: 1200 + random.nextInt(800)),
        vsync: this,
      );
      
      final animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: controller,
          curve: Curves.easeOutQuad,
        ),
      );
      
      // Position de départ et position finale aléatoires pour chaque pièce
      final positionAnimation = Tween<Offset>(
        begin: Offset(0, 0),
        end: Offset(
          (random.nextDouble() * 2 - 1) * 1.5, 
          -1 - random.nextDouble(),
        ),
      ).animate(controller);
      
      _coinControllers.add(controller);
      _coinAnimations.add(animation);
      _coinPositions.add(positionAnimation);
    }
    
    // Démarrer les animations
    _scaleController.forward();
    _rotationController.repeat(reverse: true);
    _opacityController.forward();
    
    // Démarrer les animations de pièces avec un délai
    Future.delayed(const Duration(milliseconds: 300), () {
      for (var controller in _coinControllers) {
        controller.forward();
      }
    });
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
  
  void _closeRewardOverlay() {
    setState(() {
      _showRewardOverlay = false;
    });
  }
  
  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    _opacityController.dispose();
    
    for (var controller in _coinControllers) {
      controller.dispose();
    }
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Stack(
        children: [
          Padding(
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
          
          // Overlay de récompense
          if (_showRewardOverlay)
            AnimatedBuilder(
              animation: Listenable.merge([_scaleAnimation, _opacityAnimation, _rotationAnimation]),
              builder: (context, child) {
                return Positioned.fill(
                  child: GestureDetector(
                    onTap: _closeRewardOverlay,
                    child: Container(
                      color: Colors.black54,
                      child: Center(
                        child: Transform.rotate(
                          angle: _rotationAnimation.value,
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Opacity(
                              opacity: _opacityAnimation.value,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Félicitations !',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2F9359),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Stack(
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.amber.shade100,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.amber.withOpacity(0.3),
                                                blurRadius: 15,
                                                spreadRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                  'assets/images/Coins.png',
                                                  width: 80,
                                                  height: 80,
                                                ),
                                                // Pièces qui volent
                                                ...List.generate(10, (index) {
                                                  return AnimatedBuilder(
                                                    animation: _coinAnimations[index],
                                                    builder: (context, child) {
                                                      return Positioned(
                                                        left: 40 + _coinPositions[index].value.dx * 40,
                                                        top: 40 + _coinPositions[index].value.dy * 40,
                                                        child: Opacity(
                                                          opacity: 1.0 - _coinAnimations[index].value,
                                                          child: Transform.scale(
                                                            scale: (1.0 - _coinAnimations[index].value) * 0.5,
                                                            child: Image.asset(
                                                              'assets/images/Coins.png',
                                                              width: 30,
                                                              height: 30,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Si vous déposez ce tri de déchets, vous gagnerez ',
                                          ),
                                          TextSpan(
                                            text: '$_rewardAmount ',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2F9359),
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Kwètché',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.amber,
                                              fontSize: 18,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' !',
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    ElevatedButton(
                                      onPressed: _closeRewardOverlay,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF2F9359),
                                        foregroundColor: Colors.white,
                                        minimumSize: Size(200, 45),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25),
                                        ),
                                      ),
                                      child: Text(
                                        'Continuer',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
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