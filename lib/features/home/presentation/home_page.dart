import 'package:flutter/material.dart';
import '../../account/presentation/account_page.dart';
import '../../discover/presentation/discover_page.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _pages = [
    const DiscoverPage(),
    const Text("Search"),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: "Discover",
            icon: Icon(Icons.visibility),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "Account",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
