import 'package:flutter/material.dart';
import 'package:groceryapp/screens/cart/cart_widget.dart';
import 'package:groceryapp/widgets/back_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';

import '../../services/utils.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = "/WishListScreen";

  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Scaffold(
        appBar: AppBar(
          leading: const BackWidget(),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: TextWidget(
            text: 'WishList (2)',
            textSize: 22,
            color: color,
            isTitle: true,
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(IconlyBroken.delete),
              color: color,
            ),
          ],
        ),
        body:
            // ListView.builder(
            //   itemCount: 10,
            //   itemBuilder: (ctx, index) {
            //     return CartWidget();
            //   },
            // ),
            Container());
  }
}
