import 'package:abg_utils/abg_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modjiappfournisseur/model/model.dart';
import 'package:modjiappfournisseur/ui/strings.dart';
import 'package:provider/provider.dart';
import 'theme.dart';

class NotifyScreen extends StatefulWidget {
  @override
  _NotifyScreenState createState() => _NotifyScreenState();
}

class _NotifyScreenState extends State<NotifyScreen> {

  double windowWidth = 0;
  double windowHeight = 0;
  final ScrollController _scrollController = ScrollController();
  String _searchText = "";
  late MainModel _mainModel;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();
  final _controllerSearch = TextEditingController();

  @override
  void initState() {
    _mainModel = Provider.of<MainModel>(context, listen: false);
    _scrollController.addListener(_scrollListener);
    _loadMessages();
    _mainModel.updateNotify = _loadMessages;
    super.initState();
  }

  _loadMessages() async {
    _waits(true);
    var ret = await loadMessages();
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
    _mainModel.updateNotify = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    windowWidth = MediaQuery.of(context).size.width;
    windowHeight = MediaQuery.of(context).size.height;
    return Scaffold(
       // backgroundColor: (theme.darkMode) ? theme.blackColorTitleBkg : theme.colorBackground,
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
                    body: Stack(
                      children: [
                        Container(
                          width: windowWidth,
                          height: windowHeight,
                          child: _body(),
                        ),
                        if (_wait)
                          Center(child: Container(child: Loader7v1(color: theme.mainColor,))),
                      ],
                    )
                ),

                // appbar1(Colors.transparent, (theme.darkMode) ? Colors.white : Colors.black,
                //     "", context, () {goBack();})

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
            alignment: Alignment.bottomRight,
            child: Container(/*
              width: windowWidth*0.3,
              child: Image.asset("assets/ondemand/ondemand17.png", fit: BoxFit.cover),
           */ ),
            margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
          ),
        ],
      ),

    );
  }

  _titleSmall(){
    return Container(
        alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _scroller, left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(strings.get(104), /// "Notifications",
              style: theme.style16W800,),
            SizedBox(height: 3,),
            Text(strings.get(105), /// "Lots of important information",
                style: theme.style10W600White),
          ],
        )
    );
  }


  _body(){
    List<Widget> list = [];

    list.add(Edit26(
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
    ));

    list.add(SizedBox(height: 20,));

    //
    //
    //
    bool _empty = true;
    var _now = DateFormat('dd MMMM').format(DateTime.now());

    for (var item in messages){
      if (_searchText.isNotEmpty)
        if (!item.title.toUpperCase().contains(_searchText.toUpperCase()))
          if (!item.body.toUpperCase().contains(_searchText.toUpperCase()))
            continue;
      var time = DateFormat('dd MMMM').format(item.time);
      if (time == _now)
        time = strings.get(106); /// Today
      String DeLutilisateur ="";
      if(item.body.contains("From user:")){DeLutilisateur = "From user:";}
      else if(item.body.contains("De l'utilisateur :")){DeLutilisateur = "De l'utilisateur :";}
      else if(item.body.contains("من المستخدم:")){DeLutilisateur = "من المستخدم:";}
      list.add(Card48(
        //text: item.body,
        text: item.body.contains("From user:") || item.body.contains("De l'utilisateur :") || item.body.contains("من المستخدم:") ? item.body.replaceAll(DeLutilisateur, strings.get(279))
            : item.body == "Status now: Cancel" || item.body == "État actuel :  Cancel" || item.body == "الحالة الآن: Cancel" ? strings.get(282)
            : item.body == "Status now: Finish" || item.body == "État actuel :  Finish" || item.body == "الحالة الآن: Finish" ? strings.get(283)
            : item.body,
        text2: appSettings.getDateTimeString(item.time),
        text3: item.title == "The new reservation has arrived" || item.title == "La nouvelle réservation est arrivée" || item.title == "وصل الحجز الجديد" ? strings.get(280)
             : item.title == "The status of the reservation has been modified" || item.title == "Le statut de la réservation a été modifié" || item.title == "تم تعديل حالة التحفظ" ? strings.get(281)
             : item.title,
        shadow: false,
        callback: () async {
          await deleteMessage(item);
          setState(() {
          });
        },
      ),);
      list.add(SizedBox(height: 20,));
      _empty = false;
    }

    if (_empty) {
     // list.add(Center(child: Image.asset("assets/nofound.png")));
      list.add(Center(child: Text(strings.get(287), style: theme.style18W800Grey,),)); /// "Not found ...",
    }

    list.add(SizedBox(height: 120,));

    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: (){return _loadMessages();},
        child: Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        children: list,
      ),
    ));
  }
}

