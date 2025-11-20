import 'package:flutter/material.dart';
import 'EditNotePage.dart';

class DetailNotePage extends StatelessWidget {
  final Map note;
  final int index;

  DetailNotePage({required this.note, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Catatan"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Konfirmasi"),
                  content: const Text("Apakah Anda yakin ingin menghapus catatan ini?"),
                  actions: [
                    TextButton(
                      child: const Text("Batal"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    TextButton(
                      child: const Text("Hapus"),
                      onPressed: () => Navigator.pop(context, "delete"),
                    ),
                  ],
                ),
              ).then((value) {
                if (value == "delete") {
                  Navigator.pop(context, "delete");
                }
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note["title"],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              note["date"],
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              note["content"],
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () async {
          final updatedNote = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => EditNotePage(note: note)),
          );

          if (updatedNote != null) {
            Navigator.pop(context, updatedNote);
          }
        },
      ),
    );
  }
}
