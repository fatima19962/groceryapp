import 'package:flutter/material.dart';
import 'package:groceryapp/inner_sceens/product_details.dart';
import 'package:groceryapp/models/products_model.dart';
import 'package:groceryapp/services/global_methods.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      child: Container(),
    );
  }
}
