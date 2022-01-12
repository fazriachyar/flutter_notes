import 'package:flutter/material.dart';

class about extends StatelessWidget {
  const about({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Me"),
        ),
      body: Column(
        children: [
          Align(
                alignment: Alignment.topCenter,
                child: Padding(padding: const EdgeInsets.all(30.0),
                  child: 
                  CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage('assets/myself.png'),
                  ),
                ),
              ),
          Text("CAHYAS SEPTIA",style: TextStyle(color: Colors.white),)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
        },
        child: Icon(Icons.arrow_back_rounded),
        
      ),
      );
  }
}