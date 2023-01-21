import 'dart:convert';

class Country {
  final String name;
  final String frenchName;
  final String officialName;
  final String flag;
  final List<String> capital;
  final String region;
  final List<String> languages;
  final List<String> currencies;
  final int population;
  final List<String> topLevelDomains;

  const Country({
    required this.name,
    required this.frenchName,
    required this.officialName,
    required this.flag,
    required this.capital,
    required this.region,
    required this.languages,
    required this.currencies,
    required this.population,
    required this.topLevelDomains
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: utf8.decode(json['name']['common'].codeUnits),
      frenchName: utf8.decode(json['translations']['fra']['common'].codeUnits),
      officialName: utf8.decode(json['name']['official'].codeUnits),
      flag: json['flags']['png'],
      capital: List<String>.from(json['capital']?.map((capital) => utf8.decode(capital.codeUnits)) ?? ["No capital city"]),
      region: json['region'],
      languages: json['languages'] != null ? List<String>.from(json['languages'].values.toList()) : ["No official language"],
      currencies: json['currencies'] != null ? List<String>.from(json['currencies'].values.map((currency) => utf8.decode(currency['name'].codeUnits))) : ["No currency"],
      population: json['population'],
      topLevelDomains: List<String>.from(json['tld']?.map((tld) => tld) ?? ["No top-level domain"]),
    );
  }
}