import 'package:flutter/material.dart';
import 'package:groceryapp/screens/cart/cart_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';

import '../../services/utils.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: TextWidget(
          text: 'Cart (2)',
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
      body: Column(
        children: [
          _checkout(ctx: context),
          // SizedBox(
          //   width: double.infinity,
          //   height: size.height * 0.1,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Row(
          //       children: [
          //         Material(
          //           color: Colors.green,
          //           borderRadius: BorderRadius.circular(10),
          //           child: InkWell(
          //             borderRadius: BorderRadius.circular(10),
          //             onTap: () {},
          //             child: Padding(
          //               padding: const EdgeInsets.all(8.0),
          //               child: TextWidget(
          //                 text: 'Order Now',
          //                 textSize: 20,
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (ctx, index) {
                return CartWidget();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkout({required BuildContext ctx}) {
    Size size = Utils(ctx).getScreenSize;
    final Color color = Utils(ctx).color;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextWidget(
                    text: 'Order Now',
                    textSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FittedBox(
              child: TextWidget(
                  text: 'Total: \$0.259',
                  color: color,
                  textSize: 18,
                  isTitle: true),
            ),
          ],
        ),
      ),
    );
  }
}
