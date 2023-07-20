import 'package:flutter/material.dart';

import '../../utilities/dialog_utils.dart';

abstract class BaseNavigator {
  void showLoadingDialog();

  void hideLoadingDialog();

  void showMessageDialog(
      {String message = "something went wrong, please try again later"});
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void hideLoadingDialog() {
    DialogUtils.hideLoading(context);
  }

  @override
  void showLoadingDialog() {
    DialogUtils.showLoading(context);
  }

  @override
  void showMessageDialog(
      {String message = "something went wrong, please try again later"}) {
    DialogUtils.showMyDialog(context: context, message: message);
  }
}
