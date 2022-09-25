import 'package:abg_utils/abg_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modjiappfournisseur/model/model.dart';
import 'package:modjiappfournisseur/ui/chat2.dart';
import 'package:modjiappfournisseur/ui/documents.dart';
import 'package:modjiappfournisseur/ui/products/products.dart';
import 'package:modjiappfournisseur/ui/service/edit_service1.dart';
import 'package:modjiappfournisseur/ui/service/services.dart';
import 'package:provider/provider.dart';
import 'jobinfo.dart';
import 'lang.dart';
import 'map_customer.dart';
import 'notify.dart';
import 'strings.dart';
import 'account/account.dart';
import 'bookings.dart';
import 'chat.dart';
import 'theme.dart';
import 'dialog/no_internet.dart';

class OnMainScreen extends StatefulWidget {
  @override
  _OnMainScreenState createState() => _OnMainScreenState();
}

class _OnMainScreenState extends State<OnMainScreen> {
  double windowWidth = 0;
  double windowHeight = 0;
  late MainModel _mainModel;

  @override
  void initState() {
    _mainModel = Provider.of<MainModel>(context,listen:false);
    _mainModel.account.userAndNotifyListen(_redraw, context);
    _init();
    super.initState();
  }

  _init() async {
    _waits(true);
    var ret = await loadCategory(true);
    if (ret != null)
      messageError(context, ret);
    _waits(false);
  }

  bool _wait = false;
  _waits(bool value){
    _wait = value;
    _redraw();
  }
  _redraw(){
    if (mounted)
      setState(() {
      });
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;

    // ignore: unnecessary_statements
    context.watch<MainModel>().chatCount;

    User? user = FirebaseAuth.instance.currentUser;
    _mainModel.setMainWindow(_openDialog);


    if (user == null)
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        Navigator.pop(context);
        Navigator.pushNamed(context, "/ondemand_login");
      });

    var count = context.watch<MainModel>().numberOfUnreadMessages;
    if (_state == "notify" && count != 0)
      _mainModel.numberOfUnreadMessages = 0;

    _mainModel.state = _state;

    drawState(_state, _route, context, _redraw, strings.locale, _waits, windowWidth, windowHeight);

    return WillPopScope(
        onWillPop: () async {
          if (_show != 0){
            _show = 0;
            return false;
          }
          if (_state == "home" || _state == "booking" || _state == "chat" || _state == "notify" || _state == "account"){
            _dialogName = "exit²ok";
            _show = 1;
            _redraw();
            return false;
          }
        goBack();
        return false;
    },
    child: Scaffold(
        backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
        body: Directionality(
        textDirection: strings.direction,
        child: Stack(
          children: <Widget>[

            if (_state == "home")
              ServicesAllScreen(),
            if (_state == "chat")
              ChatScreen(),
            if (_state == "booking")
              BookingScreen(),
            if (_state == "account")
              AccountScreen(redraw: _redraw),
            if (_state == "notify")
              NotifyScreen(),

            Container(
              alignment: Alignment.bottomCenter,
              child: BottomBar13(colorBackground: (theme.darkMode) ? Colors.black : Colors.black,
                  colorSelect: Colors.white,
                  colorUnSelect: Colors.grey,
                  textStyle: theme.style10W600Grey,
                  textStyleSelect: theme.style12W800MainColor,
                  radius: theme.radius,
                  callback: (int y){
                    if (y == 0) _state = "home";
                    if (y == 1) _state = "chat";
                    if (y == 2) _state = "booking";
                    if (y == 3) _state = "account";
                    if (y == 4) _state = "notify";
                    setState(() {
                    });
                  }, //initialSelect: _currentPage,
                  getItem: (){
                    switch(_state){
                      case "home":
                        return 0;
                      case "chat":
                        return 1;
                      case "booking":
                        return 2;
                      case "account":
                        return 3;
                      case "notify":
                        return 4;
                    }
                    return 0;
                  },
                  text: [strings.get(299), /// "Home",
                    strings.get(26), /// "Chat",
                    strings.get(27),      /// "Booking",
                    strings.get(28),      /// "Account"
                    strings.get(89),      /// "Notifications"
                  ],
                  icons: ["assets/ondemand/service.png",
                    "assets/ondemand/001-chat.png",
                    "assets/ondemand/031-book.png",
                    "assets/ondemand/008-user.png",
                    "assets/notifyicon.png",
                  ],
                getUnreadMessages: (int index) {
                  if (index == 1)
                    return _mainModel.chatCount;
                  if (index == 2)
                    return newBookingCount;
                  if (index == 4)
                    return _mainModel.numberOfUnreadMessages;
                  return 0;
                },
              ),
            ),

            if (_state == "chat2")
              Chat2Screen(),
            if (_state == "language")
              LanguageScreen(openLogin: false, redraw: _redraw),
            if (_state == "policy" || _state == "about" || _state == "terms")
              PolicyScreen(source: _state),
            if (_state == "jobinfo")
              JobInfoScreen(),
            if (_state == "services")
              ServicesAllScreen(),
            if (_state == "mapCustomer")
              MapCustomerScreen(),
            if (_state == "products")
              ProductsAllScreen(),

            IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: Colors.grey,
              getBody: _getBody, backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,),

            if (_wait)
              Center(child: Container(child: Loader7v1(color: theme.mainColor,))),

          ],
        ))

    ));
  }

  String _state = "booking";

  _route(String state) {
    _state = state;
    if (_state.isEmpty)
      _state = "booking";
    _redraw();
  }

  double _show = 0;
  String _dialogName = "";

  _openDialog(String val){
    _dialogName = val;
    _show = 1;
    _redraw();
  }


  _getBody(){

    var i = 0;
    var dialogName = "";
    var text = "";
    while(i < _dialogName.length){
      if(_dialogName[i] != '²') {
        dialogName = dialogName+_dialogName[i];

      }
      else{
        break;
      }
      i++;
    }
    dprint("dialogName : " + dialogName);
    i++;
    while(i < _dialogName.length){
      text = text+_dialogName[i];
      i++;
    }
    dprint("text : " + text);


    var trouve = false;

    if(text=="model login [firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
      text= strings.get(95);
      trouve = true;
    }

    else if(text=="model login [firebase_auth/wrong-password] The password is invalid or the user does not have a password."){
      text= strings.get(10);
      trouve = true;
    }

    else if(text=="model login [firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ unexpected end of stream on com.android.okhttp.Address@92f413c0 ]"){
      text= strings.get(278);
      trouve = true;
    }
    else {
      var increment = 0;
      while (increment < 1000) {
        if (strings.get(increment) != "") {
          if (strings.get(increment) == text) {
            dprint("jean" + strings.get(increment) + "==" + text);
            trouve = true;
          }
        }
        increment++;
      }
    }
    dprint("jean" + trouve.toString());
    if(trouve){


      if (dialogName == "getError")
        return getError((){
          _show = 0;
          _redraw();
        }, _mainModel, context, text);


    }
    else {
      if (dialogName == "getError")
        return getError(() {
          _show = 0;
          _redraw();
        }, _mainModel, context, "");
    }


    if (dialogName == "exit")
      return getBodyDialogExit(strings.get(207), strings.get(146), strings.get(208),
              (){_show = 0;_redraw();});  /// Are you sure you want to exit? No Exit
    return Container();
  }




}


