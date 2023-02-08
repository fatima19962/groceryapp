import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groceryapp/consts/theme_data.dart';
import 'package:groceryapp/inner_sceens/feeds_screen.dart';
import 'package:groceryapp/inner_sceens/on_sale_screen.dart';
import 'package:groceryapp/inner_sceens/product_details.dart';
import 'package:groceryapp/screens/btn_bar.dart';
import 'package:groceryapp/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';
import 'provider/dark_theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]).then((value) => runApp(MyApp()));
  runApp(MyApp());
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

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: BottomBarScreen(),
          routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeedsScreen.routeName: (ctx) => const FeedsScreen(),
            ProductDetails.routeName: (ctx) => const ProductDetails(),
            WishListScreen.routeName: (ctx) => const WishListScreen(),
          },
        );
      }),
    );
  }
}
