import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<dynamic> _data = [
    {
      "name": "Chrome",
      "percentage": 40,
    },
    {
      "name": "FireFox",
      "percentage": 25,
    },
    {
      "name": "Safari",
      "percentage": 5,
    },
    {
      "name": "Others",
      "percentage": 30,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final items = _data
        .asMap()
        .map((index, item) => MapEntry(
              index,
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                child: Text(
                  '${item["name"]} ${item["percentage"]}%',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ))
        .values
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo'),
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: items,
            ),
          ),
          Container(
            height: 150,
            width: 300,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Stack(
              children: [
                Container(
                  width: 300,
                  height: 150,
                  color: Colors.grey,
                ),
                Container(
                  width: 300 * (_data[_selectedIndex]["percentage"] / 100)
                      as double,
                  height: 150,
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
