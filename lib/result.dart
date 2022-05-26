import 'package:auth_service/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.queryResult,
}) : super(key: key);
  final String queryResult;

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  String queryResult = 'No Result';

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
            child: Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 98.0, 8.0, 8.0),
                  child: Column(
                    children: [
                      Form(
                        child: Container(
                          child: Expanded(child: Center(child: Text(widget.queryResult))),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
