import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/vector_header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          const VectorHeader(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                  // Titre
                  const Text(
                    'S\'inscrire',
                    style: TextStyle(
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Champs de saisie dans un Expanded avec SingleChildScrollView
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const CustomTextField(
                            label: 'Nom',
                            hintText: 'Entrer votre nom',
                          ),
                          const SizedBox(height: 16),
                          const CustomTextField(
                            label: 'Email',
                            hintText: 'Entrer votre email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 16),
                          const CustomTextField(
                            label: 'Ville',
                            hintText: 'Entrer votre ville',
                          ),
                          const SizedBox(height: 16),
                          const CustomTextField(
                            label: 'Mot de passe',
                            hintText: 'Entrer un mot de passe',
                            isPassword: true,
                          ),
                          const SizedBox(height: 16),
                          const CustomTextField(
                            label: 'Confirmer votre mot de passe',
                            hintText: 'Confirmer votre mot de passe',
                            isPassword: true,
                          ),
                          const SizedBox(height: 24),
                          // Bouton d'inscription
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implémenter l'inscription
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'S\'inscrire',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Lien vers la connexion
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Vous avez déjà un compte ? ',
                                style: TextStyle(
                                  color: AppColors.textColor.withOpacity(0.8),
                                  fontSize: 14,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, '/login');
                                },
                                child: const Text(
                                  'Se connecter',
                                  style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                        ],
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