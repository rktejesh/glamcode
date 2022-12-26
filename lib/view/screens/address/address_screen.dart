import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/address_details_model.dart';
import 'package:glamcode/data/model/coupons.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/address/edit_address.dart';
import 'package:glamcode/view/screens/address/new_address.dart';

import '../../base/custom_divider.dart';
import '../../base/loading_screen.dart';

class AddressDetailsScreen extends StatefulWidget {
  const AddressDetailsScreen({Key? key}) : super(key: key);

  @override
  State<AddressDetailsScreen> createState() => _AddressDetailsScreenState();
}

class _AddressDetailsScreenState extends State<AddressDetailsScreen> {
  late Future<AddressDetailsModel?> _future;

  @override
  void initState() {
    _future = DioClient.instance.getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SELECT ADDRESS"),
        ),
        body: FutureBuilder<AddressDetailsModel?>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingScreen();
            } else if (snapshot.connectionState == ConnectionState.done) {
              AddressDetailsModel addressData = AddressDetailsModel();
              if (snapshot.hasData) {
                addressData = snapshot.data!;
              }
              List<AddressDetails> addressList =
                  addressData.addressDetails ?? [];
              return Column(
                children: [
                  const CustomDivider(),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const NewAddressScreen(),
                        ),
                      );
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add),
                          Text(
                            "Add new address",
                            style: TextStyle(
                                fontSize: Dimensions.fontSizeExtraLarge),
                          )
                        ],
                      ),
                    ),
                  ),
                  const CustomDivider(),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return addressTile(addressList[index]);
                      }),
                ],
              );
            } else {
              ///TODO: write error page
              return Container();
            }
          },
        ));
  }
}

Widget addressTile(AddressDetails addressDetails) {
  return Padding(
    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                addressDetails.addressHeading ?? "",
                style: TextStyle(fontSize: Dimensions.fontSizeExtraLarge),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.edit,
                      size: Dimensions.fontSizeOverLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.delete_outline_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "${addressDetails.street ?? ""} ${addressDetails.pincode ?? ""}",
            style: TextStyle(fontSize: Dimensions.fontSizeLarge),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Icon(Icons.phone),
              Text(
                  "${addressDetails.callingCode ?? ""} ${addressDetails.mobileNumber ?? ""}"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {},
            child: const Text("Make it primary"),
          ),
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    ),
  );
}
