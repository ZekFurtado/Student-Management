import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateStudent extends StatefulWidget {
  const UpdateStudent({Key? key}) : super(key: key);

  @override
  State<UpdateStudent> createState() => _UpdateStudentState();
}

class _UpdateStudentState extends State<UpdateStudent> {

  final _formkey1 = GlobalKey<FormState>(),_formkey2 = GlobalKey<FormState>();
  late String fname,mname,lname,address,city,state,pin,div,roll_no,dob;
  String std='';
  late int fees,paid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff6816),
        toolbarHeight: 80,
        elevation: 20,
        centerTitle: true,
        title: const Text("UPDATE STUDENT DATA",style: TextStyle(fontFamily: 'Merriweather',color: Colors.white,)),
      ),
      body: std.isEmpty?Center(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 10, color: Color(0xffbdbdbd))
              ]
          ),
          height: 300,
          width: 600,
          child: Form(
            key: _formkey1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "STD",
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
                            hintText: "DIV",
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
                          div = value!;
                        },
                      ),
                    ),
                    Container(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Roll No",
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
                    )
                  ],
                ),
                TextButton(
                  child: Text("Search",style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.orange)
                  ),
                  onPressed: () async{
                    if(_formkey1.currentState!.validate()){
                      _formkey1.currentState?.save();
                      await FirebaseFirestore.instance.collection('creds').get()
                      .then((querysnapshot){
                        print(querysnapshot.size);
                        List<QueryDocumentSnapshot<Map<String, dynamic>>> data = querysnapshot.docs.toList();
                        data.removeWhere((element) => element.data().containsKey('admin'));
                        data.removeWhere((element) => element.data().containsKey('tutor'));
                        // print(data.singleWhere((element) => element.data().containsKey('admin')));
                        // print(data.singleWhere((element) => element.data().containsKey('tutor')));
                        print(data.length);
                        print("checkpoint #1");
                        for(var i in querysnapshot.docs) print(i.data());
                        if(data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).exists) {
                          print("checkpoint #2");
                          fname = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('fname');
                          mname = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('mname');
                          lname = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('lname');
                          address = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('address');
                          city = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('city');
                          state = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('state');
                          pin = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('pin');
                          dob = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('dob');
                          fees = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('fees');
                          paid  = data.singleWhere((element) => element.get('std')==std && element.get('div')==div && element.get('roll no')==roll_no).get('paid');
                          setState(() {

                          });
                        }
                        else showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: Text("Student Not Found"),
                            actions: [
                              TextButton(onPressed: (){
                                Navigator.pop(context);
                                setState(() {
                                  std = '';
                                  div = '';
                                  roll_no = '';
                                });
                              },
                                  child: Text("OK"))
                            ],
                          )
                        );
                      });
                    }
                  },
                ),
              ],
            ),
          )
        )
      ):
      Form(
          key: _formkey2,
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
                                ),
                            ),
                            initialValue: fname,
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
                            initialValue: mname,
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
                            initialValue: lname,
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
                            initialValue: address,
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
                            initialValue: city,
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
                            initialValue: state,
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
                            initialValue: pin,
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
                            initialValue: std,
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
                            initialValue: div,
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
                            initialValue: roll_no,
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
                            initialValue: fees.toString(),
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
                            initialValue: paid.toString(),
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
                            initialValue: dob,
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
                        if(_formkey2.currentState!.validate()){
                          _formkey2.currentState?.save();
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
