import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';

import '../Model/country.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountries() async {
  final response = await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    //return List<Country>.fromJson(jsonDecode(response.body));
    List<dynamic> countriesJson = json.decode(response.body);
    List<Country> countries = countriesJson.map((c) => Country.fromJson(c)).toList();
    return countries;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load countries');
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future<List<Country>> futureCountries;

  @override
  void initState() {
    super.initState();
    futureCountries= fetchCountries();
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
        child: FutureBuilder<List<Country>>(
          future: futureCountries,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child:
                    ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].officialName),
                      //subtitle: Text(snapshot.data![index].frenchName), //debug
                      //subtitle: Text(snapshot.data![index].flag), //debug
                      //subtitle: Text(snapshot.data![index].population), //debug
                    ),
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