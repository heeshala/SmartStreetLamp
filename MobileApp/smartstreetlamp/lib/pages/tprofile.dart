import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartstreetlamp/pages/data.dart';
import 'package:smartstreetlamp/pages/technicianhome.dart';



class TProfile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final databaseReference = FirebaseDatabase.instance.reference();


class _ProfileState extends State<TProfile> {
  bool showPassword = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
 Widget build(BuildContext context) {
    return new Scaffold(
      
      
      body: formWidget(),
    );
  }
  final _firebaseRef = FirebaseDatabase.instance.reference().child('technicians').orderByKey().equalTo('342567091V');
 int temp;
 String stat;
Widget formWidget() {
  final ref = databaseReference.reference();
  List lists;
  return StreamBuilder(
    
    stream: _firebaseRef.onValue,
    builder: (context, snap) {

        if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {

            Map data = snap.data.snapshot.value;
            List item = [];
            
            data.forEach((index, data) => item.add({"key": index, ...data}));
             
            return ListView.builder(
                
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      

                        
                        
                        
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:[

              Text(
                'Edit  Owner Profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Stack(
                  children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.cyan,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    "https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"))),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 35.0,
              ),
           Column(children: [
                          TextFormField(
                            controller: nameController..text=item[index]['Name'],

  decoration: InputDecoration(
    labelText: 'Full Name'

  ),
),
TextFormField(
                            controller: emailController..text=item[index]['Email'],
  decoration: InputDecoration(
    labelText: 'E-mail'

  ),
),
 TextFormField(
                            controller: passwordController..text=item[index]['Password'],
                              obscureText: true,
  decoration: InputDecoration(
    labelText: 'Password',

  ),
),
TextFormField(
                            controller: mobileController..text=item[index]['Contact'],
  decoration: InputDecoration(
    labelText: 'Contact'

  ),
),
TextFormField(
                            controller: addressController..text=item[index]['Address'],
  decoration: InputDecoration(
    labelText: 'Home Address'

  ),
),


              SizedBox(
                height: 35.0,
              ),
                        ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  RaisedButton(
                      onPressed: () {
                        //update();
                      },
                      color: Colors.cyan,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 14.0,
                          letterSpacing: 2.2,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  RaisedButton(
                color: Colors.red,

                      padding: EdgeInsets.symmetric(
                        horizontal: 50,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      onPressed: () async {
                        return showDialog(context: context,
      builder:(_) => AlertDialog(
        title: Text('LogOut'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure you want to logout ?'),

            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Yes'),
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('userID');
                prefs.remove('type');
                        Navigator.pop(context);
                        //Navigator.push(context,
                            //MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
               Navigator.of(context).pop();
            },
          ),
        ],
      ),

      barrierDismissible: false);

                      },
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white,

                        ),
                      ),
                  )
                ],
              ),


                        ]),
                    );
                    },
                );
        }
        else
            return Center(child: CircularProgressIndicator());
    },
);
}}
