import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapp/inner_sceens/product_details.dart';
import 'package:groceryapp/provider/wishlist_provider.dart';
import 'package:groceryapp/services/global_methods.dart';
import 'package:groceryapp/services/utils.dart';
import 'package:groceryapp/widgets/price_widget.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:groceryapp/models/products_model.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import 'heart_btn.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  // Widget build(BuildContext context) {
  //   Size size = Utils(context).getScreenSize;
  //   final Color color = Utils(context).color;
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Material(
  //       borderRadius: BorderRadius.circular(12),
  //       color: Theme.of(context).cardColor,
  //       child: Expanded(
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(12),
  //           onTap: () {},
  //           child: Expanded(
  //             child: Flexible(
  //               child: SingleChildScrollView(
  //                 child: Column(
  //                   // mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     FancyShimmerImage(
  //                       imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
  //                       height: size.width * 0.21,
  //                       width: size.width * 0.2,
  //                       boxFit: BoxFit.fill,
  //                     ),
  //                     Padding(
  //                       padding:
  //                           // const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //                           const EdgeInsets.symmetric(horizontal: 10),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           TextWidget(
  //                               text: "Title",
  //                               color: color,
  //                               textSize: 20,
  //                               isTitle: true),
  //                           const HeartBTN(),
  //                         ],
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const PriceWidget(),
  //                           const SizedBox(
  //                             width: 8,
  //                           ),
  //                           Expanded(
  //                             child: Flexible(
  //                               child: Row(
  //                                 children: [
  //                                   FittedBox(
  //                                     child: TextWidget(
  //                                         text: 'KG',
  //                                         color: color,
  //                                         textSize: 18,
  //                                         isTitle: true),
  //                                   ),
  //                                   const SizedBox(
  //                                     width: 5,
  //                                   ),
  //                                   Flexible(
  //                                       child: TextFormField(
  //                                     controller: _quantityTextController,
  //                                     key: const ValueKey('10'),
  //                                     style:
  //                                         TextStyle(color: color, fontSize: 18),
  //                                     keyboardType: TextInputType.number,
  //                                     maxLines: 1,
  //                                     enabled: true,
  //                                     inputFormatters: [
  //                                       FilteringTextInputFormatter.allow(
  //                                           RegExp('[0-9.,]'))
  //                                     ],
  //                                   )),
  //                                 ],
  //                               ),
  //                             ),
  //                           )
  //                         ],
  //                       ),
  //                     ),
  //                     const Spacer(),
  //                     Expanded(
  //                       child: SizedBox(
  //                         width: double.infinity,
  //                         child: Wrap(
  //                           direction: Axis.horizontal,
  //                           spacing: 50,
  //                           children: [
  //                             TextButton(
  //                               onPressed: () {},
  //                               style: ButtonStyle(
  //                                   backgroundColor: MaterialStateProperty.all(
  //                                       Theme.of(context).cardColor),
  //                                   tapTargetSize:
  //                                       MaterialTapTargetSize.shrinkWrap,
  //                                   shape: MaterialStateProperty.all<
  //                                           RoundedRectangleBorder>(
  //                                       const RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.only(
  //                                         bottomLeft: Radius.circular(12),
  //                                         bottomRight: Radius.circular(12)),
  //                                   ))),
  //                               child: Expanded(
  //                                 child: Column(
  //                                   children: [
  //                                     // Expanded(child: SizedBox.shrink()),
  //                                     // Spacer(),
  //                                     // SizedBox(
  //                                     //   height: 5,
  //                                     //   width: 5,
  //                                     // ),
  //                                     TextWidget(
  //                                       text: 'Add to cart',
  //                                       maxLines: 1,
  //                                       color: color,
  //                                       textSize: 20,
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // GlobalMethods.navigateTo(
            //     ctx: context, routeName: ProductDetails.routeName);
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 3,
                child: FancyShimmerImage(
                  imageUrl: productModel.imageUrl,
                  height: size.width * 0.21,
                  width: size.width * 0.2,
                  boxFit: BoxFit.fill,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: TextWidget(
                        text: productModel.title,
                        color: color,
                        textSize: 18,
                        maxLines: 1,
                        isTitle: true),
                  ),
                  Flexible(
                    flex: 1,
                    child: HeartBTN(
                      productId: productModel.id,
                      isInWishlist: _isInWishlist,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 3,
                    child: PriceWidget(
                      salePrice: productModel.salePrice,
                      price: productModel.price,
                      textPrice: _quantityTextController.text,
                      isOnSale: productModel.isOnSale,
                      // isOnSale: true,
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  // const SizedBox(
                  //   width: 3,
                  // ),
                  Flexible(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 5,
                          child: FittedBox(
                            child: TextWidget(
                                text: productModel.isPiece ? 'Piece' : 'kg',
                                color: color,
                                textSize: 18,
                                isTitle: true),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          flex: 1,
                          child: TextFormField(
                            controller: _quantityTextController,
                            key: const ValueKey('10'),
                            style: TextStyle(color: color, fontSize: 18),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            onChanged: (v) {
                              setState(() {
                                if (v.isEmpty) {
                                  _quantityTextController.text = '1';
                                } else {
                                  return;
                                }
                              });
                            },
                            // enabled: true,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp('[0-9.]'))
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              // const SizedBox(
              //   height: 6,
              // ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isInCart
                      ? null
                      : () {
                          // if (_isInCart) {
                          //   return;
                          // }
                          cartProvider.addProductsToCart(
                              productId: productModel.id,
                              quantity:
                                  int.parse(_quantityTextController.text));
                        },

                  // onPressed: _isInCart
                  // ? null
                  //     : () async {
                  // if (_isInCart) {
                  //   return;
                  // }
                  // final User? user = authInstance.currentUser;
                  //
                  // if (user == null) {
                  // GlobalMethods.errorDialog(
                  // subtitle: 'No user found, Please login first',
                  // context: context);
                  // return;
                  // }
                  // await GlobalMethods.addToCart(
                  // productId: productModel.id,
                  // quantity: int.parse(_quantityTextController.text),
                  // context: context);
                  // await cartProvider.fetchCart();
                  // cartProvider.addProductsToCart(
                  //     productId: productModel.id,
                  //     quantity: int.parse(_quantityTextController.text));

                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12)),
                      ))),
                  child: TextWidget(
                    // text: 'Add to cart',
                    text: _isInCart ? 'In cart' : 'Add to cart',
                    maxLines: 1,
                    color: color,
                    textSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
