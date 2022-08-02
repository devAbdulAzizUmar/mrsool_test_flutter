import 'package:flutter/material.dart';

import 'package:mrsool_test/main.dart';

import '../lang/app_localization.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late bool isLocaleEnglish;
  late AppLocalizations _appLocalizations;

  @override
  Widget build(BuildContext context) {
    _appLocalizations = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context);
    isLocaleEnglish = Localizations.localeOf(context).languageCode == "en";

    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.padding.top,
          bottom: mediaQuery.padding.bottom,
          left: mediaQuery.padding.left,
          right: mediaQuery.padding.right,
        ),
        child: Column(
          children: [
            buildLanguageSwitch(),
          ],
        ),
      ),
    );
  }

  Widget buildLanguageSwitch() {
    final localizations = AppLocalizations.of(context)!;
    return Card(
      elevation: 0,
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(minHeight: 54),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.blue.shade200,
          ),
        ),
        child: ListTile(
          trailing: FittedBox(
            child: Row(
              children: [
                Text(
                  _appLocalizations.ar ?? "Arabic",
                ),
                Switch(
                  inactiveThumbColor: Colors.blue,
                  activeColor: Colors.blue,
                  inactiveTrackColor: MaterialStateColor.resolveWith((states) => Colors.grey),
                  activeTrackColor: MaterialStateColor.resolveWith((states) => Colors.grey),
                  value: isLocaleEnglish,
                  onChanged: (value) {
                    setLanguage(context, value);
                  },
                ),
                Text(
                  _appLocalizations.en ?? "English",
                ),
              ],
            ),
          ),
          title: Text(
            localizations.language ?? "Language",
          ),
        ),
      ),
    );
  }

  void setLanguage(context, isEnglish) {
    final Locale locale = isEnglish ? const Locale("en", "") : const Locale("ar", "");
    MrsoolAcceptApp.setLocale(context, locale);
  }
}
