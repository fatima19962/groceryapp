import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapp/consts/theme_data.dart';
import 'package:groceryapp/inner_sceens/cat_screen.dart';
import 'package:groceryapp/inner_sceens/feeds_screen.dart';
import 'package:groceryapp/inner_sceens/on_sale_screen.dart';
import 'package:groceryapp/inner_sceens/product_details.dart';
import 'package:groceryapp/provider/cart_provider.dart';
import 'package:groceryapp/provider/products_provider.dart';
import 'package:groceryapp/provider/viewed_prod_provider.dart';
import 'package:groceryapp/provider/wishlist_provider.dart';
import 'package:groceryapp/screens/auth/login.dart';
import 'package:groceryapp/screens/auth/register.dart';
import 'package:groceryapp/screens/btn_bar.dart';
import 'package:groceryapp/screens/viewed_recently/viewed_recently.dart';
import 'package:groceryapp/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'provider/dark_theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyA1C4JDH_VlY_pHWjjMVdPtQ6x3cIV1ftc",
      // authDomain: "grocery-flutter-58d3f.firebaseapp.com",
      projectId: "grocery-flutter-58d3f",
      // storageBucket: "grocery-flutter-58d3f.appspot.com",
      messagingSenderId: "343207163766",
      appId: "1:343207163766:web:5c75c5890d47ac6b3bac57",
      // measurementId: "G-PL4BCKLGQ9"
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  // runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp();

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            const MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('An error occurred'),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              // ChangeNotifierProvider(
              //     create: (_) {
              //   return themeChangeProvider;
              // }),
              // ChangeNotifierProvider(
              //     create: (_) {
              //   ProductsProvider();
              // }),
              ChangeNotifierProvider(create: (_) {
                return themeChangeProvider;
              }),
              ChangeNotifierProvider(
                create: (_) => ProductsProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => CartProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => WishlistProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ViewedProdProvider(),
              ),
              // ChangeNotifierProvider(
              //   create: (_) => OrdersProvider(),
              // ),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                // home: BottomBarScreen(),
                home: const LoginScreen(),
                initialRoute: '/',
                routes: {
                  OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
                  FeedsScreen.routeName: (ctx) => const FeedsScreen(),
                  ProductDetails.routeName: (ctx) => const ProductDetails(),
                  WishListScreen.routeName: (ctx) => const WishListScreen(),
                  // OrderScreen.routeName: (ctx) => const OrderScreen(),
                  ViewedRecentlyScreen.routeName: (ctx) =>
                      const ViewedRecentlyScreen(),
                  LoginScreen.routeName: (ctx) => const LoginScreen(),
                  RegisterScreen.routeName: (ctx) => const RegisterScreen(),
                  CategoryScreen.routeName: (ctx) => const CategoryScreen(),
                },
              );
            }),
          );
        });
  }
}
