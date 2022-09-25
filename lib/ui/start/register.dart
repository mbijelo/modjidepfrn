import 'dart:io';
import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modjiappfournisseur/model/model.dart';
import 'package:modjiappfournisseur/ui/start/reg_map_work_area.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../strings.dart';
import '../theme.dart';
import '../../model/model.dart';
import '../dialog/no_internet.dart';


class OnDemandRegisterCodeScreen extends StatefulWidget {
  @override
  _OnDemandRegisterCodeScreenState createState() => _OnDemandRegisterCodeScreenState();
}

class _OnDemandRegisterCodeScreenState extends State<OnDemandRegisterCodeScreen> {
  
  double windowWidth = 0;
  double windowHeight = 0;
  final _editControllerName = TextEditingController();
  final _editControllerEmail = TextEditingController();
  final _editControllerPassword1 = TextEditingController();
  final _editControllerPassword2 = TextEditingController();
  final _editControllerProviderName = TextEditingController();
  final _editControllerPhone = TextEditingController();
  final _editControllerDesc = TextEditingController();
  final _editControllerAddress = TextEditingController();
  var _step = 1;
  late MainModel _mainModel;
  List<String> category = [];

  @override
  void initState() {
    _mainModel = Provider.of<MainModel>(context, listen: false);
    _init();
    super.initState();
  }

  _init() async {
    var ret = await loadCategory(true);
    if (ret != null)
      messageError(context, ret);
    _redraw();
  }

