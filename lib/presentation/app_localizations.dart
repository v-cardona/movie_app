import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:movie_app/common/constants/languages.dart';

class AppLocalizations {

  final Locale locale;
  Map<String, String> _localizedStrings;

  AppLocalizations(this.locale);

  static const LocalizationsDelegate<AppLocalizations> delegate =
   _AppLocalizationDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }
   
  Future<bool> load() async {
    final String jsonString = await rootBundle
      .loadString('assets/languages/${locale.languageCode}.json');

    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {

  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return Languages.languages
      .map((e) => e.code)
      .toList()
      .contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
    false;
}