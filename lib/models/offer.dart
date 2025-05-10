class Offer {
  final String id;
  final String title;
  final String partnerName;
  final String description;
  final String detailedDescription;
  final String address;
  final String phone;
  final String openingHours;
  final String imagePath;
  final int kwetcheValue;
  final String category; // Nouvelle propriété pour la catégorie

  Offer({
    required this.id,
    required this.title,
    required this.partnerName,
    required this.description,
    required this.detailedDescription,
    required this.address,
    required this.phone,
    required this.openingHours,
    required this.imagePath,
    required this.kwetcheValue,
    required this.category,
  });

  // Conversion depuis JSON
  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'] as String,
      title: json['title'] as String,
      partnerName: json['partnerName'] as String,
      description: json['description'] as String,
      detailedDescription: json['detailedDescription'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      openingHours: json['openingHours'] as String,
      imagePath: json['imagePath'] as String,
      kwetcheValue: json['kwetcheValue'] as int,
      category: json['category'] as String,
    );
  }

  // Conversion vers JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'partnerName': partnerName,
      'description': description,
      'detailedDescription': detailedDescription,
      'address': address,
      'phone': phone,
      'openingHours': openingHours,
      'imagePath': imagePath,
      'kwetcheValue': kwetcheValue,
      'category': category,
    };
  }
}

