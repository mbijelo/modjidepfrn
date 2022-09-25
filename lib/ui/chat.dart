import 'dart:math';
import 'package:abg_utils/abg_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:modjiappfournisseur/ui/strings.dart';
import 'package:modjiappfournisseur/widgets/cards/card41.dart';
import 'devab.dart';
import 'theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  double windowWidth = 0;
  double windowHeight = 0;
  String _searchText = "";
  double windowSize = 0;
  final ScrollController _scrollController = ScrollController();
  final _controllerSearch = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    _init();
    super.initState();
  }

  _init() async {
    _waits(true);
    var ret = await loadUsersForChatInProviderApp1();
    if (ret != null)
      messageError(context, ret);
    _waits(false);
    ret = await getChatMessages(_redraw, app: "provider");
    if (ret != null)
      messageError(context, ret);
    _redraw();
  }































  bool _ifInUsers(String id){
    for (var _user in users) {
      if (_user.id == id) {
        return true;
      }
    }
    return false;
  }



  Future<String?> loadUsersForChatInProviderApp1() async{
    users = [];
    var trouve = false;
    var providerId = "";

    var user = FirebaseAuth.instance.currentUser;
    var querySnapshotBooking1 = await FirebaseFirestore.instance.collection("provider").where("login", isEqualTo: user!.email).get();
    for (var result1 in querySnapshotBooking1.docs) {
      var _data1 = result1.data();
      providerId = result1.id;

    }

    var querySnapshotBooking = await FirebaseFirestore.instance.collection("booking").get();
    for (var result in querySnapshotBooking.docs) {
      var _data = result.data();




      //var querySnapshotUser = await FirebaseFirestore.instance.collection("listusers").get();
      // for (var resultU in querySnapshotUser.docs) {
      //  var _dataU = resultU.data();
      // if (_dataU.isNotEmpty) {
      //   var destinator = UserData.fromJson(resultU.id, _dataU);
      //  if (destinator.id == _data["customerId"]){
      if (providerId == _data["providerId"]) {
        //dprint("logoServerPath : " + destinator.logoServerPath);
        //dprint("booking $_data"); dprint("booking customerId : " + _data["customerId"] );
        //dprint("bookingId : " + _data["customerId"]);

        for (var y in users) {
          if (y.id == _data["customerId"]) {
            trouve = true;
          }
        }



        if (!trouve) {
          if (!_ifInUsers(_data["customerId"])) {
            if (_data["customer"] != "" && _data["customerId"] != "") {



              var querySnapshotUser = await FirebaseFirestore.instance.collection("listusers").get();
              for (var resultU in querySnapshotUser.docs) {
                var _dataU = resultU.data();
                if (_dataU.isNotEmpty) {
                  var destinator = UserData.fromJson(resultU.id, _dataU);
                  if (destinator.id == _data["customerId"]){


                    users.add(UserData(id: _data["customerId"],
                      name: _data["customer"],
                      logoServerPath: destinator.logoServerPath,
                      email: "",
                      address: [],
                    ));



                  }
                }
              }







            }
          }
        }


      }
      // }
      //  }






    }
/*
  for (var item in bookings){
    dprint("bookingId : " + item.customerId);
    if (!_ifInUsers(item.customerId)) {
      if (item.customer.isNotEmpty && item.customerId.isNotEmpty){
        users.add(UserData(id: item.customerId,
          name: item.customer,
          logoServerPath: item.customerAvatar,
          email: "",
          address: [],
        ));
      }
    }
  }
*/

    try{
      var querySnapshot = await FirebaseFirestore.instance.collection("listusers").where("role", isEqualTo: "owner").get();
      for (var result in querySnapshot.docs) {
        var _data = result.data();
        dprint("User $_data");
        var admin = UserData.fromJson(result.id, _data);
        if (!_ifInUsers(admin.id))
          users.add(admin);
      }
      addStat("chat list users", querySnapshot.docs.length);
    }catch(ex){
      return "loadUsersForChatInCustomerApp " + ex.toString();
    }
    return null;
  }




































  double _scroller = 20;
  _scrollListener() {
    var _scrollPosition = _scrollController.position.pixels;
    _scroller = 20-(_scrollPosition/(windowHeight*0.1/20));
    if (_scroller < 0)
      _scroller = 0;
    setState(() {
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controllerSearch.dispose();
    for (var item in customersChat)
      if (item.listen != null)
        item.listen!.cancel();
    super.dispose();
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
    windowSize = min(windowWidth, windowHeight);
    return Scaffold(
//        backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
          backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : Colors.white,

        body: Directionality(
          textDirection: strings.direction,
          child: Stack(
              children: [
                NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                          expandedHeight: windowHeight*0.2,
                          automaticallyImplyLeading: false,
                          pinned: true,
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: ClipPath(
                            clipper: ClipPathClass23((_scroller < 5) ? 5 : _scroller),
                            child: Container(
                                color: (theme.darkMode) ? Colors.black : Colors.white,
                                child: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.pin,
                                    background: _title(),
                                    titlePadding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                                    title: _titleSmall()
                                )),
                          ))
                    ];
                  },
                  body: Container(
                    width: windowWidth,
                    height: windowHeight,
                    child: Stack(
                      children: [
                        _body(),
                        if (_wait)
                          Center(child: Container(child: Loader7v1(color: theme.mainColor,))),
                      ],
                    ),
                  ),
                ),

              ]),
        ));
  }

  _title() {
    return Container(
      color: (theme.darkMode) ? Colors.black : Colors.black54,
      height: windowHeight * 0.3,
      width: windowWidth/2,
      child: Stack(
        children: [
          Container(
            alignment: strings.direction == TextDirection.ltr ? Alignment.bottomRight : Alignment.bottomLeft,
            child: Container(
              width: windowWidth*0.3,
              child: Image.asset("assets/ondemand/ondemand21.png", fit: BoxFit.cover),
            ),
            margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          ),
        ],
      ),
    );
  }


  int _counter = 0;
  int hour=0;
  int minute=0;
  int seconde=0;
  ontaptitle(){
    DateTime now = DateTime.now();
    int h = now.hour;
    int m = now.minute;
    int s = now.second;
    if(hour == h && minute == m){
      if(s-seconde < 10){
        print(h.toString() + "=" + hour.toString());
        print(m.toString() + "=" + minute.toString());
        print(s.toString() + "=" + seconde.toString());
        setState(() {
          hour=h;
          minute=m;
          seconde=s;
          _counter++;
        });
        print("counter" + _counter.toString() + "valider");
      }else{
        print(h.toString() + "=" + hour.toString());
        print(m.toString() + "=" + minute.toString());
        print(s.toString() + "=" + seconde.toString());
        setState(() {
          hour=h;
          minute=m;
          seconde=s;
          _counter=0;
        });
        print("counter" + _counter.toString() + "initialisé à 1 first");
      }
    }else{
      print(h.toString() + "=" + hour.toString());
      print(m.toString() + "=" + minute.toString());
      print(s.toString() + "=" + seconde.toString());
      setState(() {
        hour=h;
        minute=m;
        seconde=s;
        _counter=0;
      });
      print("counter" + _counter.toString() + "initialisé à 1");
    }
    if(_counter > 10){
      _counter=0;
      Navigator.push(context,
          MaterialPageRoute(builder: (context) {
            return DevabScreen();
          }));
    }
  }


  _titleSmall(){
    return InkWell(
        //alignment: Alignment.bottomLeft,
        //padding: EdgeInsets.only(bottom: _scroller, left: 20, right: 20),
        onTap: () {
          ontaptitle();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.get(26), /// "Chat",
              style: theme.style16W800,),
            Text(strings.get(101), /// Chatting online
                style: theme.style10W600White),
            SizedBox(height: 28,),
          ],
        )
    );
  }

  _body(){
    List<Widget> list = [];
    list.add(Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      child: Edit26(
          hint: strings.get(102), /// "Search",
          color: (theme.darkMode) ? Colors.black : Colors.white,
          style: theme.style14W400,
          decor: decor,
          icon: Icons.search,
          useAlpha: false,
          controller: _controllerSearch,
          onChangeText: (String value){
            _searchText = value;
            setState(() {
            });
          }
      ),
    ));

    list.add(SizedBox(height: 20,));

    User? user = FirebaseAuth.instance.currentUser;
    if (user == null)
      return list;

    for (var item in customersChat){
      if (_searchText.isNotEmpty)
        if (!item.name.toUpperCase().contains(_searchText.toUpperCase()))
            continue;

      list.add(InkWell(
          onTap: (){
            setChatData(item.name, item.unread, item.logoServerPath, item.id);
            route("chat2");
          },
          child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Card41(
                all: item.all,
                unread: item.unread,
                image: item.logoServerPath,
                text1: item.name, style1: theme.style16W800,
                text2: item.lastMessage, style2: theme.style14W600Grey,
                text3: item.lastMessageTime != null
                    ? appSettings.getDateTimeString(item.lastMessageTime!)
                    : "",
                style3: theme.style12W600Grey,
                bkgColor: (theme.darkMode) ? Colors.black : Color(0xfff1f6fe)
              )
          )));
      list.add(SizedBox(height: 10,));
    }

    list.add(SizedBox(height: 150,));
    return Container(
        child: ListView(
          children: list,
        )
    );
  }
}

