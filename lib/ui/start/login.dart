import 'dart:math';
import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
import '../dialog/no_internet.dart';
import '../strings.dart';
import '../theme.dart';
import 'package:cached_network_image/cached_network_image.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  double windowWidth = 0;
  double windowHeight = 0;
  double windowSize = 0;
  final _editControllerEmail = TextEditingController();
  final _editControllerPassword = TextEditingController();
  late MainModel _mainModel;

  @override
  void dispose() {
    _editControllerEmail.dispose();
    _editControllerPassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _mainModel = Provider.of<MainModel>(context,listen:false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    windowSize = min(windowWidth, windowHeight);

    _mainModel.setMainWindow(_openDialog);

    return Scaffold(
      backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,
        body: Directionality(
        textDirection: strings.direction,
        child: Stack(
          children: <Widget>[


            ListView(
              children: [
                ClipPath(
                    clipper: ClipPathClass23(20),
                    child: Container(
                     // color: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
                      color: (theme.darkMode) ? theme.blackColorTitleBkg : Colors.black54,
                      width: windowWidth,
                      height: windowHeight/3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: windowHeight*0.05,),
                          Container(
                            width: windowWidth*0.2,
                            height: windowWidth*0.2,
                            child: Image.asset("assets/ondemand/ondemand1-cercle.png", fit: BoxFit.contain)

                          ),
                          SizedBox(height: 20,),
                          Text(strings.get(1), // "PROVIDER",
                              style: theme.style10W600White),
                          SizedBox(height: 20,),
                          Expanded(child: Container(
                            /*
                              width: windowWidth,
                              // height: windowWidth/2,
                              child: Image.asset("assets/ondemand/ondemand2.png",
                                  fit: BoxFit.cover
                              )
                          */)
                          )
                        ],
                      ),
                    )),

                Container(
                  // margin: EdgeInsets.only(top: windowHeight*0.5),
                  height: windowHeight*0.5,
                  color: (theme.darkMode) ? Colors.black : Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Text(strings.get(6), // "Sign in now",
                            style: theme.style16W800,
                          ),
                        ),

                        SizedBox(height: 20,),

                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: edit42(strings.get(20), /// "Email",
                              _editControllerEmail,
                              strings.get(135), // "Enter your Email",
                              type: TextInputType.emailAddress),
                        ),

                        SizedBox(height: 20,),

                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Edit43(
                              text: strings.get(9), // "Password",
                              controller: _editControllerPassword,
                              hint: strings.get(10), // "Enter your Password",
                              ),
                        ),

                        SizedBox(height: 10,),

                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: button2(strings.get(11), // "CONTINUE",
                              theme.mainColor, (){_login();}, style: theme.style16W800White, radius: 50),
                        ),
 /*
                        SizedBox(height: 10,),
                        button134(strings.get(182), /// "Forgot password?",
                                (){
                                  Navigator.pushNamed(context, "/forgot");
                            }, style: theme.style14W400),
                        */
                        SizedBox(height: 5,),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: button2(strings.get(12), // "REGISTER",
                              Colors.black54, (){_register();}, style: theme.style16W800White, radius: 50),
                        ),

                        //
                        // Center(
                        //   child: Text(strings.get(13), // "or continue with",
                        //       style: theme.style14W600Grey),
                        // ),
                        //
                        // SizedBox(height: 10,),
                        //
                        // Container(
                        //     alignment: Alignment.bottomCenter,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         Flexible(child: button195a("Facebook", theme.style16W800White, mainColor, _facebookLogin, true)),
                        //         SizedBox(width: 1,),
                        //         Flexible(child: button196a("Google", theme.style16W800White, mainColor, _googleLogin, true)),
                        //       ],
                        //     )
                        // )
                      ],
                    ),
                  ),
                ),

              ],
            ),

            IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: Colors.grey,
              getBody: _getBody, backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,),

            if (_wait)
              Center(child: Container(child: Loader7v1(color: theme.mainColor,))),

          ],
        )

    ));
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



  _login() async {
    if (_editControllerEmail.text.isEmpty)
      return messageError(context, strings.get(135)); /// "Please Enter num",


    if (_editControllerPassword.text.isEmpty)
      return messageError(context, strings.get(94)); /// "Please Enter Password",

    _waits(true);
    var ret = await loginProvider(_editControllerEmail.text + "@modjidep.com", _editControllerPassword.text, true,
        strings.get(95), /// User not found
        strings.get(205), /// User must be Provider
        strings.get(96)  /// "User is disabled. Connect to Administrator for more information.",
      );
    _waits(false);
    if (ret != null)
      return messageError(context, ret);
    Navigator.pop(context);
    Navigator.pushNamed(context, "/ondemand_main");
  }

  _register(){
    Navigator.pushNamed(context, "/ondemand_register");
  }
}




