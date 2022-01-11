import 'package:flutter/material.dart';
import 'package:test1/db/database_provider.dart';
import 'package:test1/model/note_model.dart';
import 'package:test1/screen/add_note.dart';
import 'package:test1/screen/display_note.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //menggunakan routes untuk berpindah antara layar
      initialRoute: "/",
      routes: {
        "/" : (context) => HomeSreen(),
        "/AddNote": (context) => AddNote(),
        "/ShowNote": (context) => ShowNote(),
      },
    );
  }
}

class HomeSreen extends StatefulWidget {

  @override
  _HomeSreenState createState() => _HomeSreenState();
}

class _HomeSreenState extends State<HomeSreen> {
  //mengambil data dari notes
  getNotes() async{
    final notes = await DatabaseProvider.db.getNotes();
    return notes;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //membuat future build untuk menampilkan elemen
      appBar: AppBar(
        title: Text("Your Notes"),
      ),
      body: FutureBuilder(
        future: getNotes(),
        builder: (context, noteData){
          switch(noteData.connectionState){
            case ConnectionState.waiting : 
            {
              return Center(child: CircularProgressIndicator());
            }
            case ConnectionState.done:
            {
              if(noteData.data == Null){
                return Center(child: Text("Kamu belum memiliki notes"),);
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: noteData.data.length,
                    itemBuilder: (context, index){
                      String title = noteData.data[index]['title'];
                      String body = noteData.data[index]['body'];
                      String creation_date = noteData.data[index]['creation_date'];
                      int id = noteData.data[index]['id'];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            
                            Navigator.pushNamed(context, "/ShowNote", 
                            arguments: 
                              NoteModel(
                                title: title,
                                body: body,
                                creation_date: DateTime.parse(creation_date),
                                id: id
                            ));
                          },
                          title: Text(title),
                          subtitle: Text(body),
                        ),
                      );
                    },
                  ),
                );
              }
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/AddNote");
        },
        child: Icon(Icons.note_add),
      ),
    );
  }
}
