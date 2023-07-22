import 'package:chat/data_base/my_database.dart';
import 'package:chat/model/my_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../base/base.dart';
import '../../shared_data.dart';

abstract class SignUpNavigator extends BaseNavigator {
  void navigateToHomeScreen();
}

class SignUpViewModel extends BaseViewModel<SignUpNavigator> {
  var authService = FirebaseAuth.instance;

  Future<void> signUp(String email, String password, String firstName) async {
    try {
      navigator?.showLoadingDialog();
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      MyUser newUser = MyUser(
        id: credential.user?.uid,
        email: email,
        firstName: firstName,
      );
      var insertedUser = await MyDataBase.insertUser(newUser);
      navigator?.hideLoadingDialog();
      if (insertedUser != null) {
        SharedData.user = insertedUser;
        navigator?.navigateToHomeScreen();
      } else {
        navigator?.showMessageDialog(
            message: "something went wrong, error with database");
      }
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
