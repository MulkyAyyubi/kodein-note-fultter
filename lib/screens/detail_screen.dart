import 'package:flutter/material.dart';
import 'package:tugas_akhir_semester1/model/notes_model.dart';
import 'package:tugas_akhir_semester1/screens/update_note_screen.dart';
import 'package:tugas_akhir_semester1/service/note_service.dart';
import 'package:tugas_akhir_semester1/utils/date_util.dart';

class DetailScreen extends StatefulWidget {
  final Note note;

  const DetailScreen({super.key, required this.note});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final NoteService _noteService = NoteService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // <-- Kembali ke screen sebelumnya
          },
          icon: Icon(Icons.arrow_back, color: Colors.deepOrange),
        ),
        title: const Text(
          "Note Details",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/${widget.note.image}', // Menampilkan Gambar Catatan
                  fit: BoxFit.cover,
                  height: 100,
                  width: double.infinity,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.note.title, // Menampilkan Judul Catatan
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                formatDateTime(
                    widget.note.dateTime), // Menggunakan fungsi format lokal
                style: TextStyle(
                    fontSize: 14, color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 10),
              Text(
                widget.note.content, // Menampilkan Konten Catatan
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateNoteScreen(note: widget.note),
                    ),
                  );

                  if (result == true) {
                    Navigator.pop(context,
                        true); // kirim sinyal ke HomeScreen untuk refresh
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  // Tampilkan dialog konfirmasi
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text('Delete Note'),
                      content: const Text(
                          'Are you sure you want to delete this note?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Delete',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  // Jika pengguna memilih delete
                  if (confirm == true) {
                    await _noteService
                        .deleteNote(widget.note.id!); // hapus dari SQLite
                    Navigator.pop(context,
                        true); // kirim sinyal ke HomeScreen untuk refresh
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
