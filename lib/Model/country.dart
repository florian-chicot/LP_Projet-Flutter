import 'package:http/http.dart' as http;
import 'dart:convert';

/**
    TODO
    Display List<String>
    Change population type to int
 */

class Country {
  final String name;
  final String frenchName;
  final String officialName;
  final String flag;
  //final List<String> capital;
  //final List<String> continent;
  //final List<String> languages;
  //final bool independent;
  //final List<String> currencies;
  final String population;
  //final List<String> topLevelDomains;

  const Country({
    required this.name,
    required this.frenchName,
    required this.officialName,
    required this.flag,
    //required this.capital,
    //required this.continent,
    //required this.languages,
    //required this.independent,
    //required this.currencies,
    required this.population,
    //required this.topLevelDomains
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      frenchName: json['translations']['fra']['common'],
      officialName: json['name']['official'],
      flag: json['flags']['svg'],
      //capital: List<String>.from(json['capital'].map((currencies) => currencies['name'])),
      //continent: json['region'],
      //languages: List<String>.from(json['languages'].map((language) => language['name'])),
      //independent: json['independent'],
      //currencies: List<String>.from(json['currencies'].map((currencies) => currencies['name'])),
      population: json['population'].toString(),
      //topLevelDomains: json['tld'],
    );
  }
}