import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:test1/db/database_provider.dart';
import 'package:test1/model/note_model.dart';

class ShowNote extends StatelessWidget {
  const ShowNote({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NoteModel note = ModalRoute.of(context).settings.arguments as NoteModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Note"),
        actions: [
          IconButton(icon: Icon(Icons.delete),onPressed: (){
            DatabaseProvider.db.deleteNote(note.id);
            Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
          },)
        ],
      ),
      body: Column(
        children: [
          Text(
            note.title,
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
          SizedBox(height: 16.0,),
          Text(
            note.body,
            style: TextStyle(fontSize: 18.0),
          )
        ],
        ),
    );
  }
}