
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  LocationPickerScreenState createState() => LocationPickerScreenState();
}

class LocationPickerScreenState extends State<LocationPickerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlacePicker(
        apiKey: r'AIzaSyAbpe1uQUBDEaQ8hyOEnEj4viZ0tbIud2I',
        onPlacePicked: (PickResult result) {
          print(result.formattedAddress);
        },
        initialPosition: const LatLng(19.0759837, 72.8776559),
        useCurrentLocation: true,
        automaticallyImplyAppBarLeading: false,
        enableMapTypeButton: false,
        autocompleteOffset: kToolbarHeight,
        selectedPlaceWidgetBuilder: (context, pickResult, searchingState, kbool) {
          return Container();
        }
      ),
    );
  }
}
