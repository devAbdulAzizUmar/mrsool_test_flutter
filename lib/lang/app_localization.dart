import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static Map<String, dynamic> localizedData = {};

  Future<bool> load() async {
    final jsonString = await rootBundle.loadString('lib/lang/${locale!.languageCode}.json');
    final Map<String, dynamic> mappedJson = jsonDecode(jsonString);
    localizedData = mappedJson;
    return true;
  }

  String? get all => localizedData['all'];
  String? get pending => localizedData['pending'];
  String? get accepted => localizedData['accepted'];
  String? get rejected => localizedData['rejected'];
  String? get timedOut => localizedData['time_out'];
  String? get en => localizedData['en'];
  String? get ar => localizedData['ar'];
  String? get language => localizedData['language'];
  String? get orderId => localizedData['orderId'];
  String? get date => localizedData['date'];
  String? get total => localizedData['total'];
  String? get status => localizedData['status'];
  String? get noOrders => localizedData['noOrders'];
  String? get sar => localizedData['sar'];
  String? get details => localizedData['details'];

  String? getLocalizedText(String key) => localizedData[key];

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);
    await appLocalizations.load();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate old) => false;
}
