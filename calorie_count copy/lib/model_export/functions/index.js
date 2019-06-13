const functions = require('firebase-functions');

function triggerNewDocument() {
    // [START trigger_new_document]
    exports.createUser = functions.firestore
        .document('users/{userId}')
        .onCreate((snap, context) => {
          // Get an object representing the document
          // e.g. {'name': 'Marie', 'age': 66}
          const newValue = snap.data();
  
          // access a particular field as you would any JS property
          const name = newValue.name;
  
          // perform desired operations ...
        });
    // [END trigger_new_document]
  }

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
