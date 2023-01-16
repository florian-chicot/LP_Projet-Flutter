import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../Model/country.dart';
import 'package:http/http.dart' as http;

Future<Country> fetchCountry() async {
  final response = await http
      .get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Country.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<Country> futureCountry;

  @override
  void initState() {
    super.initState();
    futureCountry= fetchCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: FutureBuilder<Country>(
          future: futureCountry,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.frenchName);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}