import 'package:flutter/material.dart';
import 'package:glamcode/generated/assets.dart';
import 'package:glamcode/util/dimensions.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.imagesProfileBg),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Image.network(
                  color: Colors.white,
                  "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
                  height: MediaQuery.of(context).size.width * 0.2,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        "John Doe",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      child: Text(
                        "+916309672824",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
