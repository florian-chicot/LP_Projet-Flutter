import 'package:flutter/material.dart';
import 'package:projet_flutter/UI/countryDetail.dart';
import 'package:projet_flutter/UI/aboutUs.dart';
import 'package:projet_flutter/UI/region.dart';

import '../Model/country.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';

Future<List<Country>> fetchCountries(String searchValueCountry) async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/name/${Uri.encodeFull(searchValueCountry)}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List<dynamic> countriesJson = json.decode(response.body);
    List<Country> countries = countriesJson.map((c) => Country.fromJson(c)).toList();
    return countries;
  }else {
    throw Exception('Failed to load countries. Error code: ${response.statusCode}');
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController _controller = TextEditingController();
  String _searchValueCountry = '';

  // Initial Selected Value
  String _searchValueRegion = '...';

  // List of items in our dropdown menu
  var items = [
    '...',
    'Antarctic',
    'Africa',
    'Americas',
    'Europe',
    'Asia',
    'Oceania'
  ];

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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black54,
        child: SizedBox(
          height: 50.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              const Text("© Gurvan Buanic & Florian Chicot - 2023",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
                      Future<List<Country>> future = fetchCountries(_searchValueCountry);
                      future.then((data) {
                        Country country = data[0];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CountryDetail(country)),
                        ).then((value) {
                          _controller.clear();
                        });
                      });
                    }
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text("Select countries from ",
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
                DropdownButton(
                  // Initial Value
                  value: _searchValueRegion,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      _searchValueRegion = newValue!;
                    });
                  },
                ),
                ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () async {
                    final result =  await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Region(_searchValueRegion)),
                    ).then((value) {
                      _controller.clear();
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}