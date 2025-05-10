import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'scan_qr_screen.dart';

class DepotScreen extends StatefulWidget {
  const DepotScreen({Key? key}) : super(key: key);

  @override
  State<DepotScreen> createState() => _DepotScreenState();
}

class _DepotScreenState extends State<DepotScreen> {
  bool _showMap = true;
  final MapController _mapController = MapController();
  LatLng _currentPosition = LatLng(6.3702, 2.3912); // Cotonou par défaut
  bool _isLoading = true;
  List<LatLng> _polylinePoints = [];
  Map<String, dynamic>? _selectedDepot;

  // Liste des dépôts (vous pourriez charger ces données depuis une API)
  final List<Map<String, dynamic>> _depots = [
    {
      'id': 'depot1',
      'name': 'Place des Martyrs',
      'distance': '500 m',
      'position': LatLng(6.3722, 2.3932),
    },
    {
      'id': 'depot2',
      'name': 'Marché Dantokpa',
      'distance': '1.2 km',
      'position': LatLng(6.3650, 2.4350),
    },
    {
      'id': 'depot3',
      'name': "Université d'Abomey-Calavi",
      'distance': '500 m',
      'position': LatLng(6.4185, 2.3430),
    },
    {
      'id': 'depot4',
      'name': "Stade de l'Amitié",
      'distance': '1.8 km',
      'position': LatLng(6.3639, 2.4294),
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  // Demander la permission de localisation et obtenir la position actuelle
  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    // Vérifier et demander les permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Les permissions sont refusées
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Les permissions sont refusées de façon permanente
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Obtenir la position actuelle
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      
      // Centrer la carte sur la position actuelle
      _mapController.move(_currentPosition, 14);
    } catch (e) {
      print('Erreur de localisation: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Centrer sur un dépôt spécifique (depuis la liste)
  void _centerOnDepot(LatLng position) {
    setState(() {
      _showMap = true;
    });
    
    _mapController.move(position, 16);
  }

  // Tracer une ligne directe entre la position actuelle et le dépôt
  void _getDirections(LatLng destination) {
    setState(() {
      _polylinePoints = [_currentPosition, destination];
      _selectedDepot = _depots.firstWhere(
        (depot) => depot['position'] == destination,
        orElse: () => _depots.first,
      );
    });
    
    // Ajuster la vue de la carte pour montrer tout l'itinéraire
    _fitBounds();
  }

  // Ajuster la vue de la carte pour montrer tout l'itinéraire
  void _fitBounds() {
    if (_polylinePoints.isEmpty) return;

    double minLat = _polylinePoints[0].latitude;
    double maxLat = _polylinePoints[0].latitude;
    double minLng = _polylinePoints[0].longitude;
    double maxLng = _polylinePoints[0].longitude;

    for (var point in _polylinePoints) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    // Ajouter une marge pour que les points ne soient pas trop près des bords
    final latPadding = (maxLat - minLat) * 0.2;
    final lngPadding = (maxLng - minLng) * 0.2;

    _mapController.fitBounds(
      LatLngBounds(
        LatLng(minLat - latPadding, minLng - lngPadding),
        LatLng(maxLat + latPadding, maxLng + lngPadding),
      ),
      options: const FitBoundsOptions(padding: EdgeInsets.all(50.0)),
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
          'Trouver un dépôt',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location, color: Colors.orange),
            onPressed: _getCurrentLocation,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Onglets Carte/Liste
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    // Onglet Carte
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMap = true;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: _showMap ? Colors.orange : Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Carte',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Onglet Liste
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showMap = false;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: !_showMap ? Colors.orange : Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Liste',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Contenu (Carte ou Liste)
              Expanded(
                child: _showMap ? _buildMap() : _buildList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _polylinePoints.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanQrScreen()),
                );
              },
              backgroundColor: Colors.orange,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Scanner le QR Code'),
            )
          : null,
    );
  }

  // Widget pour afficher la carte OpenStreetMap
  Widget _buildMap() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _currentPosition,
          initialZoom: 14,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.bemi_app',
          ),
          
          // Polylines pour l'itinéraire
          PolylineLayer(
            polylines: [
              if (_polylinePoints.isNotEmpty)
                Polyline(
                  points: _polylinePoints,
                  color: Colors.blue,
                  strokeWidth: 4.0,
                ),
            ],
          ),
          
          MarkerLayer(
            markers: [
              // Marqueur pour la position actuelle
              Marker(
                width: 30,
                height: 30,
                point: _currentPosition,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
              
              // Marqueurs pour les dépôts
              ..._depots.map((depot) => Marker(
                width: 40,
                height: 40,
                point: depot['position'],
                child: GestureDetector(
                  onTap: () {
                    _showDepotDetails(depot);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: _selectedDepot?['id'] == depot['id'] 
                          ? Colors.orange 
                          : Colors.green.withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.recycling,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              )),
            ],
          ),
        ],
      ),
    );
  }

  // Afficher les détails du dépôt sélectionné
  void _showDepotDetails(Map<String, dynamic> depot) {
    setState(() {
      _selectedDepot = depot;
    });
    
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              depot['name'],
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Distance: ${depot["distance"]}'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _getDirections(depot['position']);
                    },
                    icon: const Icon(Icons.directions),
                    label: const Text('Obtenir des directions'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            if (_polylinePoints.contains(depot['position']))
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ScanQrScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.qr_code_scanner),
                        label: const Text('Scanner le QR Code'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2F9359),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Widget pour afficher la liste des dépôts
  Widget _buildList() {
    return ListView.builder(
      itemCount: _depots.length,
      itemBuilder: (context, index) {
        final depot = _depots[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      depot['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      depot['distance'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _centerOnDepot(depot['position']);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Lieu',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
} 