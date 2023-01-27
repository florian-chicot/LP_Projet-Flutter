import 'package:flutter/material.dart';

import 'home.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
        centerTitle: true,
        backgroundColor: Colors.black54,
      ),
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black54,
        child: SizedBox(
          height: 50.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('Home'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const App()),
                  );
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("../assets/images/logo.png",
              height: 400,
            ),
            const Text("Okayyy Let's go",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50
              ),
            ),
          ],
        ),
      ),
    );
  }
}
