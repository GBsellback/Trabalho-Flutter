import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // Importando geolocator

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  LatLng _initialPosition = LatLng(-28.649487613709674, -53.104188246104165); // Posição inicial (São Paulo)
  bool _locationFetched = false; // Para garantir que a localização foi obtida
  Set<Marker> _markers = {}; // Conjunto de marcadores

  // Coordenadas para Ibirubá e Quinze de Novembro
  final LatLng _ibirubaPosition = LatLng(-28.63532339203497, -53.09876777222488); // Ibirubá, RS
  final LatLng _quinzeDeNovembroPosition = LatLng(-28.73816025381211, -53.091300095189915); // Quinze de Novembro, RS

  @override
  void initState() {
    super.initState();
    _getCurrentLocation(); // Tenta pegar a localização assim que o widget é inicializado
    _addMarkers(); // Adiciona os marcadores para as cidades
  }

  // Função para adicionar os marcadores para Ibirubá e Quinze de Novembro
  void _addMarkers() {
    final Marker ibirubaMarker = Marker(
      markerId: MarkerId('ibiruba'),
      position: _ibirubaPosition,
      infoWindow: InfoWindow(
        title: 'Ibirubá',
        snippet: 'Cidade em Rio Grande do Sul',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    final Marker quinzeDeNovembroMarker = Marker(
      markerId: MarkerId('quinze_de_novembro'),
      position: _quinzeDeNovembroPosition,
      infoWindow: InfoWindow(
        title: 'Quinze de Novembro',
        snippet: 'Cidade em Rio Grande do Sul',
      ),
      icon: BitmapDescriptor.defaultMarker,
    );

    // Adiciona os marcadores ao conjunto de marcadores
    setState(() {
      _markers.add(ibirubaMarker);
      _markers.add(quinzeDeNovembroMarker);
    });
  }

  // Função para obter a localização do usuário
  Future<void> _getCurrentLocation() async {
    // Verificar permissão de localização
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      print("Permissão de localização negada");
      return;
    }

    // Obter a posição atual
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude); // Atualiza a posição
      _locationFetched = true; // Marca que a localização foi obtida
    });

    // Movimentar o mapa para a posição atual do usuário
    _mapController.animateCamera(CameraUpdate.newLatLng(_initialPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Maps Flutter'),
      ),
      body: _locationFetched
          ? GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 12,
        ),
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true, // Mostra o ponto de localização do usuário
        compassEnabled: true, // Habilita a bússola
        markers: _markers, // Exibe os marcadores no mapa
      )
          : Center(child: CircularProgressIndicator()), // Mostra o carregando enquanto pega a localização
    );
  }
}
