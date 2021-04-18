const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

admin.database().ref('owner/{id}/Contact').once('value').then(contact =>{
        if(contact.val()){
            console.log("token available");
const cont = contact.val();
            console.log(cont);}});