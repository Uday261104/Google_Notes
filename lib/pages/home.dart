import 'package:flutter/material.dart';
import 'package:google_notes/pages/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),

                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ),
    );
  }
}