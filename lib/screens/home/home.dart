import 'package:flutter/material.dart';
import 'package:mobile_app/screens/main%20screens/user_note.dart';
import 'package:mobile_app/screens/main%20screens/university_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentState = 0;
  final List<Widget> _tabs = [
    const HomePage(),
    const UserNote(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentState],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentState,
        onTap: (index) {
          setState(() {
            _currentState = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'University List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todo List',
          ),
        ],
      ),
    );
  }
}