  @override
  void dispose() {
    _editControllerName.dispose();
    _editControllerEmail.dispose();
    _editControllerPassword1.dispose();
    _editControllerPassword2.dispose();
    _editControllerProviderName.dispose();
    _editControllerPhone.dispose();
    _editControllerDesc.dispose();
    _editControllerAddress.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    buildContext = context;
    mainWindowHeight = windowHeight;

    _mainModel.setMainWindow(_openDialog);

    return Scaffold(
        backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,
        body: Directionality(
        textDirection: strings.direction,
        child: Stack(
          children: <Widget>[

            Container(
              color: (theme.darkMode) ? Colors.black : Colors.white,
              child: SingleChildScrollView(
                child: Column(

                  children: [

                    ClipPath(
                        clipper: ClipPathClass23(20),
                        child: Container(
                         // color: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
                          color: (theme.darkMode) ? theme.blackColorTitleBkg : Colors.black54,
                          width: windowWidth,
                          height: windowHeight*0.3,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 20, right: 20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(strings.get(14), // "Register",
                                              style: theme.style25W800),
                                          SizedBox(height: 10,),
                                          Text(strings.get(15), // "in less than a minute",
                                              style: theme.style10W600White1),
                                        ],
                                      ))),

                              Container(
                                /*
                                  margin: EdgeInsets.only(bottom: 20),
                                  alignment: Alignment.bottomRight,
                                  width: windowWidth*0.3,
                                  child: Image.asset("assets/ondemand/ondemand5.png",
                                      fit: BoxFit.contain
                                  )
                              */
                              )
                            ],


                          ),
                        )),

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: _step == 1 ? Column(
                      children: [

                        SizedBox(height: 20,),

                        Text(strings.get(188), /// Please leave information for us to make it easier for us to work with you.
                            style: theme.style14W400, textAlign: TextAlign.center,),
                        SizedBox(height: 10,),
                        Divider(),




                        SizedBox(height: 10,),
                        edit42(strings.get(189), /// "Provider Name",
                          _editControllerProviderName, strings.get(189), // "Name service",
                        ),
                        /*
                        edit42(strings.get(65), /// "Description",
                          _editControllerDesc, "",
                        ),
                        SizedBox(height: 20,),
                        edit42(strings.get(63), /// "Address",
                          _editControllerAddress, "",
                        ),
                        SizedBox(height: 20,),

                        button2c(strings.get(193), theme.mainColor, (){ /// "Set my Work Area",
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegMapWorkAreaScreen(),
                            ),
                          );
                        }),

                        SizedBox(height: 10,),
                        Divider(),
                        SizedBox(height: 10,),

                        Text(strings.get(167), style: theme.style14W800,), /// "Categories",
                        SizedBox(height: 5,),
                        TreeInCategory(
                          stringCategoryTree: strings.get(263), /// "Category tree",
                          select: (CategoryData item) {
                            if (category.contains(item.id))
                              category.remove(item.id);
                            else
                              category.add(item.id);
                            _redraw();
                          },
                          showDelete: false,
                          useKey: false,
                          showCheckBoxes: true,
                          stringOnlySelected: strings.get(166), /// "Only selected",
                          getSelectList: (){
                            return category;
                          },
                        ),

                        SizedBox(height: 20,),
                        Divider(),

                        Column(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(theme.radius)),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      child: _mainModel.pathToImage.isNotEmpty
                                          ? Image.file(File(_mainModel.pathToImage), fit: BoxFit.cover)
                                          : Image.asset("assets/noimage.png", fit: BoxFit.cover),
                                    )
                                  ],
                                )),
                            SizedBox(height: 10,),
                            button2c(strings.get(194), theme.mainColor, _changeIcon),  /// "Set Provider Logo",
                          ],
                        ),



                       // Divider(),

                         */
                        SizedBox(height: 10,),
                        SizedBox(height: 10,),

                        edit42(strings.get(192), /// "Phone",
                            _editControllerPhone, "", type: TextInputType.phone
                        ),

                        //SizedBox(height: 20,),

                        //
                        //
                        //

                 /*

                        edit42(strings.get(191), /// "Login",
                          _editControllerName, "",
                        ),

                        SizedBox(height: 20,),

                        edit42(strings.get(7), /// "Email",
                            _editControllerEmail,
                            strings.get(8), // "Enter Email",
                            type: TextInputType.emailAddress
                        ),
*/
                        SizedBox(height: 20,),

                        Edit43(
                          text: strings.get(9), /// "Password",
                          controller: _editControllerPassword1,
                          hint: strings.get(10), // "Enter Password",
                        ),

                        SizedBox(height: 20,),

                        Edit43(
                          text: strings.get(18), /// "Confirm Password",
                          controller: _editControllerPassword2,
                          hint: strings.get(10), // "Enter Password",
                        ),

                        SizedBox(height: 40,),

                        button2(strings.get(11), /// "CONTINUE",
                            theme.mainColor, (){_continue();}, style: theme.style16W800White, radius: 50
                        ),

                        SizedBox(height: 20,),

                      ],
                    ) : step2Widget())

                  ],
                ) ,
              ),
            ),

            appbar1(Colors.transparent, (theme.darkMode) ? Colors.white : Colors.white,
                "", context, () {Navigator.pop(context);}),


            IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: Colors.grey,
              getBody: _getBody_Register, backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,),


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


  _getBody_Register(){

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

  _continue() async {
    /*
    var providerJeanLouis = await FirebaseFirestore.instance.collection("provider").where('login', isEqualTo: "42900378@modjidep.com").get();
    for (var result in providerJeanLouis.docs) {
       var _data = result.data();
      if (_data.isNotEmpty){
        var providerJeanLouis1 = ProviderData.fromJson(result.id, _data);
        dprint(providerJeanLouis1.logoServerPath);
       }
     }
     */

    _editControllerDesc.text = "Description ici";
    _editControllerAddress.text = "Mauritanie";
    //_mainModel.pathToImage = "https://firebasestorage.googleapis.com/v0/b/modjiapp-60a7b.appspot.com/o/provider%2F6f2f45d4-b478-4981-9f3b-19253ead31df.jpg?alt=media&token=63cecccf-1a72-49fa-b9c7-f4464a7c3efc";
    _mainModel.routeForNewProvider = [LatLng(32.75697368676375, -22.313876822590828), LatLng(31.835150402611927, 4.878174439072609), LatLng(3.450759843853191, 5.375268906354904), LatLng(2.6434009797758975, -20.24089302867651)];
    //category = ["zjEdSQ0yl3NhaKRzQJIa"];
    _editControllerName.text =  _editControllerPhone.text ;

    if (_editControllerProviderName.text.isEmpty)
      return messageError(context, strings.get(195)); /// "Please Enter Provider Name",
    if (_editControllerPhone.text.isEmpty)
      return messageError(context, strings.get(187)); /// "Please Enter Phone",


    if (_editControllerDesc.text.isEmpty)
      return messageError(context, strings.get(196)); /// "Please Enter description",
    if (_editControllerAddress.text.isEmpty)
      return messageError(context, strings.get(197)); /// "Please Enter address",
    /*
    if (_mainModel.pathToImage.isEmpty)
      return messageError(context, strings.get(198)); /// "Please upload Provider Logo",
     */

    //_mainModel.routeForNewProvider = "30.519162541273083,-16.88613686710596; 28.986333053987636,1.4196593686938286; 17.925818520535657,8.196697309613228; 6.406512003803913,-3.302847035229206; 11.381640665656484,-19.115939363837242";
    if (_mainModel.routeForNewProvider.isEmpty)
      return messageError(context, strings.get(199)); /// "Please select work area",

/*
    if (category.isEmpty)
      return messageError(context, strings.get(200)); /// "Please select Category where you will work",
    */
    if (_editControllerName.text.isEmpty)
      return messageError(context, strings.get(201)); /// "Please Enter Login",



    _editControllerEmail.text = _editControllerPhone.text + "@modjidep.com";
    if (_editControllerEmail.text.isEmpty)
      return messageError(context, strings.get(93)); /// "Please Enter Email",






    if (_editControllerPassword1.text.isEmpty || _editControllerPassword2.text.isEmpty)
      return messageError(context, strings.get(94)); /// "Please enter password",
    if (_editControllerPassword1.text != _editControllerPassword2.text)
      return messageError(context, strings.get(97)); /// "Passwords are not equal",
    if (!validateEmail(_editControllerEmail.text))
      return messageError(context, strings.get(98)); /// "Email are wrong",

    _waits(true);
    var ret = await registerProvider(_editControllerEmail.text,
        _editControllerPassword1.text, _editControllerName.text,
        _editControllerProviderName.text, _editControllerPhone.text, _editControllerDesc.text,
        _editControllerAddress.text, category, _mainModel.pathToImage, _mainModel.routeForNewProvider);
    _waits(false);
    if (ret != null)
      return messageError(context, ret);

    _step = 2;
    _redraw();
  }

  step2Widget(){
    return Column(
      children: [
        SizedBox(height: 40,),
        Text(strings.get(100), style: theme.style14W800H, textAlign: TextAlign.center,) /// You account created. After moderation your account...
      ],
    );
  }

  _changeIcon() async {
    final pickedFile = await ImagePicker().pickImage(
        maxWidth: 400,
        maxHeight: 400,
        source: ImageSource.gallery);
    if (pickedFile != null) {
      dprint("Photo file: ${pickedFile.path}");
      _mainModel.pathToImage = pickedFile.path;
      _redraw();
    }
  }

}


