const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();
const accountSid = "AC402d8b30616ded59a52e42523b040a1f";
const authToken = "e04be1002e7c0122fc05f9ca676db8db";
const client = require('twilio')(accountSid, authToken);
var db = admin.database();
var ref = db.ref("history");
exports.sendSMSNotfication = functions.database.ref('issue/{id}').onCreate(async (snapshot,context) =>{
       const val=snapshot.val();
       
       
    return admin.database().ref('owners').on('value',function(snapshot){
        snapshot.forEach(function (childSnapshot){
              var data=childSnapshot.val();
              
            client.messages
            .create({
               body: '\nAlert\nSmartLampPole '+val.Id+' is facing an issue\nReported as '+val.Description+'.',
               from: '+14782172235',
               to: data.Contact
             })
            .then(message => console.log(message.sid));
              
        });
    });
    
    
});

exports.addHistory = functions.database.ref('issue/{id}').onCreate(async (snapshot, context) => {
  const val = snapshot.val();
  
  

       const timeElapsed = Date.now();
        const today = new Date(timeElapsed);
        var datetime=today.toUTCString();

      
          
      return admin.database().ref('history').push().set({
                  Lamp: val.lampid,
                  Reported: datetime,
                  Completed:"",
                  Status:"Pending",
                  AssignedTo:"",
                  Issue:val.errormsg
                  
          });
      
      


});


exports.addKeyofHistory=functions.database.ref('history/{id}').onCreate(async (snapshot,context) =>{
  const val=snapshot.val();
  const id=snapshot.key;

  return admin.database().ref('issue').child(val.Lamp).update({
    HistoryId: id,
    
    
});


});

