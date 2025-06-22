import 'package:flutter/material.dart';
import 'package:tugas_akhir_semester1/model/notes_model.dart';
import 'package:tugas_akhir_semester1/screens/add_note_screen.dart';
import 'package:tugas_akhir_semester1/screens/detail_screen.dart';
import 'package:tugas_akhir_semester1/service/note_service.dart';
import 'package:tugas_akhir_semester1/widgets/empty_data_widget.dart';
import 'package:tugas_akhir_semester1/widgets/note_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NoteService _noteService =
      NoteService(); // instance untuk akses database

  List<Note> notesList = []; // daftar catatan yang akan ditampilkan

  @override
  void initState() {
    super.initState();
    _loadNotes(); // ambil data dari database saat layar pertama kali ditampilkan
  }

  void _loadNotes() async {
    final data =
        await _noteService.getAllNotes(); // ambil semua catatan dari database
    setState(() {
      notesList = data; // simpan hasil ke dalam notesList agar ditampilkan
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset("assets/images/logo.png", width: 28, height: 28),
            const SizedBox(width: 8),
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Kodein ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: "Notes",
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: notesList.isEmpty
          ? const EmptyDataWidget()
          : ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                final Note note = notesList[index];

                return NoteItemWidget(
                  note: note,
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(note: note),
                      ),
                    );

                    if (result == true) {
                      _loadNotes(); // refresh data dari database
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );

          if (result == true) {
            _loadNotes(); // refresh data dari database
          }
        },
        backgroundColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
