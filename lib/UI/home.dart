import 'package:flutter/material.dart';
import 'package:projet_flutter/UI/aboutUs.dart';
import 'package:projet_flutter/UI/search.dart';

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
                const Text("Select the continent you want to see all their countries : ",
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search(searchValueRegion: _searchValueRegion, searchValueCountry: _searchValueCountry)),
                    ).then((value) {
                      _controller.clear();
                      _searchValueRegion = items[0];
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TextFormField(
                    onChanged: (value) {
                      _searchValueCountry = value;
                    },
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Search Countries',
                    ),
                  ),
                ),
                ElevatedButton(
                  child: const Text('Search'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Search(searchValueRegion: _searchValueRegion, searchValueCountry: _searchValueCountry)),
                    ).then((value) {
                      _controller.clear();
                      _searchValueRegion = items[0];
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