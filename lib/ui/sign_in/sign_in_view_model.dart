import 'package:firebase_auth/firebase_auth.dart';
import '../../base/base.dart';

abstract class SignInNavigator extends BaseNavigator {}

class SignInViewModel extends BaseViewModel<SignInNavigator> {
  var authService = FirebaseAuth.instance;

  void signIn(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      navigator?.hideLoadingDialog();
      //todo: you should Navigator.pushReplacementNamed();
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
