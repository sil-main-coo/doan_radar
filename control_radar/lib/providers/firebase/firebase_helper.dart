import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

// singleton
class FirebaseDatabaseHelper {
  FirebaseApp app;
  FirebaseDatabase database;
  DatabaseReference appMessagesRef;

  Future<void> initial() async {
    app = await Firebase.initializeApp();

    database = FirebaseDatabase(app: app);
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);

    appMessagesRef = database.reference().child('DA-TN-THANG');
    appMessagesRef.keepSynced(true);
  }

  Future<void> turnOnCamera()async{
    appMessagesRef.child('camera').set('on');
  }

  Future<void> turnOffCamera()async{
    appMessagesRef.child('camera').set('off');
  }
}
