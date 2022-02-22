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
  String menu = 's';

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
            Map<String,dynamic> data = snapshot.data?.data() as Map<String,dynamic>;
            if(data.containsKey('admin')) return Center(
              child: Row(
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
                    child: Padding(
                        padding: EdgeInsets.only(left: 50,right:50),
                        child: ListView(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 50)),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("${snapshot.data?.get('fname')} ${snapshot.data?.get('lname')}",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('STD: ${snapshot.data?.get('std')}     DIV: ${snapshot.data?.get('div')}',textAlign: TextAlign.center),
                            Padding(padding: EdgeInsets.only(top: 50)),
                            TextButton(
                              child: Text("Attendance"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              onPressed: (){
                                setState(() {
                                  menu = 'aa';
                                });
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                            TextButton(
                              child: Text("Results"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              onPressed: (){
                                setState(() {
                                  menu = 'ar';
                                });
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                            TextButton(
                              child: Text("Logout"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: () async{
                                await FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:20),
                  ),
                  SubSection(option: menu,),
                ],
              )
            );

            else return Center(
              child: Row(
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
                    child: Padding(
                        padding: EdgeInsets.only(left: 50,right:50),
                        child: ListView(
                          children: [
                            Padding(padding: EdgeInsets.only(top: 50)),
                            Container(
                              height: 300,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("${snapshot.data?.get('fname')} ${snapshot.data?.get('mname')} ${snapshot.data?.get('lname')}",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('STD: ${snapshot.data?.get('std')}     DIV: ${snapshot.data?.get('div')}     Roll No:${snapshot.data?.get('roll no')}',textAlign: TextAlign.center),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('DOB: ${snapshot.data?.get('dob').toString()}',textAlign: TextAlign.center,),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('Address: ${snapshot.data?.get('address').toString()}',textAlign: TextAlign.center,),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('City: ${snapshot.data?.get('city').toString()}',textAlign: TextAlign.center,),
                            Padding(padding: EdgeInsets.only(top: 50)),
                            TextButton(
                              child: Text("Fee Details"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              onPressed: (){
                                setState(() {
                                  menu = 'f';
                                });
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                            TextButton(
                              child: Text("Attendance"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
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
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
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
                            TextButton(
                              child: Text("Logout"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  foregroundColor: MaterialStateProperty.all(Colors.red)
                              ),
                              onPressed: () async{
                                await FirebaseAuth.instance.signOut();
                                Navigator.pop(context);
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                          ],
                        )
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left:20),
                  ),
                  SubSection(option: menu,),
                ],
              )
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
      child: widget.option=='s'?

          // EMPTY PAGE

     Container(
            height: 510,
            // width: MediaQuery.of(context).size.width/1.65,
            // color: Colors.orange,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage('dashboard.jpg',),
                fit: BoxFit.fill
              )
            ),
      ):

          // FEE DETAILS

      widget.option=='f'?Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData)
                return ListView(
                  children: [
                    ListTile(
                      title: Text('First Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Second Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Third Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Fourth Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Fifth Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Sixth Installment'),
                      trailing: Text("5000/-"),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(50),
                    ),
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 6
                      ),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text("Total", textAlign: TextAlign.center,style: TextStyle(fontSize:25),),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${snapshot.data?.get('fees')}/-", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("Installments Paid", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${snapshot.data?.get('paid')}", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("Installments pending", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${6-snapshot.data?.get('paid')}", textAlign: TextAlign.center,style: TextStyle(fontSize:25))
                      ],
                    )
                  ],
                );
              else return Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  )
              );
            }
      )
      ):

          // ATTENDANCE DETAILS

      widget.option=='a'?Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasData){
                List<DateTime> holidays = [];
                for(var date in snapshot.data?.get('holidays')) holidays.add(DateTime.fromMillisecondsSinceEpoch(date.seconds*1000));
                Duration diff = DateTime.now().difference(DateTime(2021,7,1));
                double percentage = (diff.inDays-holidays.length)*100/diff.inDays;
                return ListView(
                  children: [
                    TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(2021,7),
                      lastDay: DateTime.now(),

                      eventLoader: (day){
                        if(holidays.contains(day.toLocal())) return [1];
                        else return [];
                      },
                    ),
                    Padding(padding: EdgeInsets.only(top: 100),),
                    Stack(
                      children: [
                        Container(
                          height: 49.9,
                          width: (MediaQuery.of(context).size.width/1.65-100),
                          color: Colors.black,
                        ),
                        Container(
                          height: 50,
                          width: percentage*(MediaQuery.of(context).size.width/1.65-100.1)/100,
                          color: Colors.green,
                          child: Center(
                            child: Text("${percentage.toString().substring(0,4)}%",style: TextStyle(color: Colors.white,fontSize: 25),)
                          )
                        )
                      ],
                    ),
                    Padding(padding: EdgeInsets.only(top: 50)),
                    GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 6
                      ),
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        Text("Total Working days", textAlign: TextAlign.center,style: TextStyle(fontSize:25),),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${diff.inDays}", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("Present", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${diff.inDays-holidays.length}", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("Absent", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text(":", textAlign: TextAlign.center,style: TextStyle(fontSize:25)),
                        Text("${holidays.length}", textAlign: TextAlign.center,style: TextStyle(fontSize:25))
                      ],
                    ),
                  ],
                );
              }
              else return Center(
                  child: CircularProgressIndicator()
              );
            }
            )
      ):

          // RESULT DETAILS

      widget.option=='aa'?Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('creds').get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              List<Map<String, dynamic>> students = snapshot.data?.docs as List<Map<String, dynamic>>;
              students.removeWhere((element) => element.keys.singleWhere((element) => element == 'admin') == 'admin');
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 5
                  ),
                  itemBuilder: (context, index){
                    return Card(
                      child: Text(students[index].entries.singleWhere((element) => element.key=='fname').value),
                    );
                  }
              );
            }
            else return Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ):
          widget.option=='ar'?Padding(
            padding: EdgeInsets.all(50),
            child: ListView(
              children: [

              ],
            ),
          ):
              Container()
    );
  }
}
