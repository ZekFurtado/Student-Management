import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

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

          //STUDENT DETAILS

      Column(
        children: [
          Container(
            height: 510,
            // width: MediaQuery.of(context).size.width/1.65,
            // color: Colors.orange,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage('dashboard.jpg',),
                fit: BoxFit.fill
              )
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 30)),
          FutureBuilder(
              future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData){
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                      childAspectRatio: 7.5
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(30),
                    shrinkWrap: true,
                    children: [
                      Text(
                            'Name: ${snapshot.data?.get('fname')} ${snapshot.data?.get('mname')} ${snapshot.data?.get('lname')}',
                            style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'Address: ${snapshot.data?.get('address')}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'STD: ${snapshot.data?.get('std')}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'DOB: ${snapshot.data?.get('dob').toString()}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'DIV: ${snapshot.data?.get('div').toString()}',
                        style: TextStyle(fontSize: 25),
                      ),
                      Text(
                        'City: ${snapshot.data?.get('city').toString()}',
                        style: TextStyle(fontSize: 25),
                      ),

                    ],
                  );
                }
                else return Center(
                    child: CircularProgressIndicator()
                );
              }
          )
        ],
      ):

          //FEE DETAILS

      widget.option=='fd'?Padding(
        padding: EdgeInsets.all(50),
        child: ListView(
          children: [
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),
            ListTile(
              title: Text('Tuition Fees'),
              trailing: Text("2700"),
            ),
            Divider(),

          ],
        )
      ):

          // ATTENDANCE DETAILS

      FutureBuilder(
        future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            List<DateTime> holidays = [];
            for(var date in snapshot.data?.get('holidays')) holidays.add(DateTime.fromMillisecondsSinceEpoch(date.seconds*1000));
            print(DateTime.fromMillisecondsSinceEpoch(snapshot.data?.get('holidays')[0].seconds*1000));
            return TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime(2019),
              lastDay: DateTime.now(),

              eventLoader: (day){
                if(holidays.contains(day.toLocal())) return [1];
                else return [];
              },
            );
          }
          else return Center(
              child: CircularProgressIndicator()
          );
          })
    )    ;
  }
}

