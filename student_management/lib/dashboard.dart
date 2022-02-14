import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_web/cloud_firestore_web.dart';

import 'main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardState();
}

class DashboardState extends State<Dashboard>{
  String menu = 'sd';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6816),
        toolbarHeight: 80,
        elevation: 20,
        title: const Text("NIRMALA HIGH SCHOOL",style: TextStyle(fontFamily: 'Merriweather',color: Colors.white,)),
        titleSpacing: MediaQuery.of(context).size.width/10,
        actions: [
          MenuButton(title: 'HOME',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: (){},
          ),
          MenuButton(title: 'PAGES',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: (){},
          ),
          MenuButton(title: 'COURSES',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: (){},
          ),
          MenuButton(title: 'CONTACT',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: (){},
          ),
          Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/10))
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Padding(padding: EdgeInsets.only(top: 5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/5,
                      height: MediaQuery.of(context).size.height/1.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey[200],
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
                          ]
                      ),
                      child: ListView(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 100)),
                          Container(
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 50)),
                          Text("${snapshot.data?.get('fname')} ${snapshot.data?.get('mname')} ${snapshot.data?.get('lname')}",textAlign: TextAlign.center,),
                          Padding(padding: EdgeInsets.only(top: 50)),
                          TextButton(
                            child: Text("Student Details"),
                            onPressed: (){
                              setState(() {
                                menu = 'sd';
                              });
                            },
                          ),

                          Divider(
                            indent: 40,
                            endIndent: 40,
                          ),
                          TextButton(
                            child: Text("Fee Details"),
                            onPressed: (){
                              setState(() {
                                menu = 'fd';
                              });
                            },
                          ),
                          Divider(
                            indent: 40,
                            endIndent: 40,
                          ),
                          TextButton(
                            child: Text("Attendance"),
                            onPressed: (){
                              setState(() {
                                menu = 'a';
                              });
                            },
                          ),
                          Divider(
                            indent: 40,
                            endIndent: 40,
                          ),
                          TextButton(
                            child: Text("Results"),
                            onPressed: (){
                              setState(() {
                                menu = 'r';
                              });
                            },
                          ),
                          Divider(
                            indent: 40,
                            endIndent: 40,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left:20),
                    ),
                    SubSection(option: menu,),
                  ],
                )
              ],
            );
          }
          else return Center(
            child: CircularProgressIndicator()
          );
        },
      )

    );
  }
}

class SubSection extends StatefulWidget {
  const SubSection({Key? key, required this.option}) : super(key: key);
  final String option;

  @override
  _SubSectionState createState() => _SubSectionState();
}

class _SubSectionState extends State<SubSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width/1.65,
      height: MediaQuery.of(context).size.height/1.2,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.grey[200],
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
          ]
      ),
      child: widget.option=='sd'?
      FutureBuilder(
        future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Name: ${snapshot.data?.get('fname')} ${snapshot.data?.get('mname')} ${snapshot.data?.get('lname')}'),
                    Text('')
                  ],
                )
              ],
            );
          }
          else return Center(
              child: CircularProgressIndicator()
          );
      }
    ):
      Container(

      )
    );
  }
}

