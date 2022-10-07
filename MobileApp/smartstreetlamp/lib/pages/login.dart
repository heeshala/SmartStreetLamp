import 'package:flutter/material.dart';
import 'package:smartstreetlamp/pages/ologin.dart';
import 'package:smartstreetlamp/pages/tlogin.dart';

class Login extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Scaffold(
        body: Container(
          child :Stack(
                children: <Widget>[
          Container(
                    padding: EdgeInsets.fromLTRB(15.0, 60.0, 0.0, 0.0),
                    child: Text(
                      'Hi !',
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 150.0, 0.0, 0.0),
                    child: Text(
                      'Who Are You ?',
                      style: TextStyle(
                          fontSize: 60.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
         Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          
                          Center(
                            child:Container(
                              
                             padding: EdgeInsets.only(top :50, left: 20,right: 20 ),
                            child: RaisedButton(
                              
                        textColor: Colors.green,
                        color: Colors.blue,
                        child: Text('Owner' , style: TextStyle(fontSize: 30,color: Colors.white,fontWeight:FontWeight.bold),),
                       onPressed: () {
                         Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OLogin()));
                       }),
                          )),
                          Center(
                            child:Container(
                             padding: EdgeInsets.only(top :50, left: 20,right: 20 ),
                            child: RaisedButton(
                              
                        textColor: Colors.green,
                        color: Colors.blue,
                        child: Text('Technician' , style: TextStyle(fontSize: 30,color: Colors.white,fontWeight:FontWeight.bold),),
                       onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TLogin()));
                       }),
                          ))
                        ],
                      ),
                      Container(
                    padding: EdgeInsets.only(left:90.0,top: 550.0),
                    child: Text(
                      'SmartStreetLamp',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyan),
                    ),
                  ),
                      ]),
      )));}
}
