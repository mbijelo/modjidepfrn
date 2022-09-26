import 'dart:math';
import 'package:abg_utils/abg_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modjiappfournisseur/ui/start/login.dart';
import 'package:provider/provider.dart';
import '../model/model.dart';
import 'strings.dart';
import 'theme.dart';
import 'package:modjiappfournisseur/widgets/cards/card42button.dart';
//import 'dialogs/no_internet.dart';

class DeleteProfileScreen extends StatefulWidget {
  @override
  _DeleteProfileScreenState createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen>  with TickerProviderStateMixin{

  double windowWidth = 0;
  double windowHeight = 0;
  double windowSize = 0;
  final _editControllerName = TextEditingController();
  final _editControllerEmail = TextEditingController();
  final _editControllerPhone = TextEditingController();
  final _editControllerPassword1 = TextEditingController();
  final _editControllerPassword2 = TextEditingController();

  late MainModel _mainModel;
  String _dialogName = "";
  bool PasDeNom = false;

  @override
  void initState() {
    _mainModel = Provider.of<MainModel>(context,listen:false);
    _editControllerEmail.text = userAccountData.userEmail;
    _editControllerName.text = userAccountData.userName;
    _editControllerPhone.text = userAccountData.userPhone;
    super.initState();
  }

  @override
  void dispose() {
    _editControllerName.dispose();
    _editControllerEmail.dispose();
    _editControllerPhone.dispose();
    _editControllerPassword1.dispose();
    _editControllerPassword2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    windowSize = min(windowWidth, windowHeight);

    _mainModel.setMainWindow(_openDialog);


    var _enablePhoneEdit = true;
    if (appSettings.isOtpEnable())
      _enablePhoneEdit = false;
    if (userAccountData.userSocialLogin.isNotEmpty)
      _enablePhoneEdit = true;

    return Scaffold(
        backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
        body: Directionality(
            textDirection: strings.direction,
            child: Stack(
              children: <Widget>[

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+130, left: 20, right: 20),
                  child: ListView(
                    children: [

                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                        decoration: BoxDecoration(
                          color: (theme.darkMode) ? Colors.black : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            edit42("", // "Name",
                              _editControllerName,
                              "", // "Enter your name",
                            ),
                            if(PasDeNom)
                              SizedBox(height: 2,),
                            if(PasDeNom)
                              Text(strings.get(153),

                                  /// no name
                                  style: TextStyle(letterSpacing: 0.6,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.red)),

                            SizedBox(height: 20,),

                            if (userAccountData.userSocialLogin.isEmpty)
                              edit42("", // "Email",
                                  _editControllerEmail,
                                  "", // "Enter your Email",
                                  enabled: false, type: TextInputType.text
                              ),

                            SizedBox(height: 20,),

                            edit42("", // "Phone number",
                                _editControllerPhone,
                                "", // "Enter your Phone number",
                                style: _enablePhoneEdit ? theme.style15W400 : theme.style14W600Grey,
                                enabled: _enablePhoneEdit, type: TextInputType.phone
                            ),
                            if (!_enablePhoneEdit)
                              SizedBox(height: 5,),
                            if (!_enablePhoneEdit)
                              Text(strings.get(231), style: theme.style12W600Orange,), /// Your phone number verified. You can't edit phone number

                            SizedBox(height: 20,),

                            Container(
                              margin: EdgeInsets.all(20),
                              child: button2(strings.get(277), theme.mainColor, _changeInfo), /// "SAVE",
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20,),

                      if (userAccountData.userSocialLogin.isEmpty)
                        Column(),

                      SizedBox(height: 120,),
                    ],
                  ),
                ),

                InkWell(
                    onTap: _photo,
                    child: ClipPath(
                        clipper: ClipPathClass23(20),
                        child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                            width: windowWidth,
                            child: card422button(
                                '', /// "My Profile",
                                theme.style20W800,
                                '', /// "Everything about you",
                                theme.style14W600Grey,
                                Container( ),
                                CachedNetworkImage(
                                    imageUrl: userAccountData.userAvatar,
                                    imageBuilder: (context, imageProvider) => Container(
                                      child: Container(
                                      ),
                                    )
                                ) ,

                                windowWidth, (theme.darkMode) ? Colors.black : Colors.white, _photo, "profile2"
                            )
                        ))),

                appbar1(Colors.transparent, (theme.darkMode) ? Colors.white : Colors.black, "", context, () {
                  Navigator.pop(context);
                }),

/*
                IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: Colors.grey,
                  getBody: _getDialogBodyOfProfil, backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,),
                */

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

  _openDialog(String val){
    _dialogName = val;
    _show = 1;
    _redraw();
  }



/*
  Widget _getDialogBodyOfProfil(){

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



    if(text=="otp [firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user."){
      text= strings.get(225);
      trouve = true;
    }

    else if(text=="model login [firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
      text= strings.get(137);
      trouve = true;
    }

    else if(text=="model login [firebase_auth/wrong-password] The password is invalid or the user does not have a password."){
      text= strings.get(45);
      trouve = true;
    }

    else if(text=="model login [firebase_auth/unknown] com.google.firebase.FirebaseException: An internal error has occurred. [ unexpected end of stream on com.android.okhttp.Address@92f413c0 ]"){
      text= strings.get(292);
      trouve = true;
    }
    else {
      var increment = 0;
      while (increment < 1000) {
        if (strings.get(increment) == text){
          trouve = true;
          break;
        }
        increment++;
      }
    }



    dprint("trouve:"+text);

    if(trouve) {
      if (dialogName == "getError")
        return getError(() {
          _show = 0;
          _redraw();
        }, _mainModel, context, text);
    }else {
      return getError(() {
        _show = 0;
        _redraw();
      }, _mainModel, context, "");
    }


    if (dialogName == "AfterOtpConfirmWell")
      return getMessageAfterOtpWell((){
        _show = 0;
        _redraw();
      }, _mainModel, context, text);



    return getBodyDialogExit(strings.get(178), strings.get(179), strings.get(180),
            (){_show = 0;_redraw();});  /// Are you sure you want to exit? No Exit
  }
*/

















  _photo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
    dprint('photo');
    }
  }

  _changePassword() async {
    if (_editControllerPassword1.text.isEmpty)
      return messageError(context, strings.get(34)); /// "Enter Password"
    if (_editControllerPassword2.text.isEmpty)
      return messageError(context, strings.get(151)); /// "Enter Confirm Password"
    if (_editControllerPassword1.text != _editControllerPassword2.text)
      return messageError(context, strings.get(140)); /// "Passwords are not equal",

    _waits(true);
    var ret = await changePassword(_editControllerPassword1.text);
    _waits(false);
    if (ret != null)
      messageError(context, ret);
    else
      messageOk(context, strings.get(152)); /// "Password changed",
  }

  _changeInfo() async {
    dprint("sauvegarder clic");
    if (_editControllerName.text.isEmpty) {
      PasDeNom = true;
      setState(() {});
      return messageError(context, strings.get(153)); /// "Please Enter name"
    }else{
      PasDeNom = false;
    }
    if (_editControllerEmail.text.isEmpty)
      return messageError(context, strings.get(135)); /// "Please Enter email"
    if (_editControllerPhone.text.isEmpty)
      return messageError(context, strings.get(209)); /// "Please Enter phone"

    _waits(true);
    var ret = await changeInfo(_editControllerName.text,
        //"42900379@modjidep.com", "+22242900379");
        _editControllerPhone.text+"310190@modjidep.com", appSettings.otpPrefix+_editControllerPhone.text+"310190");
    _waits(false);
    if (ret != null)
      messageError(context, ret);
    else
      logoutt();
      //messageOk(context, strings.get(154)); /// "Data saved",
  }






















  card422button(
      String text1, TextStyle text1Style,
      String text2, TextStyle text2Style,
      Widget bkgWidget,
      Widget userWidget,
      double windowWidth, Color bkgColor,
      Function() onClickText2,
      String x
      ){
    return InkWell(
        onTap: onClickText2,
        child: Container(
            width: windowWidth,
            color: Colors.transparent,
            padding: EdgeInsets.only(left: 20, top: 0, bottom: 10, right: 20),
            child: Stack(
              children: [
                /*
          Container(
              alignment: Alignment.bottomRight,
              height: 130,
              child: Container(
                width: windowWidth/2,
                child: bkgWidget,)
          ),
          */
                Container(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:  [
                          Text(text1, style: text1Style),
                          //Text(text2, style: text2Style),
                          // <-- Text

                        ] ,
                      )),
                      Container(
                          width: windowWidth*0.4,
                          padding: EdgeInsets.only(bottom: 0),
                          height: 100,
                          alignment: Alignment.bottomRight,
                          child: userWidget
                      )

                    ],
                  ),
                )
              ],
            )
        ));
  }




  logoutt() async {
    if (!kIsWeb){
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null)
        FirebaseFirestore.instance.collection("listusers").doc(user.uid).set({
          "FCB": "",
        }, SetOptions(merge:true)).then((value2) {});
    }
    await FirebaseAuth.instance.signOut();
    dprint("=================logout===============");
    if (userAccountData.userSocialLogin == "facebook")
      FacebookAuth.instance.logOut();
    // if (userAccountData.userSocialLogin == "google")

    userAccountData = UserAccountData.createEmpty();
    //
    localSettings.saveLogin("", "", "");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );

  }



}


