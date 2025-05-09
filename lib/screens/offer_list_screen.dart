import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import '../core/theme/app_colors.dart';
import '../models/offer.dart';
import '../widgets/offer_card.dart';
import '../providers/offer_provider.dart';
import 'offer_detail_screen.dart';

class OfferListScreen extends StatefulWidget {
  const OfferListScreen({Key? key}) : super(key: key);

  @override
  State<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends State<OfferListScreen> {
  bool _isLocationActive = false;
  bool _isRequestingLocation = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<OfferProvider>().loadOffers());
  }

  Future<void> _handleLocationPermission() async {
    if (!mounted) return;

    setState(() {
      _isRequestingLocation = true;
    });

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!mounted) return;
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Les services de localisation sont désactivés. Ouverture des paramètres...')),
        );
        await Geolocator.openLocationSettings();

        setState(() {
          _isRequestingLocation = false;
        });
        return;
      }

      permission = await Geolocator.checkPermission();
      if (!mounted) return;
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (!mounted) return;
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Permission de localisation refusée.')),
          );
          setState(() {
            _isRequestingLocation = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Permission de localisation refusée définitivement. Veuillez l\'activer dans les paramètres.')),
        );
        setState(() {
          _isRequestingLocation = false;
        });
        return;
      }

      setState(() {
        _isLocationActive = true;
        _isRequestingLocation = false;
      });
    } catch (e) {
      print("Erreur lors de la demande de localisation: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur de localisation: $e")),
        );
        setState(() {
          _isRequestingLocation = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Offre',
          style: TextStyle(
              color: AppColors.textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        child: Container(
          color: AppColors.backgroundColor,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSearchBar(),
              const SizedBox(height: 16),
              _buildCategorySelector(),
              const SizedBox(height: 16),
              _buildLocationBanner(),
              const SizedBox(height: 24),
              _buildOfferSectionTitle(),
              const SizedBox(height: 16),
              _buildOfferList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Rechercher',
          prefixIcon: Icon(Icons.search, color: AppColors.textColor),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Consumer<OfferProvider>(
      builder: (context, provider, child) {
        // Si les catégories ne sont pas encore chargées, affiche un placeholder
        if (provider.isLoading) {
          return const SizedBox(
            height: 50,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final categories = provider.availableCategories;
        final selectedCategory = provider.selectedCategory;

        return Container(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () {
                    provider.setSelectedCategory(category);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : AppColors.primaryColor.withOpacity(0.3),
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryColor.withOpacity(0.2),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : AppColors.textColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLocationBanner() {
    return Visibility(
      visible: !_isLocationActive,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.accentColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.accentColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.location_on_outlined,
                color: AppColors.primaryColor),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Activez votre localisation pour voir les offres autour de vous',
                style: TextStyle(color: AppColors.textColor),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed:
                  _isRequestingLocation ? null : _handleLocationPermission,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isRequestingLocation
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : const Text('Activer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferSectionTitle() {
    return Consumer<OfferProvider>(
      builder: (context, provider, child) {
        String selectedCategory = provider.selectedCategory;
        String categoryText = selectedCategory == 'Toutes'
            ? 'Voici une sélection d\'offres de partenaires Bèmi'
            : 'Offres ${selectedCategory.toLowerCase()} de nos partenaires Bèmi';

        return Text(
          categoryText,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        );
      },
    );
  }

  Widget _buildOfferList() {
    return Consumer<OfferProvider>(
      builder: (context, offerProvider, child) {
        if (offerProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (offerProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Une erreur est survenue',
                  style: TextStyle(color: AppColors.textColor),
                ),
                ElevatedButton(
                  onPressed: () => offerProvider.loadOffers(),
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        final allOffers = offerProvider.offers;
        final selectedCategory = offerProvider.selectedCategory;

        // Filtrer les offres selon la catégorie sélectionnée
        final filteredOffers = selectedCategory == 'Toutes'
            ? allOffers
            : allOffers
                .where((offer) => offer.category == selectedCategory)
                .toList();

        if (filteredOffers.isEmpty) {
          return Center(
            child: Text(
              selectedCategory == 'Toutes'
                  ? 'Aucune offre disponible pour le moment'
                  : 'Aucune offre ${selectedCategory.toLowerCase()} disponible pour le moment',
              style: const TextStyle(color: AppColors.textColor),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredOffers.length,
          itemBuilder: (context, index) {
            final offer = filteredOffers[index];
            return OfferCard(
              offer: offer,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OfferDetailScreen(offer: offer),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
