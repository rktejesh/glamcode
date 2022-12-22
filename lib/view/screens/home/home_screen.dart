import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/screens/home/widget/customer_testimonials.dart';
import 'package:glamcode/view/screens/home/widget/packages.dart';
import 'package:glamcode/view/screens/home/widget/services_grid.dart';
import 'package:glamcode/view/screens/home/widget/slider.dart';
import 'package:glamcode/view/screens/home/widget/video_embed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  late Future<HomePageModel?> _future;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _future = DioClient().getHomePage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<HomePageModel?>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            HomePageModel homePageModel = HomePageModel();
            if (snapshot.hasData) {
              homePageModel = snapshot.data!;
            }
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                locationAppBar(context),
                searchBar(),
                SliverPadding(
                  padding:
                      const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        ImageSlider(
                          images: homePageModel.sliderImages ?? [],
                        ),
                        const ServicesGrid(),
                        VideoEmbed(
                          url: homePageModel.videos?.homePageVideoUrl ??
                              "https://www.youtube.com/watch?v=i-X4wtDprY8",
                        ),
                        const Packages(),
                        CustomerTestimonials(
                          reviews: homePageModel.reviews ?? [],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            ///TODO: write error page
            return Container();
          }
        });
  }
}

Widget locationAppBar(BuildContext context) {
  return SliverAppBar(
    elevation: 0,
    iconTheme:
        IconThemeData(color: Colors.grey, size: Dimensions.fontSizeOverLarge),
    toolbarHeight: Dimensions.fontSizeOverLarge * 1.5,
    pinned: true,
    floating: true,
    title: Text(
      "Vineet Khand",
      style: TextStyle(fontSize: Dimensions.fontSizeDefault),
      overflow: TextOverflow.ellipsis,
    ),
    titleSpacing: 0,
    leading: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/location');
        },
        child: const Icon(Icons.location_on_rounded)),
    actions: const [
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: Icon(Icons.shopping_cart_rounded),
      )
    ],
  );
}

Widget searchBar() {
  return SliverAppBar(
    toolbarHeight: Dimensions.PADDING_SIZE_DEFAULT + kToolbarHeight,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      background: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.PADDING_SIZE_DEFAULT,
            vertical: Dimensions.PADDING_SIZE_SMALL),
        child: SizedBox(
          width: double.infinity,
          child: TextFormField(
            autocorrect: true,
            enableSuggestions: true,
            cursorColor: Colors.grey,
            keyboardType: TextInputType.text,
            showCursor: true,
            style: const TextStyle(
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              fillColor: const Color(0x80D3D3D3),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
