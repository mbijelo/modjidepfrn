import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:modjiappfournisseur/ui/strings.dart';
import 'edit_service.dart';
import '../theme.dart';
import 'edit_service1.dart';

class ServicesAllScreen extends StatefulWidget {
  @override
  _ServicesAllScreenState createState() => _ServicesAllScreenState();
}

class _ServicesAllScreenState extends State<ServicesAllScreen> {

  double windowWidth = 0;
  double windowHeight = 0;
  final _controllerSearch = TextEditingController();
  late ProductData _itemToDelete1;
  String _searchText = "";

  _redraw(){
    if (mounted)
      setState(() {
      });
  }


  bool _wait = false;
  _waits(bool value){
    _wait = value;
    _redraw();
  }
  @override
  void dispose() {
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : Colors.white,
      body: Directionality(
      textDirection: strings.direction,
    child: Stack(
      children: [

        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top+40),
          child: _body(),
        ),

        appbar1(Colors.transparent, (theme.darkMode) ? Colors.white : Colors.white,
            strings.get(142), context, () {  /// "My Services",
          goBack();
        }),

        IEasyDialog2(setPosition: (double value){_show = value;}, getPosition: () {return _show;}, color: Colors.grey,
          getBody: _getDialogBody, backgroundColor: (theme.darkMode) ? Colors.black : Colors.white,),

        if (_wait)
          Center(child: Container(child: Loader7v1(color: theme.mainColor,))),


      ]),
    ));
  }

  ProductData? _itemToDelete;
  String _dialogName = "";

  Widget _getDialogBody(){

    if (_dialogName == "too_many_services")
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20,),
          Icon(Icons.info_outline, color: Colors.red, size: 50,),
          SizedBox(height: 20,),
          Text(strings.get(262), /// "You have exceeded the limit on the number of services. Contact support for more information."
              textAlign: TextAlign.center, style: theme.style14W800),
          SizedBox(height: 40,),
          Row(children: [
            SizedBox(width: windowWidth/3.5,),
            button2c(strings.get(261), /// "Cancel",
                theme.mainColor, (){
                  _show = 0;
                  _redraw();
                }),

          ],),

          SizedBox(height: 100,),



        ],
      );
























    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(strings.get(145), /// "Do you want to delete this item? You will can't recover this item.",
            textAlign: TextAlign.center, style: theme.style14W800),
        SizedBox(height: 40,),
        Row(children: [
          Expanded(child: button2(strings.get(146), /// "No",
              theme.mainColor, (){
                _show = 0;
                _redraw();
              })),
          SizedBox(width: 10,),
          Expanded(child: button2(strings.get(86), /// "Delete",
                Colors.red, () async {
              _show = 0;
              _redraw();
              if (_itemToDelete != null) {
                _waits(true);
                var ret = await deleteProduct(_itemToDelete!);

                if (ret == null){
                  setState(() {});
                  _waits(false);
                  messageOk(context, strings.get(177));

                  for(var prdct in product){
                    if(prdct.id == _itemToDelete?.id){
                      product.removeWhere((element) => element.id == _itemToDelete?.id );
                    }
                  }

                  setState(() {});

                }

                if (ret != null)
                  messageError(context, ret);
                _waits(false);
                _redraw();
              }
            },))
        ],),

        SizedBox(height: 100,),




      ],
    );
  }

  double _show = 0;

  _body(){
    List<Widget> list = [];

    /*
    list.add(Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Edit26(
        hint: strings.get(144), /// "Search service",
        color: (theme.darkMode) ? Colors.black : Colors.white,
        style: theme.style14W400,
        decor: decor,
        useAlpha: false,
        icon: Icons.search,
        controller: _controllerSearch,
        onChangeText: (String val){
          _searchText = val;
          _redraw();
        },
      ),),
    );

    list.add(SizedBox(height: 10,));
    */
    list.add(Container(
      margin: EdgeInsets.all(10),
        child: button2(strings.get(178), Colors.black54, (){ /// "Create new service"
/*
          if (currentProvider.useMaximumServices
              && currentProvider.maxServices <= product.length){
*/
          if (1 <= product.length){

            _dialogName = "too_many_services";
            _show = 1;
            _redraw();
            return;
          }
      currentProduct = ProductData.createEmpty();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditServiceScreen1(),
        ),
      );
    })));
    list.add(Divider());
    list.add(SizedBox(height: 10,));




















    var i = 0;
    var CNameFrench = "";
    var CNameEnglish = "";
    var CNameArabic = "";
    var Lacategorie = "";

    for (var item in product) {
      if (_searchText.isNotEmpty)
        if (!getTextByLocale(item.name, strings.locale).toUpperCase().contains(_searchText.toUpperCase()))
          continue;


        Lacategorie = getCategoryNameById(item.category[0]);

      i = 0;
      CNameFrench = "";
      while (i < Lacategorie.length) {
        if (Lacategorie[i] != "²") {
          CNameFrench = CNameFrench + Lacategorie[i];
        }
        else {
          break;
        }
        i++;
      }
      dprint("CNameFrench : " + CNameFrench);


      i++;
      CNameEnglish = "";
      while (i < Lacategorie.length) {
        if (Lacategorie[i] != '²') {
          CNameEnglish = CNameEnglish + Lacategorie[i];
        }
        else {
          break;
        }
        i++;
      }
      dprint("CNameEnglish : " + CNameEnglish);


      i++;
      CNameArabic = "";
      while (i < Lacategorie.length) {
        CNameArabic = CNameArabic + Lacategorie[i];
        i++;
      }
      dprint("CNameArabic : " + CNameArabic);


      String realText = "";
      if (strings.locale == "en") {
        realText = CNameEnglish;
      }
      else if (strings.locale == "fr") {
        realText = CNameFrench;
      }
      else if (strings.locale == "ar") {
        realText = CNameArabic;
      }
      else {
        realText = "";
      }


  var image = "";
  for(var cat in categories){
     if(cat.id == item.category[0]){
       image = cat.serverPath;
     }
  }







      var shadow = false;
      var text2 = "qsd";
      var stringTimeCreation = "";
      var stringBookingAt = "";
      var dateCreating = "";
      var bookingAt = "";
      var stringBookingId = "";
      var bookingId = "";
      var text3 = "qsdqsd";
      var icon = "";
      var date = "tre";


      list.add(InkWell(
          onTap: () {
          },
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5, top:5, bottom: 5),
                  decoration: BoxDecoration(
                    color: Color(0xfff1f6fe),
                    borderRadius: BorderRadius.circular(aTheme.radius),
                    boxShadow: (shadow) ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(3, 3),
                      ),
                    ] : null,
                  ),
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 10),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(realText, style: aTheme.style14W800,),
                                SizedBox(height: 5,),
                                if (text2.isNotEmpty)
                                  Row(children: [
                                  Icon(Icons.check_circle,
                                    color: item.visible ? Colors.green : Colors.grey,),
                                  Text(
                                      item.visible ? strings.get(296) : strings.get(292) ,
                                      style: aTheme.style12W800),

                                  ],),
                                if (text2.isNotEmpty)
                                  SizedBox(height: 0,),
                                Row(children: [
                                  Text(stringTimeCreation, style: aTheme.style12W800), /// Time creation
                                  SizedBox(width: 10,),
                                  Expanded(child: Text(dateCreating, style: aTheme.style12W400, overflow: TextOverflow.ellipsis))
                                ],),
                                SizedBox(height: 0,),
                                if (bookingAt.isNotEmpty)
                                  Row(children: [
                                    Text(stringBookingAt, style: aTheme.style12W800), /// Booking At
                                    SizedBox(width: 10,),
                                    Expanded(child: Text(bookingAt, style: aTheme.style12W400, overflow: TextOverflow.ellipsis))
                                  ],),


                                  Row(children: [
                                    InkWell(
                                        onTap: () {
                                          currentProduct = item;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => EditServiceScreen(),
                                            ),
                                          );
                                        },

                                        child: Container(
                                          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                          decoration: BoxDecoration(
                                            color: item.visible ? Colors.black54 : Colors.green,
                                            borderRadius: BorderRadius.circular(aTheme.radius),
                                          ),
                                          child: Text(
                                            item.visible ? strings.get(298) : strings.get(297) ,
                                            style: aTheme.style12W600White,),
                                        )),
                                  ],),


                                SizedBox(height: 15,),

                                if (stringBookingId.isNotEmpty)
                                  SizedBox(height: 15,),

                                if (text3.isNotEmpty)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 5,),
                                        InkWell(
                                          onTap: (){
                                            _show = 1;
                                            _dialogName = "";
                                            _itemToDelete = item;
                                            _redraw();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(aTheme.radius),
                                            ),
                                            child: Text(strings.get(293), style: aTheme.style12W600White,),
                                          ),
                                        )

                                    ],
                                  )

                              ],)),
                        SizedBox(width: 20,),
                        Container(
                          height: 70,
                          width: 70,
                          //padding: EdgeInsets.only(left: 10, right: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: showImage(image, fit: BoxFit.cover)
                            // image.isNotEmpty ? CachedNetworkImage(
                            //             imageUrl: image,
                            //             imageBuilder: (context, imageProvider) => Container(
                            //               width: double.maxFinite,
                            //               alignment: Alignment.bottomRight,
                            //               child: Container(
                            //                 //width: height,
                            //                 decoration: BoxDecoration(
                            //                     image: DecorationImage(
                            //                       image: imageProvider,
                            //                       fit: BoxFit.cover,
                            //                     )),
                            //               ),
                            //             )
                            //         ) : Container(),
                          ),
                        ),
                        SizedBox(width: 10,),

                      ],
                    ),

                  ))

          )
      ));




      list.add(SizedBox(height: 25,),);

