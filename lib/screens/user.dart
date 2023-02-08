import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/provider/dark_theme_provider.dart';
import 'package:groceryapp/services/global_methods.dart';
import 'package:groceryapp/widgets/text_widget.dart';
import 'package:groceryapp/wishlist/wishlist_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
      TextEditingController(text: "");

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  text: 'Hi, ',
                  style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'MyName',
                      style: TextStyle(
                        color: color,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print("my name is taped");
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextWidget(
                text: 'Email@example.com',
                textSize: 18,
                color: color,
                // isTitle: true,
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
              ),
              const SizedBox(
                height: 20,
              ),
              _listTiles(
                  title: 'Address',
                  icon: IconlyBold.profile,
                  subtitle: 'my address',
                  onPressed: () async {
                    await _showAddressDialog();
                  },
                  color: color),
              _listTiles(
                  title: 'Order',
                  icon: IconlyBold.bag,
                  onPressed: () {},
                  color: color),
              _listTiles(
                  title: 'Wishlist',
                  icon: IconlyBold.heart,
                  onPressed: () {
                    GlobalMethods.navigateTo(
                        ctx: context, routeName: WishListScreen.routeName);
                  },
                  color: color),
              _listTiles(
                  title: 'Viewed',
                  icon: IconlyBold.show,
                  onPressed: () {},
                  color: color),
              _listTiles(
                  title: 'Forget Password',
                  icon: IconlyBold.unlock,
                  onPressed: () {},
                  color: color),
              SwitchListTile(
                title: TextWidget(
                  text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                  textSize: 18,
                  color: color,
                  // isTitle: true,
                ),
                secondary: Icon(themeState.getDarkTheme
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined),
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
                value: themeState.getDarkTheme,
              ),
              _listTiles(
                title: 'LogOut',
                icon: IconlyBold.logout,
                onPressed: () {
                  _showLogoutDialog();
                },
                color: color,
              ),

              // ListTile(
              //   title: Text('Address',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              //   subtitle: Text('Subtitle here'),
              //   leading: Icon(IconlyLight.profile),
              //   trailing: Icon(IconlyLight.arrow_right_2),
              // ),
              // ListTile(
              //   title: Text('Address',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
              //   subtitle: Text('Subtitle here'),
              //   leading: Icon(IconlyLight.profile),
              //   trailing: Icon(IconlyLight.arrow_right_2),
              // ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/warning-sign.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("Sign out"),
              ],
            ),
            content: const Text("Do you wanna sign out?"),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: "Cancel",
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  color: Colors.red,
                  text: "Ok",
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showAddressDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update"),
            content: TextField(
              // onChanged: (value) {
              //   // _addressTextController.text;
              //   print(
              //       '_addressTextController.text ${_addressTextController.text}');
              // },
              controller: _addressTextController,
              maxLines: 5,
              decoration: const InputDecoration(hintText: "Your address"),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: const Text("Update"),
              ),
            ],
          );
        });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      // title: Text(title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
      title: TextWidget(
        text: title,
        textSize: 18,
        color: color,
        // isTitle: true,
      ),
      // subtitle: Text(subtitle!),
      subtitle: TextWidget(
        text: subtitle ?? "",
        textSize: 18,
        color: color,
      ),

      // subtitle: Text(subtitle == null ? "":subtitle),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrow_right_2),
      onTap: () {
        onPressed();
      },
    );
  }
}
