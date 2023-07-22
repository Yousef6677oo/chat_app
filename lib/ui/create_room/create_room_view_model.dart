import 'package:chat/base/base.dart';
import 'package:chat/model/room.dart';

import '../../data_base/my_database.dart';

abstract class CreateRoomNavigator extends BaseNavigator {}

class CreateRoomViewModel extends BaseViewModel<CreateRoomNavigator> {

  Future<void> addRoom(String name, String description,
      String categoryId) async {
    navigator?.showLoadingDialog();
    try{
      var result =await MyDataBase.createRoom(Room(name: name,categoryId: categoryId,description: description));
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(message: "Room Created Successfully");
    }catch(e){
      navigator?.hideLoadingDialog();
      navigator?.showMessageDialog(message: "something went wrong ${e.toString()}");
    }
  }
}
