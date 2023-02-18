import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/provider/dark_theme_provider.dart';
import 'package:groceryapp/screens/cart/cart_screen.dart';
import 'package:groceryapp/screens/categories.dart';
import 'package:groceryapp/screens/home_screen.dart';
import 'package:groceryapp/screens/user.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../provider/cart_provider.dart';
import '../widgets/text_widget.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'page': HomeScreen(), 'title': 'Home Screen'},
    {'page': CategoriesScreen(), 'title': 'Categories Screen'},
    {'page': CartScreen(), 'title': 'Cart Screen'},
    {'page': UserScreen(), 'title': 'User Screen'},
    // const HomeScreen(),
    // const CartScreen(),
    // const CategoriesScreen(),
    // const UserScreen(),
  ];

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    // final cartProvider = Provider.of<CartProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        unselectedItemColor: _isDark ? Colors.white10 : Colors.black12,
        selectedItemColor: _isDark ? Colors.lightBlue.shade200 : Colors.black87,
        onTap: _selectedPage,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(_selectedIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: "Categories"),
          BottomNavigationBarItem(
            label: "Cart",
            icon: Consumer<CartProvider>(builder: (_, myCart, ch) {
              return badges.Badge(
                position: badges.BadgePosition.topEnd(),
                badgeAnimation: const badges.BadgeAnimation.slide(
                  disappearanceFadeAnimationDuration:
                      Duration(milliseconds: 200),
                  curve: Curves.easeInCubic,
                ),
                badgeStyle: const badges.BadgeStyle(
                  padding: EdgeInsets.all(6),
                  badgeColor: Colors.blue,
                ),
                badgeContent: FittedBox(
                  child: TextWidget(
                    text: myCart.getCartItems.length.toString(),
                    color: Colors.white,
                    textSize: 15,
                  ),
                ),
                child: Icon(
                    _selectedIndex == 2 ? IconlyBold.buy : IconlyLight.buy),
              );
            }),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                  _selectedIndex == 3 ? IconlyBold.user_2 : IconlyLight.user_1),
              label: "User"),
        ],
      ),
    );
  }
}
