var  admin = require("firebase-admin");
var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
});

export async function sendNotificationEvenetCreation(){
    try{
        var payload = {notification:{title: 'FCCM using flutter and node js',
        body:'we are fine now'},
        data:{click_action:'FLUTTER_NOTIFICATION_CLICK'}}

        await admin.messaging().sentToTopic('Events',payload);

    } catch (error){
        console.log(error);
    }
}