import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glamcode/blocs/auth/auth_bloc.dart';
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
                  profileListTile("Contact Us", context, "/terms"),
                  profileListTile("About Glamcode", context, "/about"),
                  profileListTile("Rate Us", context, "/terms"),
                  profileListTile("Privacy Policy", context, "/privacy"),
                  profileListTile("Terms and Conditions", context, "/terms")
                ]).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                final AuthBloc authBloc = context.read<AuthBloc>();
                authBloc.userRepository.signOut();
                authBloc.add(AppLoaded());
              },
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

Widget profileListTile(String title, BuildContext context, String url) {
  return ListTile(
    trailing: const Icon(Icons.navigate_next_rounded),
    title: Text(title),
    onTap: () {
      Navigator.of(context).pushNamed(url);
    },
  );
}
