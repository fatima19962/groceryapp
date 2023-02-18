import 'package:flutter/material.dart';
import 'package:groceryapp/services/utils.dart';
import 'package:groceryapp/widgets/empty_products_widget.dart';
import 'package:groceryapp/widgets/on_sale_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../models/products_model.dart';
import '../provider/products_provider.dart';
import '../widgets/back_widget.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";

  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isEmpty = true;
    final Color color = Utils(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productsProvider.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        // leading: InkWell(
        //   borderRadius: BorderRadius.circular(12),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Icon(
        //     IconlyLight.arrow_left_2,
        //     color: color,
        //   ),
        // ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Products on sale',
          color: color,
          textSize: 24.0,
          isTitle: true,
        ),
      ),
      body: productsOnSale.isEmpty
          ? const EmptyProdWidget(
              text: "No products on sale yet!,\nStay tuned",
            )
          // ? Center(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.all(18.0),
          //             child: Image.asset("assets/images/box.png"),
          //           ),
          //           Text(
          //             "No products on sale yet!,\nStay tuned",
          //             style: TextStyle(
          //                 color: color,
          //                 fontSize: 30,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ],
          //       ),
          //     ),
          //   )
          : GridView.count(
              crossAxisSpacing: 10,
              // shrinkWrap: true,
              padding: EdgeInsets.zero,
              // physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1,
              children: List.generate(productsOnSale.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productsOnSale[index], child: const OnSaleWidget());
              }),
            ),
    );
  }
}
