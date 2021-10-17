import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smartstreetlamp/pages/data.dart';
import 'package:smartstreetlamp/pages/technicianhome.dart';
import 'package:url_launcher/url_launcher.dart';



class OJobs extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<OJobs> {

  final databaseReference = FirebaseDatabase.instance.reference();
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      
      body: formWidget(),
    );
  }
  var _firebaseRef = FirebaseDatabase().reference().child('history').orderByChild("Completed").equalTo("");
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
                         
                            var latitude;
                            var longitude;
                            String id=item[index]['Lamp'];
                            String desc=item[index]['Issue'];
                            var status=item[index]['Status'];
                            var my_color_variable;
                            var tcolor;
                            var ic;
                            var iccolor;
                            if(item[index]['Status']=='Pending'){
                            my_color_variable=Colors.yellow;
                            tcolor=Colors.red;
                            ic=Icons.assignment_late;
                            iccolor=Colors.red;
                            
                            }
                            else if(item[index]['Status']=='Assigned'){
                              my_color_variable=Colors.greenAccent;
                              tcolor=Colors.green[900];
                            ic=Icons.assistant_rounded;
                            iccolor=Colors.green[900];
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
                  const SizedBox(width: 8),
                  TextButton(
                    child:  Text(status),
                    onPressed: () {/* ... */},
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
void getData(){
    databaseReference.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }
Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void acceptjob(String id){
  CollectionReference users = FirebaseFirestore.instance.collection('jobs');

Future<void> updateUser() {
  return users
    .doc(id)
    .update({
    'status': 'Completed',
    
    
    })
    .then((value) => print("User Updated"))
    .catchError((error) => print("Failed to update user: $error"));
}
updateUser();

}
  
}
