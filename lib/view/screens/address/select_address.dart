import 'package:flutter/material.dart';
import 'package:glamcode/view/screens/address/edit_address.dart';
import 'package:glamcode/view/screens/address/new_address.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';

import '../../../data/model/address_details_model.dart';
import '../../../util/dimensions.dart';

class SelectAddressScreen extends StatefulWidget {
  final bool edit;
  final AddressDetails addressDetails;
  const SelectAddressScreen(
      {Key? key, required this.edit, required this.addressDetails})
      : super(key: key);

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return PlacePicker(
      apiKey: r'AIzaSyAbpe1uQUBDEaQ8hyOEnEj4viZ0tbIud2I',
      initialPosition: const LatLng(19.0759837, 72.8776559),
      useCurrentLocation: true,
      automaticallyImplyAppBarLeading: false,
      enableMapTypeButton: false,
      selectedPlaceWidgetBuilder:
          (_, selectedPlace, state, isSearchBarFocused) {
        return isSearchBarFocused
            ? Container()
            : FloatingCard(
                bottomPosition: 0.0,
                leftPosition: 0.0,
                rightPosition: 0.0,
                borderRadius: BorderRadius.circular(12.0),
                child: SizedBox(
                  child: Center(
                    child: state == SearchingState.Searching
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: Text("SELECT ADDRESS"),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal:
                                        Dimensions.PADDING_SIZE_DEFAULT),
                                child: selectedPlace?.addressComponents != null
                                    ? Row(
                                        children: [
                                          const Icon(
                                              Icons.location_on_outlined),
                                          Text(
                                            selectedPlace?.addressComponents![1]
                                                    .shortName ??
                                                "",
                                            style: TextStyle(
                                                fontSize: Dimensions
                                                    .fontSizeOverLarge,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    : Container(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: Text(
                                  selectedPlace?.formattedAddress ?? "",
                                  style: TextStyle(
                                      fontSize: Dimensions.fontSizeLarge),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_DEFAULT),
                                child: TextButton(
                                  onPressed: () {
                                    widget.addressDetails.address =
                                        selectedPlace?.addressComponents![1]
                                                .shortName ??
                                            "";
                                    widget.addressDetails.street =
                                        selectedPlace?.formattedAddress ?? "";
                                    widget.addressDetails.lattitude =
                                        selectedPlace?.geometry?.location.lat ??
                                            0;
                                    widget.addressDetails.longitude =
                                        selectedPlace?.geometry?.location.lng ??
                                            0;
                                    widget.edit
                                        ? Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditAddressScreen(
                                                    addressDetails:
                                                        widget.addressDetails,
                                                  ),
                                                ),
                                                ModalRoute.withName('/address'))
                                        : Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewAddressScreen(
                                                address: selectedPlace
                                                        ?.addressComponents![1]
                                                        .shortName ??
                                                    "",
                                                locAddress: selectedPlace
                                                        ?.formattedAddress ??
                                                    "",
                                                latitude: selectedPlace
                                                        ?.geometry
                                                        ?.location
                                                        .lat ??
                                                    0,
                                                longitude: selectedPlace
                                                        ?.geometry
                                                        ?.location
                                                        .lng ??
                                                    0,
                                              ),
                                            ),
                                          );
                                  },
                                  child: const Text("CONFIRM LOCATION"),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              );
      },
      onAutoCompleteFailed: (error) {
        print(error);
      },
    );
  }
}
