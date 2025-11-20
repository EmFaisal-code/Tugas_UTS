import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'add_note_page.dart';
import 'detail_note_page.dart';

class HomePage extends StatefulWidget {
  final bool isDark;
  final Function(bool) onThemeChange;

  HomePage({required this.isDark, required this.onThemeChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List notes = [];

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  void loadNotes() async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString("notes");

    if (data != null) {
      setState(() {
        notes = jsonDecode(data);
      });
    }
  }

  void saveNotes() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("notes", jsonEncode(notes));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MyNotes+"),
        actions: [
          Switch(
            value: widget.isDark,
            onChanged: (value) => widget.onThemeChange(value),
          )
        ],
      ),
      body: notes.isEmpty
          ? const Center(child: Text("Belum ada catatan"))
          : ListView.builder(
              itemCount: notes.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(notes[index]["title"]),
                  subtitle: Text(notes[index]["date"]),
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailNotePage(note: notes[index], index: index),
                      ),
                    );

                    if (result == "delete") {
                      setState(() {
                        notes.removeAt(index);
                      });
                      saveNotes();
                    } else if (result != null) {
                      setState(() {
                        notes[index] = result;
                      });
                      saveNotes();
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final newNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddNotePage()),
          );

          if (newNote != null) {
            setState(() {
              notes.add(newNote);
            });
            saveNotes();
          }
        },
      ),
    );
  }
}
