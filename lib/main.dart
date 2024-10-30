
import 'package:flutter/material.dart';
import 'package:ServerMon/pages/home.dart';
import 'package:ServerMon/pages/logs.dart';


void main() {
  runApp(MaterialApp(
    home: const Main(),
    theme: ThemeData.from(colorScheme: const ColorScheme.dark(primary: Colors.blue)),
  ));
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  _main createState() => _main();
}

class _main extends State<Main> {
  int _selectedIndex = 0;
  static const List<Widget> _screens = <Widget>[
    HomePage(),
    LogPage(),
  ];
  static const List<String> _titles = ["Server Monitor","Logs"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(_titles[_selectedIndex]),
        backgroundColor: Colors.blueAccent,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(
        child: _screens[_selectedIndex],
      ),
      drawer: Drawer(
      surfaceTintColor: Colors.blue,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              selected: _selectedIndex == 0,
              selectedColor: Colors.blue,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logs'),
              leading: const Icon(Icons.receipt_long),
              selected: _selectedIndex == 1,
              selectedColor: Colors.blue,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
