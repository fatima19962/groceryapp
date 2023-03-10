import 'package:flutter/material.dart';

import 'package:groceryapp/consts/contss.dart';
import 'package:groceryapp/models/products_model.dart';
import 'package:iconly/iconly.dart';

// import 'package:groceryapp/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../provider/products_provider.dart';
import '../services/utils.dart';

// import '../widgets/back_widget.dart';
// import '../widgets/empty_products_widget.dart';
import '../widgets/back_widget.dart';
import '../widgets/empty_products_widget.dart';
import '../widgets/feed_item.dart';
import '../widgets/text_widget.dart';

class FeedsScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";

  const FeedsScreen({Key? key}) : super(key: key);

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
    super.initState();
  }

  List<ProductModel> listProdcutSearch = [];

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productsProvider.getProducts;
    return Scaffold(
      appBar: AppBar(
        // leading: const BackWidget(),
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
        centerTitle: true,
        title: TextWidget(
          text: 'All Products',
          color: color,
          textSize: 20.0,
          isTitle: true,
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: SizedBox(
      //           height: kBottomNavigationBarHeight,
      //           child: TextField(
      //             focusNode: _searchTextFocusNode,
      //             controller: _searchTextController,
      //             onChanged: (value) {
      //               setState(() {});
      //             },
      //             decoration: InputDecoration(
      //                 focusedBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                   borderSide:
      //                       BorderSide(color: Colors.greenAccent, width: 1),
      //                 ),
      //                 enabledBorder: OutlineInputBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                   borderSide:
      //                       BorderSide(color: Colors.greenAccent, width: 1),
      //                 ),
      //                 hintText: "What's in your mind?",
      //                 prefixIcon: Icon(Icons.search),
      //                 suffix: IconButton(
      //                   onPressed: () {
      //                     _searchTextController!.clear();
      //                     _searchTextFocusNode.unfocus();
      //                   },
      //                   icon: Icon(
      //                     Icons.close,
      //                     color: _searchTextFocusNode.hasFocus
      //                         ? Colors.red
      //                         : color,
      //                   ),
      //                 )),
      //           ),
      //         ),
      //       ),
      //       GridView.count(
      //         crossAxisSpacing: 10,
      //         shrinkWrap: true,
      //         padding: EdgeInsets.zero,
      //         physics: const NeverScrollableScrollPhysics(),
      //         crossAxisCount: 2,
      //         childAspectRatio: 1,
      //         children: List.generate(16, (index) {
      //           return FeedsWidget();
      //         }),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                focusNode: _searchTextFocusNode,
                controller: _searchTextController,
                onChanged: (value) {
                  setState(() {
                    listProdcutSearch = productsProvider.searchQuery(value);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(color: Colors.greenAccent, width: 1),
                  ),
                  hintText: "What's in your mind",
                  prefixIcon: const Icon(Icons.search),
                  suffix: IconButton(
                    onPressed: () {
                      _searchTextController!.clear();
                      _searchTextFocusNode.unfocus();
                    },
                    icon: Icon(
                      Icons.close,
                      color: _searchTextFocusNode.hasFocus ? Colors.red : color,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _searchTextController!.text.isNotEmpty && listProdcutSearch.isEmpty
              ? const EmptyProdWidget(
                  text: 'No products found, please try another keyword')
              : GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.zero,
                  // crossAxisSpacing: 10,
                  childAspectRatio: 1,
                  children: List.generate(
                      allProducts.length < 4
                          ? allProducts.length // length 3
                          : 4, (index) {
                    return ChangeNotifierProvider.value(
                      value: allProducts[index],
                      child: const FeedsWidget(),
                    );
                  }),
                )
          // GridView.count(
          //         shrinkWrap: true,
          //         physics: const NeverScrollableScrollPhysics(),
          //         crossAxisCount: 2,
          //         padding: EdgeInsets.zero,
          //         // crossAxisSpacing: 10,
          //         childAspectRatio: 1,
          //         children: List.generate(
          //             _searchTextController!.text.isNotEmpty
          //                 ? listProdcutSearch.length
          //                 : allProducts.length, (index) {
          //           return ChangeNotifierProvider.value(
          //             value: _searchTextController!.text.isNotEmpty
          //                 ? listProdcutSearch[index]
          //                 : allProducts[index],
          //             child: const FeedsWidget(),
          //           );
          //         }),
          //       ),
        ]),
      ),
    );
  }
}
