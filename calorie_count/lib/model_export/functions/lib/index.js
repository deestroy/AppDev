"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var admin = require("firebase-admin");
//var serviceAccount = require("/Users/dhritiaravind/Downloads/caloriesignin-firebase-adminsdk-lr8nm-97c7ef2a17.json");

/*admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://caloriesignin.firebaseio.com"
  
});*/


const functions = require('firebase-functions');
admin.initializeApp(functions.config().firebase);
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
exports.anotherFunction = functions.https.triggerNewDocument((request, response) => {
    // This functions uses the one that I want to deploy.
    triggerNewDocument()
})

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
//# sourceMappingURL=index.js.map