import 'package:flutter/material.dart';
import 'package:projet_flutter/UI/aboutUs.dart';
import 'package:projet_flutter/UI/search.dart';

import '../Model/country.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _typeAheadController = TextEditingController();
  List<String> _countryNames = [];
  late Future<List<String>> getCountryNames;

  Future<List<String>> _getCountryNames() async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<dynamic> countriesJson = json.decode(response.body);
      List<Country> countries = countriesJson.map((c) => Country.fromJson(c)).toList();
      List<String> _countryNames = countries.map((c) => c.name).toList();
      return _countryNames;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load countries');
    }
  }

  @override
  void initState() {
    super.initState();
    _getCountryNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: _typeAheadController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      _countryNames = await _getCountryNames();
                      return _countryNames.where((name) => name.toLowerCase().startsWith(pattern.toLowerCase())).toList();
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion),
                      );
                    },
                    onSuggestionSelected: (suggestion) {
                      _typeAheadController.text = suggestion;
                    },
                  ),
                ),
                ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Search()),
                    ).then((value) {
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('About Us'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                ).then((value) {
                  _controller.clear();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}