import 'package:firebase_auth/firebase_auth.dart';
import '../../base/base.dart';

abstract class SignUpNavigator extends BaseNavigator {}

class SignUpViewModel extends BaseViewModel<SignUpNavigator> {
  var authService = FirebaseAuth.instance;

  Future<void> signUp(String email, String password) async {
    try {
      navigator?.showLoadingDialog();
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      navigator?.hideLoadingDialog();
      //todo: you Should link account with id and name
    } on FirebaseAuthException catch (exception) {
      navigator?.hideLoadingDialog();
      if (exception.code == 'weak-password') {
        navigator?.showMessageDialog(
            message:
                "weak password. please try another one with character length more than 6");
      } else if (exception.code == 'email-already-in-use') {
        navigator?.showMessageDialog(
            message: "the email is already in use please try another one");
      }
    } catch (e) {
      navigator?.showMessageDialog(
          message: "the email is already in use please try another one");
    }
  }
}
