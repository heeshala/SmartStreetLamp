import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smartstreetlamp/pages/data.dart';
import 'package:twilio_flutter/twilio_flutter.dart';

import 'package:url_launcher/url_launcher.dart';


class TechnicianHome extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<TechnicianHome>  {
   final databaseReference = FirebaseDatabase.instance.reference();
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      
      body: formWidget(),
    );
  }
  var _firebaseRef = FirebaseDatabase().reference().child('history').orderByChild("Status").equalTo("Requested");
 int temp;
 String stat;
Widget formWidget(){
  final ref = databaseReference.reference();
  
  return Padding(
    padding: const EdgeInsets.only(top:8.0,left: 6.0,right: 6.0),
    child: Center(

      child: StreamBuilder(

        stream: _firebaseRef.onValue,
        builder: (context, snap) {

            if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {

                Map data = snap.data.snapshot.value;
                List item = [];

                data.forEach((index, data) => item.add({"key": index, ...data}));

                return ListView.builder(
                        
                        itemCount: item.length,
                        itemBuilder: (context, index) {
                          /*temp=item[index]['Temperature'];
                          if(temp>27){
                              stat="too hot";

                            }
                            else{
                              stat="too cold";

                            }*/
                            var latitude;
                            var longitude;
                            String id=item[index]['Lamp'];
                            String desc;
                            String hisid=item[index]['key'];
                            
                            var my_color_variable;
                            var tcolor;
                            var ic;
                            var iccolor;
                            if(item[index]['Issue']=='BULB IS BURNT'){
                            my_color_variable=Colors.black;
                            tcolor=Colors.white;
                            ic=Icons.lightbulb;
                            iccolor=Colors.white;
                            
                            }
                            else if(item[index]['Issue']=='CURRENT NOT PASSING'){
                              my_color_variable=Colors.yellow;
                              tcolor=Colors.red;
                            ic=Icons.bolt;
                            iccolor=Colors.red;
                            }
                            
                            
                            
                        return Card(
                          
                          
                          color: my_color_variable,
                          child: Column(
            mainAxisSize: MainAxisSize.min,
            
            children: <Widget>[
               ListTile(
                           leading: Icon(ic,color: iccolor,),
                title: Text(item[index]['Issue'],style:  TextStyle(color: tcolor,fontSize: 20)),
                subtitle: Text(item[index]['Lamp'],style:  TextStyle(color: tcolor)),
                
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: const Text('LOCATE LAMP'),
                    onPressed: () {
                      var _firebaseRef2 = FirebaseDatabase().reference().child('lamps').child(id);
                            _firebaseRef2.once().then((DataSnapshot snapshot) async {
                            latitude=snapshot.value["lat"];
                            longitude=snapshot.value["lon"];
                            
                            MapsLauncher.launchCoordinates(
                    latitude, longitude, 'Lamp is here');
                            });

                            

                            
                     },
                  ),
                  
                   SizedBox(width: 8),
                  
                  
                  TextButton(
                    child: const Text('Accept'),
                    onPressed: () {accept(hisid,id);},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
                              
                        ]));
                        },
                    );
            }
            else
                return Container(
                  child: ListView(
                    children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Image.asset(
                          'assets/images/fine.gif',
                          width: 250,
                          height: 400,
                        ),

                      ),
                      Text("Everything works fine",style: TextStyle(height: 5, fontSize: 30),textAlign: TextAlign.center,),
                    ]),
                );

        },
),
    ),
  );
}


  

TwilioFlutter twilioFlutter;
void requesttech(String id,String lamp)async{
  twilioFlutter = TwilioFlutter(
      accountSid: 'AC402d8b30616ded59a52e42523b040a1f',
      authToken: 'e04be1002e7c0122fc05f9ca676db8db',
      twilioNumber: '+14782172235');
  var _firebaseRef = FirebaseDatabase().reference().child('history').child(id);
     await _firebaseRef.update({"Status": "Requested"});

     var _firebaseRef2 = FirebaseDatabase().reference().child('issue').child(lamp);
     await _firebaseRef2.update({"Status": "Requested"});

     FirebaseDatabase().reference().child('technicians').once().then((DataSnapshot snapshot){
  Map<dynamic, dynamic> values = snapshot.value;
     values.forEach((key,values) {
      String contact=values["Contact"];
      twilioFlutter.sendSMS(
      toNumber: contact, 
    messageBody: '\nA new job request has been added\nIf interested please check the SmartStreetLamp Application');

    });
  });


}

void accept(String id,String lamp)async{
  var _firebaseRef = FirebaseDatabase().reference().child('history').child(id);
     await _firebaseRef.update({"Status": "Accepted"});
    await _firebaseRef.update({"AssignedTo": "342567091V"});
     var _firebaseRef2 = FirebaseDatabase().reference().child('issue').child(lamp);
     await _firebaseRef2.update({"Status": "Accepted"});


}
  
}


