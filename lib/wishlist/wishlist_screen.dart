import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:groceryapp/provider/wishlist_provider.dart';
import 'package:groceryapp/screens/cart/cart_widget.dart';
import 'package:groceryapp/widgets/back_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:groceryapp/wishlist/wishlist_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../provider/cart_provider.dart';
import '../services/global_methods.dart';
import '../widgets/empty_screen.dart';

class WishListScreen extends StatelessWidget {
  static const routeName = "/WishListScreen";

  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your Wishlist Is Empty',
            subtitle: 'Explore more and shortlist some items',
            imagePath: 'assets/images/wishlist.png',
            buttonText: 'Add a wish',
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackWidget(),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: TextWidget(
                text: 'Wishlist (${wishlistItemsList.length})',
                textSize: 22,
                color: color,
                isTitle: true,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    GlobalMethods.warningDialog(
                        title: 'Empty your wishlist? ',
                        subtitle: 'Are you sure?',
                        fct: () async {
                          // await wishlistProvider.clearOnlineWishlist();
                          wishlistProvider.clearLocalWishlist();
                        },
                        context: context);
                  },
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
                MasonryGridView.count(
              crossAxisCount: 2,
              // mainAxisSpacing: 16,
              // crossAxisSpacing: 20,
              itemCount: wishlistItemsList.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ),
          );
  }
}
