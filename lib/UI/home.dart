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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  child: TextFormField(
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
                      MaterialPageRoute(builder: (context) => const Search()),
                    ).then((value) {
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}