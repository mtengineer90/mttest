import 'package:auth_service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'location.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _surnameController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String _email = '';
  String _password = '';
  String _displayName = '';
  String _displaySurname = '';
  String _displayDate = '';
  bool _obscure = false;
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
          child: Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 98.0, 8.0, 8.0),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: TextField(
                            controller: _nameController,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              hintText: 'Ad',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: TextField(
                            controller: _surnameController,
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
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: TextField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2070));
                              if (pickedDate != null) {
                                print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(formattedDate);
                                setState(() {
                                  _dateController.text = formattedDate;
                                });
                              }
                            },
                            readOnly: true,
                            controller: _dateController,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              hintText: 'Doğum Tarihi',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: TextField(
                            controller: _emailController,
                            obscureText: false,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              hintText: 'Email',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 40, right: 40, top: 10),
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscure,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              hintText: 'Parola',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 40.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF2b2d8f),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0)),
                                ),
                                child: const Text(
                                  'Üye Ol',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 14),
                                ),
                                onPressed: () async {
                                  print("Üye Ol");

                                  try {
                                    _displayName =
                                        _nameController.text.toString();
                                    _displaySurname =
                                        _surnameController.text.toString();
                                    _displayDate =
                                        _dateController.text.toString();
                                    _email = _emailController.text.toString();
                                    _password =
                                        _passwordController.text.toString();
                                    //_password='test';
                                    await _authService
                                        .createUserWithEmailAndPassword(
                                      email: _email,
                                      password: _password,
                                    );
                                    
                                    await users.add({
                                      "name": _displayName, 
                                      "surname": _displaySurname,
                                      "mail": _email, 
                                      "date": _displayDate,
                                      "location": '',                                       
                                      
                                      }).then((value){
                                        print(value.id);
                                    
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => LocationPage(
                                          name: _displayName,
                                          surname: _displaySurname,
                                          date: _displayDate,
                                          email: _email,
                                          password: _password,
                                          value: value.toString()
                                        ),
                                      ),
                                    );
                                      });


                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(e.toString()),
                                      ),
                                    );
                                  }

/*                                             Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LocationPage(
                                              name: 'Mehmet',
                                              surname: 'İBİS',
                                              date: '26.05.2022',
                                              email: 'mehmetibis1@gmail.com',
                                              password: 'mehmetibis',
                                            ))); */

                                  //Konum Sayfası'na git...
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 0.0, 50.0, 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                  onTap: (() {
                                    print("Hesabım Var");
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  }),
                                  child: Text("Hesabım Var",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                          fontStyle: FontStyle.italic)))
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
    );
  }
}
