import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6816),
      ),
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width/1.2,
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width/5,
                    color: Colors.lightBlueAccent
                ),
                Padding(
                  padding: EdgeInsets.only(left:20),
                ),
                Container(
                    width: MediaQuery.of(context).size.width/1.65,
                    color: Colors.black
                ),
              ],
            )
        )
      )
    );
  }
}
