import 'dart:async';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    bool showPass = false;
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
          signedIn = false;
        });
      }
    });
    if(FirebaseAuth.instance.currentUser==null) return [
      MenuButton(
            title: 'LOGIN',
            color: Colors.white,
            hoveredTextColor: Colors.black,
            notHoveredTextColor: Colors.white,
            textSize: 15,
          onPressed: (){
            showDialog(
              builder: (BuildContext context) {
                return SizedBox(
                    child: StatefulBuilder(
                      builder: (context, setState) => AlertDialog(
                          title: const Text("Log In",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
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
                                      textInputAction: TextInputAction.next,
                                      onSaved: (value){
                                        _email = value!;
                                      },
                                    ),
                                    TextFormField(
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: const Color(0xffff6816)
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            splashRadius: 15,
                                            icon: !showPass?Icon(Icons.visibility,color: Colors.grey,):Icon(Icons.visibility_off,color: Color(0xffff6816)),
                                            onPressed: (){
                                              setState(() {
                                                showPass = !showPass;
                                              });
                                            },
                                          )
                                      ),
                                      textInputAction: TextInputAction.done,
                                      onFieldSubmitted: (value) async{
                                        if(_formkey.currentState!.validate()) {
                                          _formkey.currentState!.save();
                                          print("email: $_email, password: $_password");
                                          await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password).catchError((e){
                                            showDialog(context: context, builder: (context) => AlertDialog(
                                              title: Text("Invalid Credentials"),
                                            ));
                                          });
                                          Navigator.pop(context);
                                          setState(() {});
                                        }
                                      },
                                      obscureText: !showPass,
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
                      )),

                );
              },
              context: context,

            );
          },
        ),
      Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/5)),
    ];
    else return [
      MenuButton(
                title: FirebaseAuth.instance.currentUser?.displayName as String,
                color: Colors.white,
                hoveredTextColor: Colors.black,
                notHoveredTextColor: Colors.white,
                textSize: 15,
                onPressed: () async{
                  // await user?.updateDisplayName('Vandana');
                  Navigator.push(
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
                  showDialog(
                    builder: (BuildContext context) {
                      return SizedBox(
                        child: StatefulBuilder(
                            builder: (context, setState) => AlertDialog(
                                title: const Text("Contact Us",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Tel. No.: 1800-123-456"),
                                    Text("Email: support@nhs.com")
                                  ],
                                )
                            )),

                      );
                    },
                    context: context,

                  );
                },
              ),
              actions(context).first,
              Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width/10))
            ],
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                color: Colors.black,
                height: 300,
                width: MediaQuery.of(context).size.width/2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 50),),
                      Text("About Us",style: TextStyle(color: Colors.white,fontSize: 35),textAlign: TextAlign.left,),
                      Padding(padding: EdgeInsets.only(top: 20),),
                      Text("We are pleased to welcome you to the Nirmala High School campus, one of Mira Road's Select Schools. At Nirmala, we strive to create a secure, supportive, and challenging environment in which children may develop into active, introspective, and creative learners who take ownership of their learning, take pride in their community, and are prepared to participate in a culturally varied world.",style: TextStyle(color: Colors.white,fontSize: 18)),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                height: 300,
                width: MediaQuery.of(context).size.width/2,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 50),),
                      Text("Our Mission",style: TextStyle(color: Colors.white,fontSize: 35),textAlign: TextAlign.left,),
                      Padding(padding: EdgeInsets.only(top: 20),),
                      Text("Nirmala High School prepares students to comprehend, contribute to, and achieve in a fast changing society, therefore contributing to the creation of a more fair and equitable world. We will guarantee that our students acquire both the skills necessary for success and leadership in the burgeoning creative economy and the competencies necessary for success and leadership in the rising creative economy. Additionally, we will be a leader in developing practical and theoretical knowledge that helps individuals to have a better understanding of our environment and to enhance the living standards of local and global populations.",style: TextStyle(color: Colors.white,fontSize: 18)),
                    ],
                  )
                ),
              ),
            ],
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