/*
      list.add(InkWell(onTap: (){_openDetails(item);},
        child: Container(
          width: windowWidth,
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Card50(item: item,
            providerData: currentProvider,
            locale: strings.locale,
            direction: strings.direction,
            category: categories,
          ),
      )));

      list.add(SizedBox(height: 5,),);
      */
      /*
      list.add(Row(
        children: [
          SizedBox(width: 10,),
          Expanded(child: button2(strings.get(133), theme.mainColor, (){ /// "Edit"
            currentProduct = item;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditServiceScreen(),
              ),
            );
          })),
          SizedBox(width: 10,),
          Expanded(child: button2(strings.get(86), Colors.red, (){ /// "Delete"
            _show = 1;
            _dialogName = "";
            _itemToDelete = item;
            _redraw();
          })),
          SizedBox(width: 10,),
        ],
      ));

      list.add(SizedBox(height: 20,));
      */
      _itemToDelete1 = item;
    }

    list.add(SizedBox(height: 150,));
    return ListView(
          padding: EdgeInsets.only(top: 0),
          children: list,
    );
  }

  _openDetails(ProductData item) async {
    // localSettings.callbackStack1 = "category";
    // _mainModel.currentService = item;
  //  localSettings.serviceScreenTag = _tag;
    // _mainModel.route("service");
  }
}
