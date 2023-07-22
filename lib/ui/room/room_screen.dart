import 'package:chat/base/base.dart';
import 'package:chat/ui/room/room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomScreen extends StatefulWidget {
  static String routeName = "room_screen";

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends BaseState<RoomScreen,RoomViewModel> implements RoomNavigator{
  bool joinRoom = false;
  @override
  RoomViewModel initViewModel() {
    return RoomViewModel();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context){
        return viewModel;
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage("assets/sign_in_bg.png"))),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: MediaQuery.of(context).size.height * 0.15,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "The Movies Zone",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.0),
                  child: ImageIcon(AssetImage("assets/three_dots.png")),
                ),
              ],
            ),
            body: joinRoom?room():joinToRoom()
        ),
      ),
    );
  }

  Widget joinToRoom() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      elevation: 10,
      color: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text(
              "Hello, Welcome to our chat room",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            //todo: will change Movies zone to selected zone
            const Text(
              "Join The Movies Zone!",
              style: TextStyle(
                  wordSpacing: 5, fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            //todo: will change Movies image to selected image
            Image.asset(
              "assets/test_room_image.png",
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            //todo: will change Movies description to selected description
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.08),
              child: const Text(
                "Lorem ipsum dolor sit amet, consectetur elit, sed do eiusmod tempor incididunt ut labore et  dolore magna aliqua. Ut enim ad minim veniam,  quis nostrud exercitation ullamco laboris nisi ut  aliquip ex ea commodo consequat. Duis aute irure",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.03,
                  horizontal: MediaQuery.of(context).size.width * 0.22),
              child: ElevatedButton(
                onPressed: () {
                    setState(() {
                      joinRoom = true;
                    });
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff3598DB))),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Join",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget room() {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      elevation: 10,
      color: const Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.77,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.035,
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1, color: const Color(0xffA9A8A8)),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15)
                      )
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xff3598DB),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Send",
                            style: TextStyle(
                                fontSize: 15, color: Color(0xffffffff)),
                          ),
                          ImageIcon(
                            AssetImage("assets/send.png"),
                            color: Color(0xffffffff),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.035,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            )
          ],
        ),
      ),
    );
  }
}
