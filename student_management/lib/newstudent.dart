import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewStudent extends StatelessWidget {

  final _formkey = GlobalKey<FormState>();
  late String fname,mname,lname,address,city,state,pin,std,div,roll_no,dob;
  late int fees,paid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6816),
        toolbarHeight: 80,
        elevation: 20,
        centerTitle: true,
        title: const Text("NEW STUDENT FORM",style: TextStyle(fontFamily: 'Merriweather',color: Colors.white,)),
      ),
      body: Form(
        key: _formkey,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height-200,
            width: MediaQuery.of(context).size.width-400,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
                ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "First Name",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
    },
                        onSaved: (value){
                          fname = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Middle Name",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
    },
                        onSaved: (value){
                          mname = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Last Name",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          lname = value!;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Address",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          address = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "City",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          city = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "State",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          state = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 200,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Pin Code",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          pin = value!;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Standard",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        onSaved: (value){
                          std = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Division",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.orange
                            )
                          )
                        ),
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                          },
                        textAlign: TextAlign.center,
                        onSaved: (value){
                          div = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Roll Number",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                        },
                        onSaved: (value){
                          roll_no = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Fees",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                        },
                        onSaved: (value){
                          fees = int.parse(value!);
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Paid",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                        },
                        onSaved: (value){
                          paid = int.parse(value!);
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "DOB",
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.orange
                                )
                            )
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.orange,
                        validator: (value){
                          if(value!.isEmpty) return "Required";
                          return null;
                        },
                        onSaved: (value){
                          dob = value!;
                        },
                      ),
                    ),

                  ],
                ),
                TextButton(
                  child: Text("Submit",style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange)
                  ),
                  onPressed: () async{
                    if(_formkey.currentState!.validate()){
                      _formkey.currentState?.save();
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: "$fname$lname@nhs.com", password: "$fname$lname")
                          .then((user) async{
                            await user.user?.updateDisplayName(fname);
                        await FirebaseFirestore.instance.collection('creds').doc(user.user?.uid).set({
                          'fname' : fname,
                          'mname' : mname,
                          'lname' : lname,
                          'address' : address,
                          'city' : city,
                          'state' : state,
                          'pin' : pin,
                          'std' : std,
                          'div' : div,
                          'roll no' : roll_no,
                          'image' : 'https://firebasestorage.googleapis.com/v0/b/student-management-6371c.appspot.com/o/default.jpg?alt=media&token=2be879a3-9d45-43a9-bf32-85f743c35cb4',
                          'dob' : dob,
                          'fees' : fees,
                          'due' : '01/04/2022',
                          'holidays' : [],
                          'paid' : paid,
                        });
                      });
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
