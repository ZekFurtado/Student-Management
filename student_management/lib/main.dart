import 'dart:async';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dashboard.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login()
  ));
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  final _formkey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  String _email = '',_password = '';

  List<Widget> actions(BuildContext context){
    bool signedIn = false;
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if(user==null){
        setState(() {
          signedIn = true;
        });
      }
      else{
        setState(() {
          setState(() {
            signedIn = false;
          });
        });
      }
    });
    if(FirebaseAuth.instance.currentUser==null) return [
      Center(
        child: MenuButton(
            title: 'LOGIN',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
          onPressed: (){
            showDialog(
              builder: (BuildContext context) {
                return SizedBox(
                    child: AlertDialog(
                        title: const Text("Log In",textAlign: TextAlign.center,),
                        content: Form(
                            key: _formkey,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextFormField(
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffff6816)
                                        ),
                                      ),
                                    ),
                                    validator: (value){
                                      if(!isEmail(value!)) return "Invalid Email";
                                    },
                                    onSaved: (value){
                                      _email = value!;
                                    },
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.black,
                                    decoration: const InputDecoration(
                                      hintText: "Password",
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffff6816)
                                        ),
                                      ),
                                    ),
                                    onSaved: (value){
                                      _password = value!;
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20),
                                  ),
                                  TextButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Color(0xffff6816))
                                    ),
                                    child: Text("Login",style: TextStyle(color: Colors.white)),
                                    onPressed: () async{
                                      if(_formkey.currentState!.validate()) {
                                        _formkey.currentState!.save();
                                        print("email: $_email, password: $_password");
                                        await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
                                        Navigator.pop(context);
                                        setState(() {

                                        });
                                      }
                                    },
                                  )
                                ]
                            )
                        )
                    )
                );
              }, context: context,

            );
          },
        ),
      ),
      /*const Padding(padding: EdgeInsets.only(left: 10)),
      const Center(
        child: Text("|",style: TextStyle(fontFamily: 'Merriweather')),
      ),
      const Padding(padding: EdgeInsets.only(left: 10)),
      Center(
        child: MenuButton(
            title: 'REGISTER',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
          onPressed: (){},
        ),
      ),*/
      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/5)),
    ];
    else return [
      MenuButton(
        title: FirebaseAuth.instance.currentUser!.email as String,
        color: Colors.white,
        hoveredTextColor: Colors.black,
        notHoveredTextColor: Colors.white,
        textSize: 15,
        onPressed: (){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard()
            )
          );
        }
      ),
      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/10)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xffff6816),
          titleSpacing: MediaQuery.of(context).size.width/10,
          title: Row(
            children: const [
              Icon(Icons.phone),
              Text("1800 123 456",style: TextStyle(fontFamily: 'Merriweather')),
              Padding(padding: EdgeInsets.only(left: 50)),
              Icon(Icons.email),
              Text("abc@def.com",style: TextStyle(fontFamily: 'Merriweather'))
            ],
          ),
          actions: actions(context),
          bottom: AppBar(
            backgroundColor: const Color(0xff000000),
            // toolbarHeight: 80,
            title: const Text("NIRMALA HIGH SCHOOL",style: TextStyle(fontFamily: 'Merriweather',color: Colors.white,)),
            titleSpacing: MediaQuery.of(context).size.width/10,
            actions: [
              MenuButton(title: 'HOME',color: Color(0xffff6816),hoveredTextColor: Colors.white,notHoveredTextColor: Colors.white,textSize: 15,onPressed: (){},),
              MenuButton(title: 'PAGES',color: Color(0xffff6816),hoveredTextColor: Colors.white,notHoveredTextColor: Colors.white,textSize: 15,onPressed: (){},),
              MenuButton(title: 'COURSES',color: Color(0xffff6816),hoveredTextColor: Colors.white,notHoveredTextColor: Colors.white,textSize: 15,onPressed: (){},),
              MenuButton(title: 'CONTACT',color: Color(0xffff6816),hoveredTextColor: Colors.white,notHoveredTextColor: Colors.white,textSize: 15,onPressed: (){},),
              Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/10))
            ],
          )
      ),
      body: ListView(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                alignment: AlignmentDirectional.topStart,
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/main1.jpg',fit: BoxFit.fitWidth,alignment: Alignment.topCenter,),
                  Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          height: MediaQuery.of(context).size.height*0.5,
                          color: Colors.white24,
                          child: const Center(
                              child: Text("Boost Your Child's Education",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontFamily: 'Merriweather',fontWeight: FontWeight.bold,fontSize: 50))
                          )
                      )
                  ),
                ],
              )
          ),
          // const Padding(padding: EdgeInsets.only(top: 20)),
          const Text("Ranked #3 City-Wide",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
          const Padding(padding: EdgeInsets.only(top: 50)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Text("Admissions open for classes 5-10",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 25,color: Color(0xffff6816))),
            ],
          ),
          Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("15",style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
                      Text("New School\nPrograms",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 20,fontWeight: FontWeight.w300))
                    ]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("50",style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
                      Text("Upcoming Education\nEvents",textAlign: TextAlign.center,style: TextStyle(wordSpacing: 10,fontFamily: 'Merriweather',fontSize: 20,fontWeight: FontWeight.w300))
                    ]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("500+",style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
                      Text("Online Courses",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 20,fontWeight: FontWeight.w300))
                    ]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("10",style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
                      Text("Experts Education\nWorkers",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 20,fontWeight: FontWeight.w300))
                    ]
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("600+",style: TextStyle(fontFamily: 'Merriweather',fontSize: 40)),
                      Text("Complete Education\nProjects",textAlign: TextAlign.center,style: TextStyle(fontFamily: 'Merriweather',fontSize: 20,fontWeight: FontWeight.w300))
                    ]
                )
              ],
            ),
          Padding(
            padding: EdgeInsets.only(top: 100)
          ),
          Container(
            // color: Colors.green,
            height: 500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset('school.png',fit: BoxFit.cover),
                Container(
                  width: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Our Mission',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.double
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                      ),
                      Text(
                          "Nirmala High School is an open-admission public charter school that prepares all students for college admissions and successful careers. NHS provides a rigorous high school curriculum with an emphasis in science and mathematics in a supportive environment of learning and respect that prepares students to make informed choices about post-secondary pursuits.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 18)
                      )
                    ],
                  )
                )
              ]
            )
          ),
          Container(
            height: 500,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: 500,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                'Admissions Open',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                    decorationStyle: TextDecorationStyle.double
                                )
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                            Text(
                                "Applications for the 2021-2022 school year opened on October 1, 2020. This application is valid for students turning 5 years old on or before September 1, 2021. The lottery for the 2021-2022 school year took place on February 1, 2021. All new applications will go on a waitlist and you will be contacted as space becomes available. ",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 18)
                            )
                          ],
                        )
                    ),
                    Image.asset('admission.jpg',fit: BoxFit.cover),
                  ]
              )
          ),
          Container(
              height: 300,
            color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("About Us",style: TextStyle(color: Colors.white)),
                  Text("About Us",style: TextStyle(color: Colors.white)),
                  Text("About Us",style: TextStyle(color: Colors.white))
                ],
              )
          )
        ],
      )
    );
  }
}

