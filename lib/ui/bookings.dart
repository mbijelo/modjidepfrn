import 'dart:math';
import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:modjiappfournisseur/ui/strings.dart';
import 'theme.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>  with TickerProviderStateMixin{

  double windowWidth = 0;
  double windowHeight = 0;
  double windowSize = 0;

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: appSettings.statuses.length);
    _load();
    super.initState();
  }

  _load() async {
    _waits(true);
    var ret = await setBookingToRead("viewByProvider");
    if (ret != null)
      messageError(context, ret);
    _waits(false);
    redrawMainWindow();
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
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    windowSize = min(windowWidth, windowHeight);
    return Scaffold(
        backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : Colors.white,
        body: Directionality(
            textDirection: strings.direction,
            child: Stack(
              children: <Widget>[

                Container(
                  height: windowHeight,
                  width: windowWidth,
                  margin: EdgeInsets.only(top: 130),
                  child: TabBarView(
                      controller: _tabController,
                      children: _tabBody()
                  ),
                ),

                ClipPath(
                    clipper: ClipPathClass23(20),
                    child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      width: windowWidth,
                      color: (theme.darkMode) ? Colors.black : Colors.white,
                      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(strings.get(27), /// "Booking",
                              style: theme.style20W800),
                          SizedBox(height: 20,),
                          TabBar(
                            labelColor: Colors.black,
                            indicatorWeight: 4,
                            isScrollable: true,
                            indicatorColor: theme.mainColor,
                            tabs: _tabHeaders(),
                            controller: _tabController,
                          ),
                        ],
                      ),
                    )),

                if (_wait)
                  Center(child: Container(child: Loader7v1(color: theme.mainColor,))),

              ],
            ))

    );
  }

  _tabHeaders(){
    List<Widget> list = [];
    for (var item in appSettings.statuses)
      list.add(Text(
          item.name[0].text == "New request" ? strings.get(280)
          : item.name[0].text == "Accept" ? strings.get(37)
              : item.name[0].text == "Ready" ? strings.get(284)
              : item.name[0].text == "Finish" ? strings.get(285)
              : item.name[0].text == "Cancel" ? strings.get(33)
           :"",
          textAlign: TextAlign.center, style: theme.style12W800));
    return list;
  }

  _tabBody(){
    List<Widget> list = [];
    for (var item in appSettings.statuses)
      list.add(_tabChild(item.id, getTextByLocale(item.name, strings.locale)));
    return list;
  }

  _tabChild(String sort, String _text){
    List<Widget> list = [];



    var _count = 0;
    for (var item in ordersDataCache){
      if (item.status != sort)
        continue;
      // var _date = strings.get(30); /// "Any Time",
      // if (!item.anyTime)
      //   _date = appSettings.getDateTimeString(item.selectTime);



      String categoriName = "";
      for (var service in product){
        if(service.name[0].text == item.name){
          for(var cateName in service.category){
            categoriName = cateName;
            categoriName = getCategoryNameById(categoriName);
            var index = 0;
            var i = 0;
            var CNameFrench = "";
            var CNameEnglish = "";
            var CNameArabic = "";
            while (i < categoriName.length) {
              if (categoriName[i] != "²") {
                CNameFrench = CNameFrench + categoriName[i];
              }
              else {
                break;
              }
              i++;
            }
            dprint("CNameFrench : " + CNameFrench);


            i++;
            CNameEnglish = "";
            while (i < categoriName.length) {
              if (categoriName[i] != '²') {
                CNameEnglish = CNameEnglish + categoriName[i];
              }
              else {
                break;
              }
              i++;
            }
            dprint("CNameEnglish : " + CNameEnglish);


            i++;
            CNameArabic = "";
            while (i < categoriName.length) {
              CNameArabic = CNameArabic + categoriName[i];
              i++;
            }
            dprint("CNameArabic : " + CNameArabic);

            if (strings.locale == "en") {
              categoriName = CNameEnglish;
            }
            else if (strings.locale == "fr") {
              categoriName = CNameFrench;
            }
            else if (strings.locale == "ar") {
              categoriName = CNameArabic;
            }
            else {
              categoriName = "";
            }

          }
        }
      }


      list.add(InkWell(
          onTap: () async {
            waitInMainWindow(true);
            var ret = await bookingGetItem(item);
            waitInMainWindow(false);
            if (ret != null)
              return messageError(context, ret);
            route("jobinfo");
            //_openJobInfo(item);
            },
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card43(image: item.customerImage,
                text1: item.customerName,
                text2: categoriName,
                //text3: getPriceString(item.total),
                  text3: "",
                // bookingAt: _date,
                date: appSettings.getStatusName(item.status, strings.locale),
                dateCreating: appSettings.getDateTimeString(item.time),
                bookingId: item.id,
                icon: Icon(Icons.payment, color: theme.mainColor, size: 15,),
                bkgColor: Color(0xfff1f6fe),
                //stringBookingId: strings.get(44), /// "Booking ID",
                stringBookingId: strings.get(44),
                stringTimeCreation: strings.get(186), /// Time creation
                //stringBookingAt: strings.get(217), /// Booking At
              )
              // Card43N(image: item.customerAvatar,
              //   customerName: item.customer,
              //   serviceName: getTextByLocale(item.service, strings.locale),
              //   date: _date,
              //   dateCreating: appSettings.getDateTimeString(item.time),
              //   bookingId: item.id,
              //   jobStatus: _text,
              //   mainModel: _mainModel,
              //   address: item.address,
              //   paymentMethod: item.paymentMethod,
              //   icon: Icon(Icons.calendar_today_outlined, color: theme.mainColor, size: 15,),
              // )
          )
      ));
      list.add(SizedBox(height: 25,));
      _count++;
    }

    if (_count == 0) {
      /*
      list.add(Center(child: Image.asset("assets/nofound.png")));
      list.add(Center(child: Text(strings.get(107), style: theme.style18W800Grey,),)); /// "Not found ...",
       */
    }

    list.add(SizedBox(height: 200,));
    return ListView(
      children: list,
    );
  }

  // _openJobInfo(OrderData item){
  //   currentOrder = item;
  //   route("jobinfo");
  // }
}


