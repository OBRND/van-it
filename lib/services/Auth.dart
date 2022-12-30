import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:van_lines/models/User.dart';
import 'package:van_lines/screens/Home/Navigation_Pages/Profile.dart';
import 'package:van_lines/services/Database.dart';

class Auth_service {

  final FirebaseAuth _auth = FirebaseAuth.instance;
// create a user object based on the firebase user
  UserFB? userFromFirebase(User? user){
    return user != null ? UserFB(uid: user.uid) : null;
  }

  //auth change of user stream
  Stream<UserFB?> get Userx{
    return _auth.authStateChanges().map(userFromFirebase);
  }

  Future registerWEP(String email, String password,String First_name,String Last_name,String Phone_number) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create a new document for the user with uid
      await DatabaseService(uid: user!.uid).updateUserData(First_name,Last_name, Phone_number);
      // ProfileState().user(user!.uid);
      // DatabaseService(uid:user!.uid).getuserInfo(user!.uid);
      return userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

    //sign in with email and password

    Future Signin_WEP(email, password) async {
      try {
        // await Firebase.initializeApp();
        UserCredential result = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        User? user = result.user;
        DatabaseService(uid:user!.uid).getuserInfo();
        // print(DatabaseService(uid:user!.uid).getuserInfo(user!.uid));
        // ProfileState().user(user!.uid);
        print(user);
        return userFromFirebase(user);

        //create a new document for the user with uid
        // await databaseservice(uid: user!.uid).updateUserData('0', 'new_member', 100);
        // return _userfromfirebaseuser(user);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }

  // sign out
  Future sign_out() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  }
