import 'package:flutter/material.dart';
import 'package:glamcode/data/api/api_helper.dart';
import 'package:glamcode/data/model/home_page.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/util/get_current_location.dart';
import 'package:glamcode/view/base/bottomServiceBar.dart';
import 'package:glamcode/view/base/error_screen.dart';
import 'package:glamcode/view/base/loading_screen.dart';
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
    super.initState();
    _future = DioClient.instance.getHomePage();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<HomePageModel?>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.connectionState == ConnectionState.done) {
          HomePageModel homePageModel = HomePageModel();
          if (snapshot.hasData) {
            homePageModel = snapshot.data!;
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _future = DioClient.instance.getHomePage();
                    });
                  },
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      locationAppBar(context),
                      searchBar(),
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(
                              Dimensions.PADDING_SIZE_DEFAULT),
                          child: Wrap(
                            children: [
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
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                  child: BottomServiceBar(),
                )
              ],
            );
          } else {
            return const CustomError();
          }
        } else {
          return const CustomError();
        }
      },
    );
  }
}

Widget locationAppBar(BuildContext context) {
  return SliverAppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
        color: const Color(0xFF882EDF), size: Dimensions.fontSizeOverLarge),
    toolbarHeight: Dimensions.fontSizeOverLarge * 1.5,
    pinned: true,
    floating: true,
    centerTitle: true,
    title: Text(
      "Home",
      style: TextStyle(
          fontSize: Dimensions.fontSizeLarge,
          color: Colors.black,
          fontWeight: FontWeight.bold),
      overflow: TextOverflow.ellipsis,
    ),
    titleSpacing: 0,
    leading: InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/location');
      },
      child: const Icon(Icons.location_on_rounded),
    ),
    actions: [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/cart');
        },
        child: const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
          child: Icon(Icons.shopping_cart_rounded),
        ),
      )
    ],
  );
}

Widget searchBar() {
  return SliverAppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    toolbarHeight: kToolbarHeight,
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
