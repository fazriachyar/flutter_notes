import 'package:flutter/material.dart';
import 'package:test1/db/database_provider.dart';
import 'package:test1/model/note_model.dart';

class AddNote extends StatefulWidget {
  const AddNote({ Key key }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  //membuat fungsi add_note
  String title;
  String body;
  DateTime date;
  //membuat input controller
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  AddNote(NoteModel note){
    DatabaseProvider.db.addNewNote(note);
    print("Catatan berhasil ditambahkan!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambahkan catatan"),
      ),
      body: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Note Title",
            ),
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: TextField(
              controller: bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "ceritakan kisahmu disini..."
              ),
          ))
        ],)
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          setState(() {
            title = titleController.text;
            body = bodyController.text;
            date = DateTime.now();
          });
          NoteModel note =
                NoteModel(title: title, body: body, creation_date: date);
                AddNote(note);
                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
          label: Text("Simpan"),
          icon: Icon(Icons.save),
      ),
    );
  }
}