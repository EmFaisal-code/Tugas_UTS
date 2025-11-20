import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  TextEditingController titleC = TextEditingController();
  TextEditingController contentC = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Catatan")),
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
            const SizedBox(height: 12),
            ElevatedButton(
              child: Text(
                selectedDate == null
                    ? "Pilih Tanggal"
                    : "Tanggal: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );

                if (picked != null) {
                  setState(() {
                    selectedDate = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Simpan"),
              onPressed: () {
                if (titleC.text.isEmpty ||
                    contentC.text.isEmpty ||
                    selectedDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Semua field wajib diisi!"),
                    ),
                  );
                  return;
                }

                Navigator.pop(context, {
                  "title": titleC.text,
                  "content": contentC.text,
                  "date":
                      "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