class MenuButton extends StatefulWidget {
  final String title;
  final Color color, hoveredTextColor,notHoveredTextColor;
  final double textSize;
  final Function onPressed;
  const MenuButton({Key? key,required this.title, required this.color, required this.hoveredTextColor, required this.notHoveredTextColor, required this.textSize, required this.onPressed}) : super(key: key);

  @override
  _MenuButtonState createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  bool hovered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: MouseRegion(
        onEnter: (entered){
          setState((){
            hovered = true;
          });
        },
          onExit: (exited){
            setState((){
              hovered = false;
            });
          },
          child: TextButton(
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all(widget.color),
              ),
              child: Text(widget.title,style: TextStyle(fontSize: widget.textSize,fontFamily: 'Merriweather',color: hovered?widget.hoveredTextColor:widget.notHoveredTextColor)),
              onPressed: (){
                widget.onPressed();
              }
          )
      ),
    );
  }
}

class Counter extends StatefulWidget {
  int limit;
  Counter({Key? key,required this.limit}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  bool shit = false;
  int start = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: VisibilityDetector(
              key: const Key("unique key"),
              onVisibilityChanged: (info) async{
                print("visibility: ${info.visibleFraction}");
                if(info.visibleFraction == 0) start = 0;
                if(info.visibleFraction!=0 && start==widget.limit || start == 0) {
                  // shit = false;
                  // start = 0;
                  for(int i=0;i<=widget.limit;i++){
                    // Timer(const Duration(milliseconds: 1000),(){
                    // });
                    await Future.delayed(const Duration(milliseconds: 1));
                    print(i);
                    setState(() {
                      start=i;
                    });
                  }
                }
                // else {
                //   shit = true;
                //
                // }
              },
            child: Container(
                height: 100,
                width: 200,
                // color: Colors.green,
                child: Text(start.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 90))

            )
          )
        );
  }
}