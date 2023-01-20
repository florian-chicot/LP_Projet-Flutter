import 'package:flutter/material.dart';
import 'package:projet_flutter/UI/aboutUs.dart';

import 'dart:async';
import 'dart:convert';

import '../Model/country.dart';
import 'package:http/http.dart' as http;

import 'countryDetail.dart';
import 'home.dart';

class Region extends StatefulWidget {
  final String searchValueRegion;
  const Region(this.searchValueRegion, {super.key});

  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
  late Future<List<Country>> _countries;

  Future<List<Country>> fetchCountries(String searchValueRegion) async {
    final response = await http.get(Uri.parse('https://restcountries.com/v3.1/region/${Uri.encodeFull(searchValueRegion)}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      List<dynamic> countriesJson = json.decode(response.body);
      List<Country> countries = countriesJson.map((c) => Country.fromJson(c)).toList();
      return countries;
    }else {
      throw Exception('Failed to load countries. Error code: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _countries = fetchCountries(widget.searchValueRegion);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchValueRegion),
        centerTitle: true,
        backgroundColor: Colors.black54
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black54,
        child: SizedBox(
          height: 50.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right:8), //apply padding horizontal or vertical only
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const App()),
                        );
                      },
                      child: const Text('Home'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:8), //apply padding horizontal or vertical only
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AboutUs()),
                        );
                      },
                      child: const Text('Home'),
                    ),
                  ),
                ],
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
      body: FutureBuilder<List<Country>>(
        future: _countries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final country = snapshot.data![index];
                return ListTile(
                  title: Text(country.name),
                  subtitle: Text(country.region),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(country.flag),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountryDetail(country),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
