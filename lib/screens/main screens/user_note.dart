import 'package:flutter/material.dart';
import 'package:mobile_app/screens/note%20screens/note_screen.dart';

class UserNote extends StatefulWidget {
  const UserNote({super.key});

  @override
  State<UserNote> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<UserNote> {
  @override
  Widget build(BuildContext context) {
    return const NotesScreen();
  }
}
