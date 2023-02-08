import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/inner_sceens/feeds_screen.dart';
import 'package:groceryapp/inner_sceens/on_sale_screen.dart';
import 'package:groceryapp/provider/dark_theme_provider.dart';
import 'package:groceryapp/services/global_methods.dart';
import 'package:groceryapp/services/utils.dart';
import 'package:groceryapp/widgets/feed_item.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../consts/contss.dart';
import '../models/products_model.dart';
import '../provider/products_provider.dart';
import '../widgets/on_sale_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _offerImages = [
    'assets/images/offers/Offer1.jpg',
    'assets/images/offers/Offer2.jpg',
    'assets/images/offers/Offer3.jpg',
    'assets/images/offers/Offer4.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    // final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = Utils(context).color;
    final Utils utils = Utils(context);
    final themeState = utils.getTheme;
    Size size = Utils(context).getScreenSize;
    // GlobalMethods globalMethods = GlobalMethods();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              //     child: SwitchListTile(
              //   title: Text('Theme'),
              //   secondary: Icon(themeState.getDarkTheme
              //       ? Icons.dark_mode_outlined
              //       : Icons.light_mode_outlined),
              //   onChanged: (bool value) {
              //     setState(() {
              //       themeState.setDarkTheme = value;
              //     });
              //   },
              //   value: themeState.getDarkTheme,
              // )
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  // return Image.network(
                  //   _offerImages[index],
                  //   fit: BoxFit.fill,
                  // );
                  return Image.asset(
                    _offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: _offerImages.length,
                pagination: const SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.white, activeColor: Colors.red)),
                // control: const SwiperControl(color: Colors.black),
              ),
            ),
            // OnSaleWidget(),
            const SizedBox(
              height: 6,
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, OnSaleScreen.routeName);
                // globalMethods.navigateTo(
                //     ctx: context, routeName: OnSaleScreen.routeName);
              },
              child: TextWidget(
                  text: "View All",
                  maxLines: 1,
                  color: Colors.blue,
                  textSize: 20),
            ),
            const SizedBox(
              height: 6,
            ),

            Row(children: [
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(
                      text: 'On sale'.toUpperCase(),
                      color: Colors.red,
                      textSize: 22,
                      isTitle: true,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      IconlyLight.discount,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(
                child: SizedBox(
                  height: size.height * 0.24,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return const OnSaleWidget();
                      }),
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                // direction: Axis.vertical,
                // alignment: WrapAlignment.end,
                // spacing: 10.0,
                // runSpacing: 20.0,
                // alignment: WrapAlignment.spaceBetween,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Our Product',
                    color: color,
                    textSize: 22,
                    isTitle: true,
                  ),
                  // const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, FeedsScreen.routeName);
                    },
                    child: TextWidget(
                        text: "Browse All",
                        maxLines: 1,
                        color: Colors.blue,
                        textSize: 20),
                  ),
                ],
              ),
            ),
            // GridView.count(
            //   crossAxisSpacing: 10,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   crossAxisCount: 2,
            //   childAspectRatio: MediaQuery.of(context).size.width /
            //       (MediaQuery.of(context).size.height / 1.4),
            //   // childAspectRatio: (size.width ) / (size.height*0.6),
            //   children: List.generate(4, (index) {
            //     return FeedsWidget();
            //   }),
            GridView.count(
              crossAxisSpacing: 10,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: List.generate(4, (index) {
                return FeedsWidget();
              }),
            )
            // GridView.builder(
            //   gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            //     maxCrossAxisExtent: 10,
            //     childAspectRatio: 1,
            //     crossAxisSpacing: 10,
            //     // mainAxisSpacing: 20,
            //   ),
            //   itemCount: 5,
            //   itemBuilder: (_, int index) {
            //     return FeedsWidget();
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
