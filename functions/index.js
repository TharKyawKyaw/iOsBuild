const functions = require("firebase-functions");
const admin = require("firebase-admin");

/*var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});*/
admin.initializeApp(functions.config().functions);

exports.sendNotification = functions.firestore
    .document("notifications/{notificationId}")
    .onCreate(
    async(snapshot , context) =>{


        var payload = {
            notification: {
                title: "New Order",
                body: "New Order Arrived"
            },
            data: {click_action: 'FLUTTER_NOTIFICATION_CLICK'}
        }
        const response = await admin.messaging().sendToTopic('Admin',payload);

    })

