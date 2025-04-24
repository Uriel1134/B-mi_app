import 'package:flutter/material.dart';
import 'package:bemi_app/core/theme/app_colors.dart';
import 'package:bemi_app/offers/models/offer.dart';

class OfferDetailScreen extends StatelessWidget {
  final Offer offer;

  const OfferDetailScreen({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Détails de l\'offre',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${offer.description}\n\n${offer.detailedDescription}',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor.withOpacity(0.8),
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    offer.openingHours,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    offer.partnerName.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    offer.address,
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tél. : ${offer.phone}',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildShareButton(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSubscribeButton(),
    );
  }

  Widget _buildHeaderImage() {
    return Image.asset(
      offer.imagePath,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildShareButton() {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          // TODO: Implémenter le partage
        },
        icon: const Icon(Icons.share_outlined, color: AppColors.primaryColor),
        label: const Text(
          'Partager',
          style: TextStyle(color: AppColors.primaryColor, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildSubscribeButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Implémenter la souscription / utilisation de l'offre
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'SOUSCRIRE',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
} 