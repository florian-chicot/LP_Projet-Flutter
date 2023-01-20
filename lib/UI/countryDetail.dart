import 'package:flutter/material.dart';

import '../Model/country.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: Column(
        children: <Widget>[
          // SvgPicture.network(
          //   country.flag,
          //   width: MediaQuery.of(context).size.width,
          //
          // ),
          // Container(
          //   child:  SvgPicture.network(
          //     country.flag,
          //     width: MediaQuery.of(context).size.width,
          //   ),
          // ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  SvgPicture.network(
                    country.flag,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text("${country.name}",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Official name",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text("${country.officialName}",
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Name in French",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text("${country.frenchName}",
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Continent",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text("${country.region}",
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Population",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text("${country.population.toString()} inhabitants",
                      style: const TextStyle(fontSize: 16)),
                  // TODO other information
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}