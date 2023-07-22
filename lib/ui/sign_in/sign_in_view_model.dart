import 'package:firebase_auth/firebase_auth.dart';

import '../../base/base.dart';
import '../../data_base/my_database.dart';
import '../../shared_data.dart';

abstract class SignInNavigator extends BaseNavigator {
  void navigateToHomeScreen();
}

class SignInViewModel extends BaseViewModel<SignInNavigator> {
  var authService = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      navigator?.hideLoadingDialog();
      var retrievedUser = await MyDataBase.getUserById(credential.user!.uid);
      if (retrievedUser != null) {
        SharedData.user = retrievedUser;
        navigator?.navigateToHomeScreen();
      } else {
        navigator?.showMessageDialog(
            message: 'something went wrong,\nwrong user name or password');
      }
    } on FirebaseAuthException catch (exception) {
      navigator?.hideLoadingDialog();
      if (exception.code == 'user-not-found') {
        navigator?.showMessageDialog(message: "No user found for that email.");
      } else if (exception.code == 'wrong-password') {
        navigator?.showMessageDialog(
            message: "Wrong password provided for that user.");
      }
    } catch (e) {
      navigator?.showMessageDialog();
    }
  }
}
