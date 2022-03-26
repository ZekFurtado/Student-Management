import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:student_management/updatestudent.dart';
import 'package:table_calendar/table_calendar.dart';

import 'main.dart';
import 'newstudent.dart';

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
          MenuButton(title: 'CONTACT',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: (){

            },
          ),
          FirebaseAuth.instance.currentUser?.displayName == 'Admin'?MenuButton(title: 'LOGOUT',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
            onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            },
          ):Container(),
          Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/10))
        ],
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if(snapshot.hasData){
            Map<String,dynamic> data = snapshot.data?.data() as Map<String,dynamic>;
            if(data.containsKey('tutor')) return Center(
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
                                // color: Colors.red,
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data?.get('image')
                                  )
                                )
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(top: 20)),
                            Text("${snapshot.data?.get('fname')} ${snapshot.data?.get('lname')}",textAlign: TextAlign.center,style: TextStyle(fontSize: 30),),
                            Padding(padding: EdgeInsets.only(top: 10)),
                            Text('STD: ${snapshot.data?.get('std')}     DIV: ${snapshot.data?.get('div')}',textAlign: TextAlign.center),
                            Padding(padding: EdgeInsets.only(top: 50)),
                            TextButton(
                              child: Text("Students"),
                              style: ButtonStyle(
                                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 20)),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffff6816)),
                                  foregroundColor: MaterialStateProperty.all(Colors.white)
                              ),
                              onPressed: (){
                                setState(() {
                                  menu = 'as';
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
                                  menu = 'aa';
                                });
                              },
                            ),
                            Divider(
                              indent: 40,
                              endIndent: 40,
                            ),
                            /*TextButton(
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
                            ),*/
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

            else if(data.containsKey('admin')) return Container(
              color: Colors.orange.withOpacity(0.3),
              child: Center(
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                            child: Container(
                              height: 300,
                                width: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
                                    ]
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewStudent()
                                      )
                                    );
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    )
                                    ),
                                  ),
                                  child: Text("New Student", style: TextStyle(fontSize: 23,color: Colors.black)),
                                )
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                                height: 300,
                                width: 600,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
                                    ]
                                ),
                                child: TextButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateStudent()
                                        )
                                    );
                                  },
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    )),
                                  ),
                                  child: Text("Update Student Data", style: TextStyle(fontSize: 23,color: Colors.black)),
                                )
                            ),
                          ),
                        ],
                      )
                  )
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
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data?.get('image')
                                    )
                                ),
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
                print(snapshot.data?.get('holidays').length);
                Duration diff = DateTime.now().difference(DateTime(2021, 7, 1));
                double percentage = 100;
                if (snapshot.data?.get('holidays').length!=0) {
                  for (var date in snapshot.data?.get('holidays')) holidays.add(DateTime.fromMillisecondsSinceEpoch(date.seconds * 1000));
                  percentage = (diff.inDays - holidays.length) * 100 / diff.inDays;
                }
                print("checkpoint");
                return ListView(
                  children: [
                    TableCalendar(
                      focusedDay: DateTime.now(),
                      firstDay: DateTime(2021,7),
                      lastDay: DateTime.now(),

                      eventLoader: (day){
                        print("entered");
                        if(holidays.contains(day.toLocal())) {
                          print("checkpoin1");
                          return [1];
                        }
                        else {
                          print("checkpoin2");
                          return [];
                        }
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

      widget.option=='r'?
      Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.hasData) return GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5
              ),
              children: [
                FutureBuilder(
                    future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                      if(snapshot.hasData) {
                        Map<String,dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
                        if(data.containsKey('sem1')) return Card(
                          child: Center(
                            child: Text('Sem 1 Report Card')
                          )
                        );
                        else return Card(
                          child: Center(
                            child: Text("Sem 1 N/A")
                          )
                        );
                      }
                      else return Center(
                          child: CircularProgressIndicator()
                      );
                    }
                  ),
                FutureBuilder(
                        future: FirebaseFirestore.instance.collection('creds').doc(FirebaseAuth.instance.currentUser?.uid).get(),
                        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                          if(snapshot.hasData) {
                            Map<String,dynamic> data = snapshot.data?.data() as Map<String, dynamic>;
                            if(data.containsKey('sem1')) return Card(
                              child: Center(
                                child: Text('Sem 2 Report Card')
                              )
                            );
                            else return Card(
                                child: Center(
                                  child: Text("Sem 2 N/A")
                                )
                            );
                          }
                          else return Center(
                              child: CircularProgressIndicator()
                          );
                        }
                    )
              ],
            );
            else return Center(
                child: CircularProgressIndicator()
            );
          },
        )
      ):

          // TUTOR STUDENT PORTAL

      widget.option=='as'?
      Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('creds').get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              List<Map<String, dynamic>> students=[];
              for(int i=0;i<snapshot.data!.docs.length;i++){
                Map<String,dynamic> temp = snapshot.data?.docs[i].data() as Map<String, dynamic>;
                if(temp['std']==snapshot.data?.docs.singleWhere((element) => element.id==FirebaseAuth.instance.currentUser?.uid).get('std') && temp['div']==snapshot.data?.docs.singleWhere((element) => element.id==FirebaseAuth.instance.currentUser?.uid).get('div')) {
                  if(!temp.containsKey('admin') && !temp.containsKey('tutor')) students.add(temp);
                }
              }
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  childAspectRatio: 0.75
                ),
                itemCount: students.length,
                itemBuilder: (context,index)=> Card(
                  child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Image.network(
                                students[index]['image'],
                                height: 200,
                                errorBuilder: (context, object, e) => Container(
                                  height: 200,
                                  child: Text("Image not Available")
                                ),
                              ),
                              Center(child: Text('${students[index]['fname']} ${students[index]['mname']} ${students[index]['lname']}'),),
                              Text('Roll No: ${students[index]['roll no']}')
                            ],
                          ),
                        ),
                        TextButton(
                            onPressed: (){
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Container(
                                          height: 400,
                                          width: 600,
                                          child: Scaffold(
                                              body: Center(
                                                child:
                                                /*Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text("First Name: ${students[index]['fname']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                        Text("Middle Name: ${students[index]['mname']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                        Text("Last Name: ${students[index]['lname']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                      children: [
                                                        Text("Address: ${students[index]['address']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                        Text("STD: ${students[index]['std']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                        Text("DIV: ${students[index]['div']}",textAlign: TextAlign.center,style: TextStyle(fontSize: 20)),
                                                      ],
                                                    )
                                                  ],
                                                )*/
                                                GridView(
                                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 3,
                                                      childAspectRatio: 3
                                                  ),
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  children: [
                                                    Text("First Name: ${students[index]['fname']}",textAlign: TextAlign.center,),
                                                    Text("Middle Name: ${students[index]['mname']}",textAlign: TextAlign.center),
                                                    Text("Last Name: ${students[index]['lname']}",textAlign: TextAlign.center),
                                                    Text("STD: ${students[index]['std']}",textAlign: TextAlign.center),
                                                    Text("DIV: ${students[index]['div']}",textAlign: TextAlign.center),
                                                    Text("Address: ${students[index]['address']}",textAlign: TextAlign.center),
                                                  ],
                                                ),
                                              )
                                          )
                                      ),
                                    );
                                  }
                              );
                            },
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.2))
                            ),
                            child: Container())
                      ],
                    ),
                ),
              );
            }
            else return Center(
                child: CircularProgressIndicator()
            );
          },
        ),
      ):

          // TUTOR ATTENDANCE

      widget.option=='aa'?Padding(
        padding: EdgeInsets.all(50),
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection('creds').get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              List<Map<String, dynamic>> students=[];
              for(int i=0;i<snapshot.data!.docs.length;i++){
                Map<String,dynamic> temp = snapshot.data?.docs[i].data() as Map<String, dynamic>;
                if(temp['std']==snapshot.data?.docs.singleWhere((element) => element.id==FirebaseAuth.instance.currentUser?.uid).get('std')) {
                  if(!temp.containsKey('admin') && !temp.containsKey('tutor'))students.add(temp);
                }
              }
              return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 6,
                          mainAxisSpacing: 5,
                        childAspectRatio: 0.6
                      ),
                      itemCount: students.length,
                      itemBuilder: (context, index){
                        List<DateTime> holidays = [];
                        for(var date in students[index]['holidays']) holidays.add(DateTime.fromMillisecondsSinceEpoch(date.seconds*1000));
                        Duration diff = DateTime.now().difference(DateTime(2021,7,1));
                        double percentage = (diff.inDays-holidays.length)*100/diff.inDays;
                        return Card(
                            child: Stack(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        students[index]['image'],
                                        height: 200,
                                        errorBuilder: (context, object, e) => Container(
                                            height: 200,
                                            child: Text("Image not Available")
                                        ),
                                      ),
                                      Text(students[index].entries.singleWhere((element) => element.key=='fname').value),
                                      Text('${percentage.toString().substring(0,4)}%'),
                                      Text('Present: ${diff.inDays-holidays.length}'),
                                      Text('Absent: ${holidays.length}')
                                    ],
                                  ),
                                ),
                                TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(Colors.orange.withOpacity(0.1))
                                    ),
                                    onPressed: (){
                                      showDialog(context: context, builder: (context) => AlertDialog(
                                        content: Container(
                                          height: 400,
                                          width: 800,
                                          child: TableCalendar(
                                            focusedDay: DateTime.now(),
                                            firstDay: DateTime(2021,7),
                                            lastDay: DateTime.now(),

                                            eventLoader: (day){
                                              if(holidays.contains(day.toLocal())) return [1];
                                              else return [];
                                            },
                                          )
                                        ),
                                      ));
                                    },
                                    child: Container()
                                )
                              ],
                            )
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
