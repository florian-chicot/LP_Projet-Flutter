import 'package:flutter/material.dart';

import '../Model/country.dart';

class CountryDetail extends StatefulWidget {
  late final Country country;
  CountryDetail(this.country);

  @override
  State<CountryDetail> createState() => _CountryDetailState(country);
}

class _CountryDetailState extends State<CountryDetail> {
  final Country country;

  _CountryDetailState(this.country);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
      ),
      body: Row(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(country.flag),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text("Name: ${country.name}"),
                  Text("Official Name: ${country.officialName}"),
                  // other information
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}