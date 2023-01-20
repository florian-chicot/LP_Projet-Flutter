import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../Model/country.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

import 'countryDetail.dart';

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

class Region extends StatefulWidget {
  final String searchValueRegion;
  Region(this.searchValueRegion);

  @override
  State<Region> createState() => _RegionState();
}

class _RegionState extends State<Region> {
  late Future<List<Country>> _countries;

  @override
  void initState() {
    super.initState();
    _countries = fetchCountries(widget.searchValueRegion);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries from '+widget.searchValueRegion),
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
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
