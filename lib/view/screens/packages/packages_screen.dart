import 'package:flutter/material.dart';
import 'package:glamcode/util/dimensions.dart';
import 'package:glamcode/view/base/package_tile.dart';
import 'package:glamcode/view/screens/home/widget/services_grid.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Packages",
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            labelColor: Colors.black,
            padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            labelPadding: const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
            unselectedLabelColor: Colors.white,
            isScrollable: true,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            tabs: const [
              Text("Facial Deals"),
              Text("Facial Deals"),
              Text("Facial Deals"),
              Text("Facial Deals"),
              Text("Facial Deals"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    insetPadding:
                        const EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0)), //this right here
                    child: const SizedBox(child: ServicesGrid()),
                  );
                });
          },
          label: const Text("Menu"),
          icon: const Icon(Icons.grid_view_rounded),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        body: TabBarView(children: [
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PackageTile(
                src: "https://picsum.photos/250?image=1",
                title: 'Legs Show Off',
                newPrice: '429',
                oldPrice: '858',
              );
            },
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PackageTile(
                src: "https://picsum.photos/250?image=1",
                title: 'Legs Show Off',
                newPrice: '429',
                oldPrice: '858',
              );
            },
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PackageTile(
                src: "https://picsum.photos/250?image=1",
                title: 'Legs Show Off',
                newPrice: '429',
                oldPrice: '858',
              );
            },
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PackageTile(
                src: "https://picsum.photos/250?image=1",
                title: 'Legs Show Off',
                newPrice: '429',
                oldPrice: '858',
              );
            },
          ),
          ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return const PackageTile(
                src: "https://picsum.photos/250?image=1",
                title: 'Legs Show Off',
                newPrice: '429',
                oldPrice: '858',
              );
            },
          ),
        ]),
      ),
    );
  }
}
