import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../themes.dart';
import '../user_preferences.dart';

AppBar buildAppBar(BuildContext context, String text) {
  final user = UserPreferences.getUser();

  return AppBar(
    leading: BackButton(),
    backgroundColor: Colors.green,
    title: Text(text),
    elevation: 0,
    // actions: [
    //   ThemeSwitcher(
    //     builder: (context) => IconButton(
    //       icon: Icon(icon),
    //       onPressed: () {
    //         final theme = isDarkMode ? MyThemes.lightTheme : MyThemes.darkTheme;

    //         final switcher = ThemeSwitcher.of(context)!;
    //         switcher.changeTheme(theme: theme);

    //         final newUser = user.copy(isDarkMode: !isDarkMode);
    //         UserPreferences.setUser(newUser);
    //       },
    //     ),
    //   ),
    // ],
  );
}
