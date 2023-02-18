import 'package:flutter/material.dart';
import 'package:groceryapp/services/global_methods.dart';
import 'package:groceryapp/services/utils.dart';
import 'package:groceryapp/widgets/heart_btn.dart';
import 'package:groceryapp/widgets/price_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:provider/provider.dart';

import '../inner_sceens/product_details.dart';
import '../models/products_model.dart';
import '../provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
//     // final Color color = Utils(context).color;
//     // final theme = Utils(context).getTheme;
//     // Size size = Utils(context).getScreenSize;
//     // return Padding(
//     //   padding: const EdgeInsets.all(8.0),
//     //   child: Material(
//     //     color: Theme.of(context).cardColor.withOpacity(0.9),
//     //     borderRadius: BorderRadius.circular(12),
//     //     child: InkWell(
//     //       borderRadius: BorderRadius.circular(12),
//     //       onTap: () {},
//     //       child: Padding(
//     //         padding: const EdgeInsets.all(8.0),
//     //         child: SingleChildScrollView(
//     //           child: Column(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             mainAxisAlignment: MainAxisAlignment.start,
//     //             children: [
//     //               Row(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 children: [
//     //                   Image.network(
//     //                     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3OwLau2NwuE3_tzL2H2IUIxEhajEP8TrWjg&usqp=CAU',
//     //                     //  width: size.width * 0.22,
//     //                     height: size.height * 0.22,
//     //                     fit: BoxFit.fill,
//     //                   ),
//     //                   Column(
//     //                     children: [
//     //                       TextWidget(
//     //                           text: "1KG",
//     //                           color: color,
//     //                           textSize: 22,
//     //                           isTitle: true),
//     //                       const SizedBox(
//     //                         height: 6,
//     //                       ),
//     //                       Row(
//     //                         children: [
//     //                           GestureDetector(
//     //                             onTap: () {},
//     //                             child: Icon(
//     //                               IconlyLight.bag_2,
//     //                               size: 22,
//     //                               color: color,
//     //                             ),
//     //                           ),
//     //                           GestureDetector(
//     //                             onTap: () {
//     //                               debugPrint("heart is pressed");
//     //                             },
//     //                             child: Icon(
//     //                               IconlyLight.heart,
//     //                               size: 22,
//     //                               color: color,
//     //                             ),
//     //                           ),
//     //                         ],
//     //                       ),
//     //                     ],
//     //                   ),
//     //                 ],
//     //               ),
//     //               PriceWidget(),
//     //               const SizedBox(
//     //                 height: 5,
//     //               ),
//     //               TextWidget(
//     //                 text: 'Product title',
//     //                 color: color,
//     //                 textSize: 10,
//     //                 isTitle: true,
//     //               ),
//     //               const SizedBox(
//     //                 height: 5,
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     ),
//     //   ),
//     // );
    final Color color = Utils(context).color;
    final theme = Utils(context).getTheme;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              Navigator.pushNamed(context, ProductDetails.routeName,
                  arguments: productModel.id);
              // GlobalMethods.navigateTo(
              //     ctx: context, routeName: ProductDetails.routeName);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FancyShimmerImage(
                            imageUrl: productModel.imageUrl,
                            height: size.width * 0.22,
                            width: size.width * 0.22,
                            boxFit: BoxFit.fill,
                          ),

                          // SizedBox(
                          //   width: 6,
                          // ),
                          // Image.network(
                          //   'https://i.ibb.co/F0s3FHQ/Apricots.png',
                          //   // width: size.width*0.22,
                          //   height: size.width * 0.22,
                          //   fit: BoxFit.fill,
                          // ),
                          Column(
                            children: [
                              TextWidget(
                                text: productModel.isPiece ? '1Piece' : '1KG',
                                color: color,
                                textSize: 22,
                                isTitle: true,
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartProvider.addProductsToCart(
                                          productId: productModel.id,
                                          quantity: 1);
                                    },
                                    // onTap: _isInCart
                                    //     ? null
                                    //     : () async {
                                    //   final User? user =
                                    //       authInstance.currentUser;
                                    //
                                    //   if (user == null) {
                                    //     GlobalMethods.errorDialog(
                                    //         subtitle:
                                    //         'No user found, Please login first',
                                    //         context: context);
                                    //     return;
                                    //   }
                                    //   await GlobalMethods.addToCart(
                                    //       productId: productModel.id,
                                    //       quantity: 1,
                                    //       context: context);
                                    //   await cartProvider.fetchCart();
                                    //   // cartProvider.addProductsToCart(
                                    //   //     productId: productModel.id,
                                    //   //     quantity: 1);
                                    // },
                                    //   child: Icon(
                                    //     _isInCart
                                    //         ? IconlyBold.bag2
                                    //         : IconlyLight.bag2,
                                    //     size: 22,
                                    //     color: _isInCart ? Colors.green : color,
                                    //   ),
                                    // ),
                                    // HeartBTN(
                                    //   productId: productModel.id,
                                    //   isInWishlist: _isInWishlist,
                                    // )
                                    child: Icon(
                                      _isInCart
                                          ? IconlyBold.bag_2
                                          : IconlyLight.bag_2,
                                      size: 22,
                                      color: _isInCart ? Colors.green : color,
                                    ),
                                  ),
                                  HeartBTN(
                                    productId: productModel.id,
                                    isInWishlist: _isInWishlist,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      PriceWidget(
                        price: productModel.price,
                        salePrice: productModel.salePrice,
                        textPrice: "1",
                        isOnSale: true,
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: productModel.title,
                        color: color,
                        textSize: 16,
                        isTitle: true,
                      ),
                      const SizedBox(height: 5),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
