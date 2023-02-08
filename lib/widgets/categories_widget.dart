import 'package:flutter/material.dart';
import 'package:groceryapp/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:groceryapp/widgets/text_widget.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.imgPath,
      required this.passedcolor})
      : super(key: key);

  final String catText, imgPath;
  final Color passedcolor;

  @override
  Widget build(BuildContext context) {
    //Size size =MediaQuery.of(context).size;
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {
        print('Category pressed');
      },
      child: Container(
        // height: _screenWidth * 0.3, we use gridview
        decoration: BoxDecoration(
          color: passedcolor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: passedcolor.withOpacity(0.7),
            width: 8,
          ),
        ),
        child: Column(
          children: [
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      imgPath,
                    ),
                    fit: BoxFit.fill),
              ),
            ),
            TextWidget(
              text: catText,
              textSize: 20,
              color: color,
              isTitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
