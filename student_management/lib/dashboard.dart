import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_left),
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: Center(
        child: TextButton(
          child: Text("Logout"),
          onPressed: () async{
            await FirebaseAuth.instance.signOut();
            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          },
        )
      )
    );
  }
}
