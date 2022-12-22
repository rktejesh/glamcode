import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/profile/widget/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileCard(),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: ListTile.divideTiles(
                context: context,
                color: Colors.black,
                tiles: [
                  profileListTile("Contact Us"),
                  profileListTile("About Glamcode"),
                  profileListTile("Rate Us"),
                  profileListTile("Privacy Policy"),
                  profileListTile("Terms and Conditions")
                ]).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

Widget profileListTile(String title) {
  return ListTile(
    trailing: const Icon(Icons.navigate_next_rounded),
    title: Text(title),
    onTap: () {},
  );
}
