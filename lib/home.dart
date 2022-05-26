import 'package:auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  String _email = '';
  String _password = '';
  bool _obscure = false;
  final AuthService _authService = FirebaseAuthService(
    authService: FirebaseAuth.instance,
  );

  @override
  Widget build(BuildContext context) {

    return Container(
              decoration: const BoxDecoration(
          gradient: SweepGradient(
            //center: FractionalOffset(0.0, 1.0),
            colors: [ Color(0xFF2f3070),Color(0xFF5557c7)],
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
                                    controller: _emailController,
                                    obscureText: false,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: false,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      hintText: 'Email',
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
                                      filled: false,
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      hintText: 'Parola',
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
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 8.0, 40.0, 8.0),
                                  child:  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xFF2b2d8f),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(30.0)),
                                          ),
                                          child: const Text(
                                            'Giriş Yap',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red,
                                                fontSize: 14),
                                          ),
                                          onPressed: () async {
                                            print("Giriş Yap");

        try {
          await _authService.signInWithEmailAndPassword(
            email: _email,
            password: _password,
          );
          // Navigator.of(context)
          //     .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      8.0, 0.0, 50.0, 8.0),
                                  child:  Row(mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (() {
                                          print("Parolamı Unuttum");
                                        }),
                                        child: Text("Parolamı Unuttum", style: TextStyle(fontSize:12.0, color: Colors.white,fontStyle: FontStyle.italic)))
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
