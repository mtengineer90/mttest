import 'package:auth_service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mttest/result.dart';

import 'home.dart';

class QueryPage extends StatefulWidget {
  const QueryPage({Key? key}) : super(key: key);

  @override
  State<QueryPage> createState() => _QueryPageState();
}

class _QueryPageState extends State<QueryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController nameController = new TextEditingController();
  TextEditingController surnameController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();

  String name = '';
  String surname = '';
  String city = '';

  String selectedQuery = 'name';
  String queryResult = 'No Result';

  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );
    final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
      
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: SweepGradient(
          //center: FractionalOffset(0.0, 1.0),
          colors: [Color(0xFF2f3070), Color(0xFF5557c7)],
          startAngle: 1 * 3.14 / 4,
          endAngle: 8 * 3.14 / 4,
          tileMode: TileMode.repeated,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Card(color: Colors.white,
            elevation: 4.0,
            child: Container(
              height:MediaQuery.of(context).size.height*0.4,
              width:MediaQuery.of(context).size.width*0.8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 98.0, 8.0, 8.0),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Radio<String>(
                                value: 'name',
                                groupValue: selectedQuery,
                                onChanged: (value) {
                                  setState(() {
                                    selectedQuery = value!;
                                  });
                                },
                              ),
                              Container(
                                padding:
                                EdgeInsets.only(left: 40, right: 40, top: 10),
                                child: TextField(
                                  controller: nameController,
                                  obscureText: false,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14),
                                    hintText: 'Adı',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color:Color(0xFF2b2d8f)),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'surname',
                                groupValue: selectedQuery,
                                onChanged: (value) {
                                  setState(() {
                                    selectedQuery = value!;
                                  });
                                },
                              ),
                              Container(
                                padding:
                                EdgeInsets.only(left: 40, right: 40, top: 10),
                                child: TextField(
                                  controller: surnameController,
                                  obscureText: false,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14),
                                    hintText: 'Soyadı',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color:Color(0xFF2b2d8f)),
                          Row(
                            children: [
                              Radio<String>(
                                value: 'city',
                                groupValue: selectedQuery,
                                onChanged: (value) {
                                  setState(() {
                                    selectedQuery = value!;
                                  });
                                },
                              ),                                Container(
                                padding:
                                EdgeInsets.only(left: 40, right: 40, top: 10),
                                child: TextField(
                                  controller: cityController,
                                  obscureText: false,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 14),
                                    hintText: 'Şehir',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Colors.red,
                                        width: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(color:Color(0xFF2b2d8f)),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(8.0, 8.0, 40.0, 8.0),
                            child: Row(mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Container(color: const Color(0xFF2b2d8f),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF2b2d8f),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(30.0)),
                                      ),
                                      child: const Text(
                                        'ARA',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 14),
                                      ),
                                      onPressed: () async {

                                        try {
                                          name = nameController.text;
                                          surname = surnameController.text;
                                          city = cityController.text;

                                          if(selectedQuery=='name'){
                                            queryResult =  FirebaseFirestore.instance
                                                    .collection('users')
                                                    .where('name', isGreaterThanOrEqualTo: name, isLessThan: name.substring(0, name.length-1) + String.fromCharCode(name.codeUnitAt(name.length - 1) + 1))
                                                    .get() as String;
                                          }
                                          else if (selectedQuery=='surname'){
                                            queryResult =  FirebaseFirestore.instance
                                                    .collection('users')
                                                    .where('surname', isGreaterThanOrEqualTo: surname, isLessThan: surname.substring(0, surname.length-1) + String.fromCharCode(surname.codeUnitAt(surname.length - 1) + 1))
                                                    .get() as String;                                            
                                          }
                                          else if (selectedQuery=='city'){
                                            queryResult =  FirebaseFirestore.instance
                                                    .collection('users')
                                                    .where('location', isGreaterThanOrEqualTo: city, isLessThan: city.substring(0, city.length-1) + String.fromCharCode(city.codeUnitAt(city.length - 1) + 1))
                                                    .get() as String;                                            
                                          }

                                          Navigator.of(context).pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (context) => ResultPage(queryResult: queryResult,)));
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }

                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
