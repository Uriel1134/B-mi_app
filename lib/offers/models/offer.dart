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
    };
  }
}

// Dummy data for testing
final List<Offer> dummyOffers = [
  Offer(
    id: '1',
    title: 'Les Briconautes : 10% en bon d\'achats',
    partnerName: 'Les Briconautes',
    description: 'Bénéficiez d\'un bon d\'achat de 10% dès 100 Kwètché.',
    detailedDescription: 'Les Briconautes de France avec 13 000 M² de produits pour réaliser tous vos projets déco, brico et jardin !\n\nRetrouvez une large gamme de produits pour réaliser tous vos travaux !',
    address: '99 Route de la Marigarde\n06130 GRASSE',
    phone: '229 0197 42 44 44',
    openingHours: 'Ouvert du Lundi au Samedi : 7:30 - 19:30',
    imagePath: 'assets/images/brico_offer.png', // Assurez-vous que cette image existe
    kwetcheValue: 100,
  ),
  Offer(
    id: '2',
    title: 'Acthèké chez lys : 10% en bon d\'achats',
    partnerName: 'Chez Lys',
    description: 'Savourez un délicieux Acthèké avec 10% de réduction.',
    detailedDescription: 'Venez déguster le meilleur Acthèké de la ville dans un cadre convivial. Parfait pour vos déjeuners et dîners.\n\nIngrédients frais et recette traditionnelle.',
    address: '123 Rue de la Saveur\nCotonou, Bénin',
    phone: '229 9876 5432',
    openingHours: 'Ouvert tous les jours : 11:00 - 22:00',
    imagePath: 'assets/images/food_offer.png', // Assurez-vous que cette image existe
    kwetcheValue: 100,
  ),
  // Ajoutez d'autres offres ici
]; 