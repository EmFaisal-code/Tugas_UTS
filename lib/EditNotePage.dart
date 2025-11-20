import 'package:flutter/material.dart';

class EditNotePage extends StatefulWidget {
  final Map note;

  EditNotePage({required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late TextEditingController titleC;
  late TextEditingController contentC;

  @override
  void initState() {
    super.initState();
    titleC = TextEditingController(text: widget.note["title"]);
    contentC = TextEditingController(text: widget.note["content"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Catatan")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleC,
              decoration: const InputDecoration(labelText: "Judul"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: contentC,
              maxLines: 5,
              decoration: const InputDecoration(labelText: "Isi Catatan"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                Navigator.pop(context, {
                  "title": titleC.text,
                  "content": contentC.text,
                  "date": widget.note["date"],
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
