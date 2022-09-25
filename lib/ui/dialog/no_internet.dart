import 'dart:io';

import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modjiappfournisseur/model/model.dart';
import 'package:modjiappfournisseur/ui/theme.dart';
import '../strings.dart';

int _type = 1;

/*
test ( _close,   _mainModel,   _editControllerAddress,
      _editControllerName,   _editControllerPhone,   context) async {
dprint("jeanlouis : ");
}
*/

getError(Function() _close, MainModel _mainModel, BuildContext context, text){

  //test(_close,  _mainModel,  _editControllerAddress, _editControllerName,  _editControllerPhone,  context);

  return Column(

    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if(text!="")
      SizedBox(height: 10,),
      if(text!="")
      Center(child: Text(text, /// "Add the location",
          textAlign: TextAlign.center, style: theme.style14W800)),
      /*
        SizedBox(height: 10,),
        Text(strings.get(199), /// "Label as",
            textAlign: TextAlign.start, style: theme.style12W400),
        SizedBox(height: 10,),
        Row(
          children: [
            Expanded(child: button2b(strings.get(190), /// "Home",
                    (){
                  _type = 1;
                  redrawMainWindow();
                },
              style: _type == 1 ? theme.style12W800W : theme.style12W800,
              color: _type == 1 ? theme.mainColor : Colors.grey.withAlpha(80),
            )),
            SizedBox(width: 10,),

            Expanded(child: button2b(strings.get(191), /// "Office",
                    (){
                  _type = 2;
                  redrawMainWindow();
                },
              style: _type == 2 ? theme.style12W800W : theme.style12W800,
              color: _type == 2 ? theme.mainColor : Colors.grey.withAlpha(80),
            )),
            SizedBox(width: 10,),
            Expanded(child: button2b(strings.get(192), /// "Other",
                    (){
                  _type = 3;
                  redrawMainWindow();
                },
              style: _type == 3 ? theme.style12W800W : theme.style12W800,
              color: _type == 3 ? theme.mainColor : Colors.grey.withAlpha(80),
            )),
          ],
        ),
        */
      //SizedBox(height: 10,),
      /*
        SizedBox(height: 5,),
        edit42(strings.get(200), /// "Delivery Address",
            _editControllerAddress,
            //_editControllerName,
            strings.get(201), /// "Enter Delivery Address",
            ),
        SizedBox(height: 5,),
        Text("${strings.get(207)} ${_mainModel.account.latitude} - " /// "Latitude",
            "${strings.get(208)} ${_mainModel.account.longitude}", style: theme.style10W400,), /// "Longitude",
        SizedBox(height: 15,),
        edit42(strings.get(202), /// "Contact name",
            _editControllerName,
            strings.get(203), /// "Enter Contact name",
            ),
        SizedBox(height: 15,),
        edit42(strings.get(204), /// "Contact phone number",
            _editControllerPhone,
            strings.get(205), /// "Enter Contact phone number",
            ),
        */
      if(text!="")
      SizedBox(height: 25,),
      if(text!="")
      Row(
        children: [
          Expanded(//child: button2ww(strings.get(206), /// "Save location",
              child: button2(//strings.get(113), /// "Save location",
                  strings.get(277), /// "Save location",
                  //theme.mainColor,
                  Colors.red,

                      () async {
                    _close();
                    //route("category");


                  }


              ))
        ],
      ),
      if(text!="")
      SizedBox(height: 25,),
/*
        Row(
          children: [
            Expanded(//child: button2ww(strings.get(206), /// "Save location",
                child: button2ww(strings.get(246), /// "Save location",
                    //theme.mainColor,
                    Colors.black54,

                        () async {
                      var ret = await _mainModel.account.saveLocation(_type, _editControllerAddress.text, _editControllerName.text,
                          _editControllerPhone.text);
                      if (ret != null)
                        return messageError(context, ret);
                      _close();
                     // route("service");
                      //route("book");
                      //route("book1");
                      //route("book2");
                      //route("book3");
                      //goBack();
                      if (currentScreen() == "address_add")
                        goBack();

                    }


                ))
          ],
        ),
*/
    ],
  );




}















