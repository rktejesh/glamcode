import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/custom_text_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

class NewAddressScreen extends StatefulWidget {
  const NewAddressScreen({Key? key}) : super(key: key);

  @override
  State<NewAddressScreen> createState() => _NewAddressScreenState();
}

class _NewAddressScreenState extends State<NewAddressScreen>
    with AutomaticKeepAliveClientMixin {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController locationAddressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Form(
        child: PlacePicker(
          apiKey: r'AIzaSyAbpe1uQUBDEaQ8hyOEnEj4viZ0tbIud2I',
          onPlacePicked: (PickResult result) {
            print(result.formattedAddress);
          },
          initialPosition: const LatLng(19.0759837, 72.8776559),
          useCurrentLocation: true,
          automaticallyImplyAppBarLeading: false,
          enableMapTypeButton: false,
          strictbounds: true,
          onAutoCompleteFailed: (error) {
            print(error);
          },
          /*selectedPlaceWidgetBuilder:
                (_, selectedPlace, state, isSearchBarFocused) {
              return isSearchBarFocused
                  ? Container()
                  // Use FloatingCard or just create your own Widget.
                  : FloatingCard(
                      bottomPosition:
                          0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
                      leftPosition: 0.0,
                      rightPosition: 0.0,
                      width: 500,
                      borderRadius: BorderRadius.circular(12.0),
                      child: state == SearchingState.Searching
                          ? const Center(child: CircularProgressIndicator(color: Colors.black,))
                          : TextButton(
                              onPressed: () {
                                print("do something with [selectedPlace] data");
                              },
                              child: const Text("data"),
                            ),
                    );
              */ /*SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    customTextField("Name", nameController, TextInputType.text),
                    customTextField(
                        "Address", addressController, TextInputType.text),
                    customTextField("Location Address",
                        locationAddressController, TextInputType.streetAddress),
                    customTextField(
                        "Mobile Number", mobileController, TextInputType.phone),
                    Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text("Add Address"),
                      ),
                    ),
                  ],
                ),
              );*/ /*
            },*/
        ),
      ),
    );
  }
}
