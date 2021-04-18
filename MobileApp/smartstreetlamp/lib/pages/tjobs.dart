import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:smartstreetlamp/pages/data.dart';
import 'package:smartstreetlamp/pages/technicianhome.dart';
import 'package:intl/intl.dart';



class TJobs extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<TJobs> {
final databaseReference = FirebaseDatabase.instance.reference();
  
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      
      body: formWidget(),
    );
  }
  var _firebaseRef = FirebaseDatabase().reference().child('history').orderByChild("AssignedTo").equalTo("342567091V");
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
                            String desc=item[index]['Issue'];
                            var status=item[index]['Status'];
                            var hisId=item[index]['key'];
                            var my_color_variable;
                            var tcolor;
                            var ic;
                            var iccolor;
                            if(item[index]['Status']=='Accepted'){
                            my_color_variable=Colors.yellow;
                            tcolor=Colors.red;
                            ic=Icons.hardware;
                            iccolor=Colors.red;
                            
                            }
                            else if(item[index]['Status']=='Completed'){
                              my_color_variable=Colors.greenAccent;
                              tcolor=Colors.green[900];
                            ic=Icons.assignment_turned_in;
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
                  if(status=='Accepted')
                  TextButton(
                    child:  Text("COMPLETE JOB"),
                    onPressed: () {jobcomplete(hisId,id);},
                  ),
                  const SizedBox(width: 8),
                  if(status=='Completed')
                  TextButton(
                    child:  Text("Job Completed "),
                    onPressed: () {},
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

void jobcomplete(String id,String lamp)async{
  var _firebaseRef = FirebaseDatabase().reference().child('history').child(id);
     await _firebaseRef.update({"Status": "Completed"});
     String now = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
    await _firebaseRef.update({"Completed": now});
     var _firebaseRef2 = FirebaseDatabase().reference().child('issue').child(lamp);
     await _firebaseRef2.remove();


}
  
}
