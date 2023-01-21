import 'package:flutter/material.dart';

import '../Model/country.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryDetail extends StatefulWidget {
  final Country country;
  const CountryDetail(this.country, {super.key});

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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(2),
              child: Column(
                children: <Widget>[
                  SvgPicture.network(
                    country.flag,
                    width: MediaQuery.of(context).size.width,
                  ),
                  Text(country.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  const Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Official name",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.officialName,
                      style: const TextStyle(fontSize: 16)),
                  const Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Name in French",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.frenchName,
                      style: const TextStyle(fontSize: 16)),
                  const Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Continent",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.region,
                      style: const TextStyle(fontSize: 16)),
                  const Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text("Population",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.population.toString()+" inhabitants",
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text(country.capital.length == 1 ? "Capital city" : "Capital cities",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.capital.join(', '),
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text(country.languages.length == 1 ? "Official language" : "Official languages",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.languages.join(', '),
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text(country.currencies.length == 1 ? "Currency" : "Currencies",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.currencies.join(', '),
                      style: const TextStyle(fontSize: 16)),
                  Padding(
                    padding: EdgeInsets.only(top:16), //apply padding horizontal or vertical only
                    child: Text(country.topLevelDomains.length == 1 ? "Top-level domain" : "Top-level domains",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  Text(country.topLevelDomains.join(', '),
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}