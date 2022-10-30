import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:test_shop/Widgets/text_widget.dart';

import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController();
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                RichText(
                  text: TextSpan(
                      text: "Hi,   ",
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
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              }),
                      ]),
                ),
                TextWidget(text: 'Email@email.com', color: color, textSize: 18),
                const SizedBox(height: 20),
                const Divider(thickness: 2),
                _listTiles(
                    title: 'Address 2',
                    subtitle: 'My subtitle',
                    icon: IconlyLight.profile,
                    color: color,
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Update Address'),
                              content: TextField(maxLines: 5,
                              decoration: const InputDecoration(hintText: 'Your new address'),
                              controller: _addressTextController,),
                              actions: [
                                TextButton(onPressed: () {}, child: const Text('Update'))
                              ],
                            );
                          });
                    }),
                _listTiles(
                    title: 'Orders',
                    icon: IconlyLight.bag,
                    color: color,
                    onPressed: () {}),
                _listTiles(
                    title: 'Wishlist',
                    icon: IconlyLight.heart,
                    color: color,
                    onPressed: () {}),
                _listTiles(
                    title: 'Viewed Items',
                    icon: IconlyLight.show,
                    color: color,
                    onPressed: () {}),
                _listTiles(
                    title: 'Forgot Password',
                    icon: IconlyLight.unlock,
                    color: color,
                    onPressed: () {}),
                SwitchListTile(
                  title: Text('Theme',
                      style: TextStyle(fontSize: 24, color: color)),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    themeState.setDarkTheme = value;
                  },
                  value: themeState.getDarkTheme,
                ),
                _listTiles(
                    title: 'Log Out',
                    icon: IconlyLight.logout,
                    color: color,
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTiles(
      {required String title,
      String? subtitle,
      required IconData icon,
      required Function onPressed,
      required Color color}) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 24,
      ),
      subtitle: TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
    );
  }
}
