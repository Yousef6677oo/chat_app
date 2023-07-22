import 'package:chat/base/base.dart';
import 'package:chat/ui/create_room/create_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/room_category.dart';
import '../../utilities/dialog_utils.dart';

class CreateRoomScreen extends StatefulWidget {
  static String routeName = "create_room_screen";

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState
    extends BaseState<CreateRoomScreen, CreateRoomViewModel>
    implements CreateRoomNavigator {
  @override
  CreateRoomViewModel initViewModel() {
    return CreateRoomViewModel();
  }

  var formKey = GlobalKey<FormState>();
  bool isSelectedCategory=false;
  TextEditingController roomNameController = TextEditingController();
  TextEditingController roomDescriptionController = TextEditingController();
  List<RoomCategory> roomCategoryList = RoomCategory.getRoomCategories();
  RoomCategory? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => viewModel,
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/sign_in_bg.png"))),
            child: Scaffold(
              resizeToAvoidBottomInset : false,
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                toolbarHeight: MediaQuery.of(context).size.height * 0.14,
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  "Chat App",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                centerTitle: true,
              ),
              body: Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 15,
                        child: Card(
                          color: const Color(0xffffffff),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                          elevation: 12,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                const Text(
                                  "Create New Room",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff383838)),
                                  textAlign: TextAlign.center,
                                ),
                                Image.asset("assets/group_of_people.png"),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: "Enter  Room Name",
                                            labelStyle: TextStyle(
                                                color: Color(0xffA9A9A9),
                                                fontSize: 18)),
                                        controller: roomNameController,
                                        validator: (text){
                                          if(text==null||text.trim().isEmpty){
                                            return "please enter room name";
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.03),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: DropdownButton<RoomCategory>(
                                          isExpanded: true,
                                            iconSize: 0,
                                            underline: Container(),
                                            value: dropdownValue,
                                            items: roomCategoryList
                                                .map((category) {
                                              return DropdownMenuItem<
                                                      RoomCategory>(
                                                  value: category,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Image.asset(category
                                                          .imagePathRoom),
                                                      Text(category.nameRoom)
                                                    ],
                                                  ));
                                            }).toList(),
                                            hint: hintDropDownValue(),
                                            onChanged: (value) {
                                              if (value == null) {
                                                return;
                                              }
                                              setState(() {
                                                isSelectedCategory=true;
                                                dropdownValue = value;
                                              });
                                            }
                                            ),
                                      ),
                                      TextFormField(
                                        maxLines: 3,
                                        minLines: 2,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Enter  Room Description",
                                            labelStyle: TextStyle(
                                                color: Color(0xffA9A9A9),
                                                fontSize: 18)),
                                        controller: roomDescriptionController,
                                        validator: (text){
                                          if(text==null||text.trim().isEmpty){
                                            return "please enter room description";
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.06),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.10),
                                  child: ElevatedButton(
                                      onPressed: (){
                                        submit();
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          )),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff3598DB))),
                                      child: const Padding(
                                        padding: EdgeInsets.all(17.0),
                                        child: Text(
                                          "Create",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xffffffff)),
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(flex: 2)
                    ],
                  ),
                ),
              ),
            )));
  }

  hintDropDownValue() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.79,
      decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff707070), width: 1)),
      child: const Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Select Room Category",
                style: TextStyle(fontSize: 18, color: Color(0xffA9A9A9))),
            ImageIcon(AssetImage("assets/arrow_drop_down.png"))
          ],
        ),
      ),
    );
  }

  void submit() {
    if(formKey.currentState?.validate()==false || isSelectedCategory==false){
      if(isSelectedCategory==false){
        DialogUtils.showMyDialog(context: context,message: "please select room category");
      }
      return;
    }
    viewModel.addRoom(roomNameController.text, roomDescriptionController.text, dropdownValue!.idRoom);
  }
}