// Données mises à jour pour chaque catégorie
final List<Offer> dummyOffers = [
  // CATÉGORIE: RESTAURANT
  Offer(
    id: '1',
    title: 'Menu Acthèké chez Lys',
    partnerName: 'Chez Lys',
    description: 'Savourez un délicieux Acthèké dans un cadre convivial.',
    detailedDescription:
        'Venez déguster le meilleur Acthèké de la ville dans un cadre convivial. Parfait pour vos déjeuners et dîners.\n\nIngrédients frais et recette traditionnelle.',
    address: '123 Rue de la Saveur\nCotonou, Bénin',
    phone: '229 9876 5432',
    openingHours: 'Ouvert tous les jours : 11:00 - 22:00',
    imagePath: 'assets/images/food_offer.png',
    kwetcheValue: 50,
    category: 'Restaurant',
  ),
  Offer(
    id: '2',
    title: 'Menu déjeuner complet à La Terrasse',
    partnerName: 'La Terrasse',
    description: 'Profitez d\'un menu déjeuner complet en semaine.',
    detailedDescription:
        'La Terrasse vous propose ses menus déjeuner avec entrée, plat, dessert et boisson. Cuisine locale et internationale dans un cadre agréable avec vue panoramique.\n\nOffre valable du lundi au vendredi midi uniquement.',
    address: '45 Boulevard du Port\nCotonou, Bénin',
    phone: '229 2130 4567',
    openingHours: 'Lundi au Samedi : 11:30 - 23:00\nDimanche : 12:00 - 22:00',
    imagePath: 'assets/images/restaurant_offer.png',
    kwetcheValue: 75,
    category: 'Restaurant',
  ),

  // CATÉGORIE: VÊTEMENTS
  Offer(
    id: '3',
    title: 'Article de la nouvelle collection Fashion Store',
    partnerName: 'Fashion Store',
    description: 'Obtenez un article de la nouvelle collection automne/hiver.',
    detailedDescription:
        'Fashion Store vous accueille pour découvrir sa nouvelle collection automne/hiver. Échangez vos Kwètché contre un article tendance de notre sélection.\n\nOffre valable sur une sélection d\'articles signalés en magasin.',
    address: '78 Avenue de la Mode\nCotonou, Bénin',
    phone: '229 2145 9876',
    openingHours: 'Lundi au Samedi : 09:00 - 19:00',
    imagePath: 'assets/images/clothing_offer.png',
    kwetcheValue: 100,
    category: 'Vêtements',
  ),
  Offer(
    id: '4',
    title: 'Accessoire de mode African Style',
    partnerName: 'African Style',
    description: 'Obtenez un accessoire de mode traditionnel africain.',
    detailedDescription:
        'African Style célèbre la mode africaine contemporaine. Échangez vos Kwètché contre un accessoire de mode traditionnel parmi notre sélection (bijoux, foulards, sacs).\n\nOffre valable sur une sélection d\'articles signalés en magasin.',
    address: '12 Rue des Artisans\nCotonou, Bénin',
    phone: '229 9712 3456',
    openingHours: 'Tous les jours : 10:00 - 20:00',
    imagePath: 'assets/images/fashion_offer.png',
    kwetcheValue: 80,
    category: 'Vêtements',
  ),

  // CATÉGORIE: CHAUSSURES
  Offer(
    id: '5',
    title: 'Paire de chaussures casual Shoe Paradise',
    partnerName: 'Shoe Paradise',
    description:
        'Obtenez une paire de chaussures casual parmi notre sélection.',
    detailedDescription:
        'Shoe Paradise vous propose une large gamme de chaussures pour hommes, femmes et enfants. Échangez vos Kwètché contre une paire de chaussures casual parmi notre sélection dédiée.\n\nOffre valable sur présentation de votre carte Bèmi.',
    address: '34 Rue du Commerce\nCotonou, Bénin',
    phone: '229 2165 7890',
    openingHours: 'Lundi au Samedi : 09:30 - 19:30',
    imagePath: 'assets/images/shoes_offer.png',
    kwetcheValue: 60,
    category: 'Chaussures',
  ),
  Offer(
    id: '6',
    title: 'Paire de baskets Sport Foot',
    partnerName: 'Sport Foot',
    description: 'Obtenez une paire de baskets tendance parmi notre sélection.',
    detailedDescription:
        'Sport Foot, spécialiste des chaussures de sport et des sneakers. Retrouvez les plus grandes marques et les derniers modèles à la mode. Échangez vos Kwètché contre une paire de baskets parmi notre sélection.\n\nOffre valable sur une sélection de modèles signalés en magasin.',
    address: '56 Boulevard des Sports\nCotonou, Bénin',
    phone: '229 9634 5678',
    openingHours: 'Tous les jours : 10:00 - 20:00',
    imagePath: 'assets/images/sportshoes_offer.png',
    kwetcheValue: 120,
    category: 'Chaussures',
  ),

  // CATÉGORIE: VOYAGE
  Offer(
    id: '7',
    title: 'Circuit découverte d\'une journée au Bénin',
    partnerName: 'Bénin Travel',
    description: 'Circuit touristique d\'une journée dans une région du Bénin.',
    detailedDescription:
        'Bénin Travel vous fait découvrir les merveilles du Bénin. Échangez vos Kwètché contre un circuit touristique d\'une journée incluant transport, guide et déjeuner. Plusieurs destinations au choix.\n\nRéservation minimum 15 jours à l\'avance.',
    address: '67 Avenue du Tourisme\nCotonou, Bénin',
    phone: '229 2198 7654',
    openingHours: 'Lundi au Vendredi : 09:00 - 18:00\nSamedi : 09:00 - 13:00',
    imagePath: 'assets/images/travel_offer.png',
    kwetcheValue: 200,
    category: 'Voyage',
  ),
  Offer(
    id: '8',
    title: 'Transfert aéroport premium AirBénin',
    partnerName: 'AirBénin',
    description:
        'Service de transfert premium entre l\'aéroport et votre hôtel.',
    detailedDescription:
        'AirBénin vous propose un service de transfert premium entre l\'aéroport international de Cotonou et votre hôtel. Véhicule confortable, chauffeur professionnel et prise en charge de vos bagages.\n\nOffre valable pour toute réservation effectuée au moins 48h à l\'avance.',
    address: '23 Boulevard de l\'Aéroport\nCotonou, Bénin',
    phone: '229 2134 9876',
    openingHours: 'Lundi au Vendredi : 08:30 - 17:30\nSamedi : 09:00 - 12:00',
    imagePath: 'assets/images/flight_offer.png',
    kwetcheValue: 150,
    category: 'Voyage',
  ),

  // CATÉGORIE: MAISON
  Offer(
    id: '9',
    title: 'Boîte à outils complète Les Briconautes',
    partnerName: 'Les Briconautes',
    description: 'Obtenez une boîte à outils complète pour vos travaux.',
    detailedDescription:
        'Les Briconautes avec 13 000 M² de produits pour réaliser tous vos projets déco, brico et jardin !\n\nÉchangez vos Kwètché contre une boîte à outils complète comprenant les essentiels pour vos travaux domestiques.',
    address: '99 Route de la Marigarde\nCotonou, Bénin',
    phone: '229 2197 4244',
    openingHours: 'Ouvert du Lundi au Samedi : 7:30 - 19:30',
    imagePath: 'assets/images/brico_offer.png',
    kwetcheValue: 100,
    category: 'Maison',
  ),
  Offer(
    id: '10',
    title: 'Ensemble décoratif Déco Plus',
    partnerName: 'Déco Plus',
    description: 'Obtenez un ensemble décoratif pour embellir votre intérieur.',
    detailedDescription:
        'Déco Plus, votre spécialiste en ameublement et décoration d\'intérieur. Échangez vos Kwètché contre un ensemble décoratif comprenant coussin, cadre et accessoire assorti pour embellir votre intérieur.\n\nOffre valable sur une sélection d\'articles signalés en magasin.',
    address: '45 Rue de l\'Artisanat\nCotonou, Bénin',
    phone: '229 9745 6123',
    openingHours: 'Mardi au Samedi : 09:00 - 19:00\nDimanche : 10:00 - 13:00',
    imagePath: 'assets/images/furniture_offer.png',
    kwetcheValue: 150,
    category: 'Maison',
  ),

  // CATÉGORIE: BEAUTÉ
  Offer(
    id: '11',
    title: 'Séance de massage relaxant Beauty Spa',
    partnerName: 'Beauty Spa',
    description: 'Profitez d\'une séance de massage relaxant d\'une heure.',
    detailedDescription:
        'Beauty Spa vous invite à un moment de détente et de bien-être. Échangez vos Kwètché contre une séance de massage relaxant d\'une heure réalisée par nos professionnels qualifiés.\n\nRéservation recommandée, mentionnez votre statut membre Bèmi.',
    address: '78 Rue du Bien-être\nCotonou, Bénin',
    phone: '229 2156 7890',
    openingHours: 'Mardi au Samedi : 10:00 - 20:00\nDimanche : 10:00 - 15:00',
    imagePath: 'assets/images/spa_offer.png',
    kwetcheValue: 80,
    category: 'Beauté',
  ),
  Offer(
    id: '12',
    title: 'Coupe et brushing Coiffure Élégance',
    partnerName: 'Coiffure Élégance',
    description:
        'Bénéficiez d\'une coupe et d\'un brushing réalisés par nos experts.',
    detailedDescription:
        'Coiffure Élégance, votre salon de coiffure mixte au cœur de Cotonou. Échangez vos Kwètché contre une coupe et un brushing réalisés par notre équipe de professionnels.\n\nOffre valable du mardi au jeudi, sur rendez-vous.',
    address: '12 Avenue de la Beauté\nCotonou, Bénin',
    phone: '229 9789 0123',
    openingHours: 'Mardi au Samedi : 09:00 - 19:00',
    imagePath: 'assets/images/hair_offer.png',
    kwetcheValue: 60,
    category: 'Beauté',
  ),

  // CATÉGORIE: LOISIRS
  Offer(
    id: '13',
    title: 'Place de cinéma Ciné Palace',
    partnerName: 'Ciné Palace',
    description: 'Obtenez une place de cinéma pour le film de votre choix.',
    detailedDescription:
        'Ciné Palace vous accueille dans ses salles climatisées équipées des dernières technologies audio et vidéo. Échangez vos Kwètché contre une place de cinéma valable pour le film de votre choix.\n\nOffre valable tous les jours, hors avant-premières et événements spéciaux.',
    address: '56 Boulevard du Cinéma\nCotonou, Bénin',
    phone: '229 2187 6543',
    openingHours: 'Tous les jours : 10:00 - 23:00',
    imagePath: 'assets/images/cinema_offer.png',
    kwetcheValue: 40,
    category: 'Loisirs',
  ),
  Offer(
    id: '14',
    title: 'Journée au Beach Club avec cocktail',
    partnerName: 'Beach Club',
    description:
        'Profitez d\'une journée à la plage privée avec cocktail inclus.',
    detailedDescription:
        'Beach Club, votre oasis de détente au bord de l\'océan. Échangez vos Kwètché contre une journée à notre plage aménagée avec transat et un cocktail au choix.\n\nOffre valable une fois par mois, sur présentation de votre carte Bèmi.',
    address: '10 Route de la Plage\nCotonou, Bénin',
    phone: '229 9723 4567',
    openingHours: 'Tous les jours : 09:00 - 23:00',
    imagePath: 'assets/images/beach_offer.png',
    kwetcheValue: 70,
    category: 'Loisirs',
  ),
  Offer(
    id: '15',
    title: 'Ticket pour le festival "We Love Eya"',
    partnerName: 'Eya Festival',
    description:
        'Accédez au festival culturel "We Love Eya" pendant une journée.',
    detailedDescription:
        'Le festival "We Love Eya" célèbre la culture béninoise à travers musique, danse, gastronomie et art. Échangez vos Kwètché contre un ticket d\'entrée pour une journée complète de festivités.\n\nValable pour l\'édition en cours du festival, programmé du 15 au 20 juin.',
    address: 'Esplanade des Festivals\nCotonou, Bénin',
    phone: '229 9745 2365',
    openingHours: 'Pendant le festival : 10:00 - 00:00',
    imagePath: 'assets/images/festival_offer.png',
    kwetcheValue: 90,
    category: 'Loisirs',
  ),
  Offer(
    id: '16',
    title: 'Place pour le concert "Voix d\'Afrique"',
    partnerName: 'Bénin Concert Hall',
    description:
        'Assistez au concert "Voix d\'Afrique" avec les meilleurs artistes du pays.',
    detailedDescription:
        'Le concert "Voix d\'Afrique" réunit sur scène les plus grands talents musicaux du Bénin et d\'Afrique de l\'Ouest. Échangez vos Kwètché contre une place en catégorie standard.\n\nConcert prévu le 25 mai à 20h00, ouverture des portes à 19h00.',
    address: 'Stade de l\'Amitié\nCotonou, Bénin',
    phone: '229 2165 8734',
    openingHours: 'Billetterie ouverte tous les jours : 10:00 - 18:00',
    imagePath: 'assets/images/concert_offer.png',
    kwetcheValue: 120,
    category: 'Loisirs',
  ),
  Offer(
    id: '17',
    title: 'Entrée au Parc d\'attractions Bénin Magic',
    partnerName: 'Bénin Magic',
    description: 'Journée complète d\'accès à toutes les attractions du parc.',
    detailedDescription:
        'Bénin Magic est le plus grand parc d\'attractions du pays. Échangez vos Kwètché contre un ticket d\'entrée donnant accès à toutes les attractions pendant une journée complète.\n\nIdéal pour une sortie en famille ou entre amis.',
    address: '78 Route des Loisirs\nCotonou, Bénin',
    phone: '229 9712 8456',
    openingHours: 'Mercredi au Dimanche : 10:00 - 22:00',
    imagePath: 'assets/images/park_offer.png',
    kwetcheValue: 100,
    category: 'Loisirs',
  ),

  // CATÉGORIE: ÉLECTRONIQUE
  Offer(
    id: '18',
    title: 'Écouteurs sans fil Tech Shop',
    partnerName: 'Tech Shop',
    description: 'Obtenez des écouteurs sans fil de qualité.',
    detailedDescription:
        'Tech Shop, votre spécialiste high-tech, vous propose d\'échanger vos Kwètché contre une paire d\'écouteurs sans fil de qualité. Profitez d\'un son immersif pour vos déplacements quotidiens.\n\nGarantie 1 an incluse.',
    address: '67 Rue de la Technologie\nCotonou, Bénin',
    phone: '229 2167 8901',
    openingHours: 'Lundi au Samedi : 09:00 - 19:30',
    imagePath: 'assets/images/smartphone_offer.png',
    kwetcheValue: 200,
    category: 'Électronique',
  ),
  Offer(
    id: '19',
    title: 'Enceinte Bluetooth portable Audio Plus',
    partnerName: 'Audio Plus',
    description: 'Obtenez une enceinte Bluetooth portable et résistante.',
    detailedDescription:
        'Audio Plus vous propose d\'échanger vos Kwètché contre une enceinte Bluetooth portable, résistante aux éclaboussures et offrant jusqu\'à 12 heures d\'autonomie.\n\nParfaite pour vos sorties en plein air ou vos soirées entre amis.',
    address: '23 Avenue du Son\nCotonou, Bénin',
    phone: '229 9765 4321',
    openingHours: 'Mardi au Dimanche : 10:00 - 20:00',
    imagePath: 'assets/images/audio_offer.png',
    kwetcheValue: 90,
    category: 'Électronique',
  ),

  // NOUVELLE CATÉGORIE: PRODUITS RECYCLÉS
  Offer(
    id: '20',
    title: 'Sac à main en bâches recyclées',
    partnerName: 'ÉcoStyle',
    description:
        'Obtenez un sac à main artisanal fabriqué à partir de bâches publicitaires recyclées.',
    detailedDescription:
        'ÉcoStyle transforme les bâches publicitaires usagées en accessoires de mode uniques et durables. Échangez vos Kwètché contre un sac à main original, imperméable et robuste.\n\nChaque pièce est unique et fabriquée à la main par des artisans locaux.',
    address: '45 Rue de l\'Environnement\nCotonou, Bénin',
    phone: '229 9732 5614',
    openingHours: 'Lundi au Vendredi : 09:00 - 18:00\nSamedi : 10:00 - 16:00',
    imagePath: 'assets/images/recycled_bag.png',
    kwetcheValue: 85,
    category: 'Produits Recyclés',
  ),
  Offer(
    id: '21',
    title: 'Lampe décorative en bouteilles recyclées',
    partnerName: 'LumièreDurable',
    description:
        'Obtenez une lampe artisanale fabriquée à partir de bouteilles en verre recyclées.',
    detailedDescription:
        'LumièreDurable transforme les bouteilles en verre destinées à la poubelle en magnifiques lampes décoratives. Échangez vos Kwètché contre une pièce unique qui allie esthétique et développement durable.\n\nChaque lampe est fabriquée à la main par des artisans locaux.',
    address: '17 Avenue de l\'Artisanat Vert\nCotonou, Bénin',
    phone: '229 2143 9875',
    openingHours: 'Mardi au Samedi : 10:00 - 19:00',
    imagePath: 'assets/images/recycled_lamp.png',
    kwetcheValue: 120,
    category: 'Produits Recyclés',
  ),
  Offer(
    id: '22',
    title: 'Cahier à couverture en pneus recyclés',
    partnerName: 'PapierVert',
    description:
        'Obtenez un cahier écologique avec couverture en caoutchouc recyclé.',
    detailedDescription:
        'PapierVert donne une seconde vie aux pneus usagés en les transformant en couvertures de cahiers robustes et imperméables. Échangez vos Kwètché contre un cahier écologique avec papier recyclé.\n\nUn accessoire utile, durable et respectueux de l\'environnement.',
    address: '34 Rue du Développement Durable\nCotonou, Bénin',
    phone: '229 9754 3210',
    openingHours: 'Lundi au Vendredi : 08:30 - 17:30',
    imagePath: 'assets/images/recycled_notebook.png',
    kwetcheValue: 60,
    category: 'Produits Recyclés',
  ),
  Offer(
    id: '23',
    title: 'Mobilier en palettes recyclées',
    partnerName: 'ÉcoBois',
    description:
        'Obtenez une petite table ou étagère fabriquée à partir de palettes recyclées.',
    detailedDescription:
        'ÉcoBois transforme les palettes de transport en fin de vie en mobilier contemporain et fonctionnel. Échangez vos Kwètché contre une petite table ou une étagère murale en bois recyclé.\n\nMobilier traité et poncé pour un résultat élégant et durable.',
    address: '89 Boulevard de l\'Économie Circulaire\nCotonou, Bénin',
    phone: '229 2198 7612',
    openingHours: 'Mardi au Samedi : 09:00 - 18:00',
    imagePath: 'assets/images/recycled_furniture.png',
    kwetcheValue: 180,
    category: 'Produits Recyclés',
  ),
];
