import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../providers/user_provider.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

class SuccessScreen extends StatefulWidget {
  final int points;
  
  const SuccessScreen({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _pointsAdded = false;
  
  // Contrôleur pour l'animation de confettis
  late ConfettiController _confettiController;
  
  // Audio player pour le son de célébration
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );
    
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    
    // Initialiser le contrôleur de confettis
    _confettiController = ConfettiController(duration: const Duration(seconds: 5));
    
    _controller.forward();
    
    // Ajouter les points au solde après un court délai
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addPointsToBalance();
      
      // Démarrer l'animation de confettis
      _confettiController.play();
      
      // Jouer le son de célébration
      _playSound();
    });
  }
  
  // Méthode pour jouer le son
  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(AssetSource('audio/celebration.mp3'));
    } catch (e) {
      debugPrint('Erreur lors de la lecture du son: $e');
    }
  }

  void _addPointsToBalance() {
    if (!_pointsAdded) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.addPoints(widget.points);
      setState(() {
        _pointsAdded = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Récupérer le solde actuel
    final userProvider = Provider.of<UserProvider>(context);
    final currentBalance = userProvider.user.balance;
    
    return Scaffold(
      backgroundColor: const Color(0xFFECF5EC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Félicitations !',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Stack(
        children: [
          // Confetti Widget
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: 3.14 / 2, // vers le bas
              emissionFrequency: 0.05, // fréquence d'émission
              numberOfParticles: 20, // nombre de particules
              maxBlastForce: 10, // force max
              minBlastForce: 5, // force min
              gravity: 0.3, // gravité
              shouldLoop: false, // pas en boucle
              colors: const [
                Color(0xFFEA9538), // Orange Kwètché
                Color(0xFF2F9359), // Vert Bemi
                Colors.red,
                Colors.blue,
                Colors.yellow,
                Colors.purple,
              ],
            ),
          ),
          
          // Contenu principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Color(0xFF2F9359),
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Dépôt réussi !',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F9359),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Merci de contribuer à un environnement plus propre.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 40),
                  const Text(
                    'Vous avez gagné :',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Opacity(
                          opacity: _opacityAnimation.value,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEA9538).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: const Color(0xFFEA9538),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              '${widget.points} Kwètché',
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFEA9538),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nouveau solde : $currentBalance Kwètché',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F9359),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Retourner à l'écran d'accueil
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Retour à l\'accueil',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 