import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/main_categories_model.dart';
import 'package:glamcode/util/dimensions.dart';

class ServicesGrid extends StatefulWidget {
  const ServicesGrid({Key? key}) : super(key: key);

  @override
  State<ServicesGrid> createState() => _ServicesGridState();
}

class _ServicesGridState extends State<ServicesGrid>
    with AutomaticKeepAliveClientMixin {
  late Future<MainCategoriesModel?> mainCategoriesModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainCategoriesModel = DioClient().getMainCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<MainCategoriesModel?>(
        future: mainCategoriesModel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Maincat> mainCatModelData;
            if (snapshot.hasData && snapshot.data!.status == "success") {
              mainCatModelData = snapshot.data?.maincat ?? [];
              return GridView.builder(
                padding:
                    const EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: mainCatModelData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return imageGridCard(
                      mainCatModelData[index].mainCategoryImageUrl ?? "",
                      mainCatModelData[index].name ?? "",
                      context);
                },
              );
            } else {
              ///TODO: error
              return Container();
            }
          } else {
            ///TODO: error
            return Container();
          }
        });
  }
}

Widget imageGridCard(String imageUrl, String title, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/packages', ModalRoute.withName('/'));
      // Navigator.pushNamed(context, '/packages');
    },
    child: SizedBox(
      height: 50,
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            // backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.grey,
            child: ClipOval(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: NetworkImage(imageUrl),
                )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    ),
  );
}
