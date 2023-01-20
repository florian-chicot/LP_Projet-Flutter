import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../Model/country.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

Future<List<Country>> fetchCountries(String searchValueCountry, String searchValueRegion) async {
  String region = searchValueRegion;
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/region/$region'));
  String pays = searchValueCountry;
  final response2 = await http.get(Uri.parse('https://restcountries.com/v3.1/name/$pays'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List<dynamic> countriesByRegionJson = json.decode(response.body);
    List<Country> countries = countriesByRegionJson.map((c) => Country.fromJson(c)).toList();
    region = '';
    return countries;
  } else if (response2.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List<dynamic> countriesJson = json.decode(response2.body);
    List<Country> countries = countriesJson.map((c) => Country.fromJson(c)).toList();
    pays = '';
    return countries;
  }else{
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load countries');
  }
}

class Search extends StatefulWidget {
  final String searchValueCountry;
  final String searchValueRegion;
  const Search({Key? key, required this.searchValueCountry, required this.searchValueRegion}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries= fetchCountries(widget.searchValueCountry, widget.searchValueRegion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Countries"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: FutureBuilder<List<Country>>(
          future: futureCountries,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return Card(
                      child: SvgPicture.network(snapshot.data![index].flag)
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}