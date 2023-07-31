import 'package:GoogleLogin/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  late GoogleMapController mapController;
  static const LatLng _center =
      const LatLng(-6.1754, 106.8272); // Koordinat Jakarta
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('jakarta'),
          position: _center,
          infoWindow: InfoWindow(
            title: 'Jakarta',
            snippet: 'Kota Jakarta',
          ),
        ),
      );
    });
  }

  void _handleLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _showLogoutSuccessAlert(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/sign-in',
        (route) => false,
      );
    } catch (error) {
      print('Terjadi kesalahan saat logout: $error');
    }
  }

  Future<void> _showLogoutSuccessAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Berhasil'),
          content: Text('Anda berhasil logout.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _markers,
      ),
      // Tombol logout sebagai floating button
      floatingActionButton: FloatingActionButton(
        onPressed: _handleLogout,
        child: Icon(Icons.logout),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
