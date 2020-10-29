import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Adminpage extends StatefulWidget {
  Adminpage({Key key, this.username, this.userid}) : super(key: key);
  final String username;
  final String userid;

  @override
  _AdminpageState createState() =>
      _AdminpageState(userid: userid, username: username);
}

class _AdminpageState extends State<Adminpage> {
  _AdminpageState({this.userid, this.username});
  final String username;
  final String userid;

  List<Posts> postss = List();
  List<Posts> filteredUserss = List();

  Future<List<Posts>> getdatas() async {
    http.Response response = await http.post(
        "http://192.168.43.156/OrderingAppAPI/getdataadmin.php",
        body: {});
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Posts.fromJson(m)).toList();
  }

  Widget statusDelivered(index) {
    return Column(
      children: <Widget>[Text(filteredUserss[index].orderstatus)],
    );
  }

  updatedelivery(index) {
    String stringvalue = filteredUserss[index].ordernumbers.toString();
    print(stringvalue);
    var url = "http://192.168.43.156/OrderingAppAPI/updatestatusdelivery.php";
    http.post(url, body: {
      "ordernumbers": stringvalue,
      "orderstatus": "delivered",
    });
  }

  void streaming() {
    getdatas().then((usersFromServers) {
      setState(() {
        postss = usersFromServers;
        filteredUserss = postss;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getdatas().then((usersFromServers) {
      setState(() {
        postss = usersFromServers;
        filteredUserss = postss;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(padding: EdgeInsets.all(40)),
            new Text(" Admin Slip",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            new Padding(padding: EdgeInsets.only(top: 30)),
            new Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: filteredUserss.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.grey[300],
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  // color: Colors.blue,
                                  height: 30,
                                  width: 380,
                                  child: Text(
                                    "#" + filteredUserss[index].ordernumbers,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                new Container(
                                    // color: Colors.purple,
                                    width: 380,
                                    child: Text(
                                      " Order:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    )),
                                new Padding(padding: EdgeInsets.only(top: 20)),
                                new Container(
                                  height: 100,
                                  width: 350,
                                  child: Text(
                                    " " +
                                        filteredUserss[index].orders +
                                        "\n Total Amount:   " +
                                        filteredUserss[index].prices +
                                        " Php.",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                new Text(filteredUserss[index].orderstatus),
                                // new Center(
                                //     child: (filteredUserss[index].orderstatus ==
                                //             "delivered")
                                //         ? updatedelivery(index)
                                //         : Container(
                                //             margin: EdgeInsets.only(top: 30),
                                //             height: 120,
                                //             width: 120,
                                //             child: Text(
                                //               filteredUserss[index].orderstatus,
                                //             ),
                                //           )),
                                new IconButton(
                                    icon: Icon(Icons.delivery_dining),
                                    color: Colors.red,
                                    onPressed: () {
                                      updatedelivery(index);
                                      streaming();
                                    })
                              ],
                            ),
                          ),
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}

class Posts {
  String userid;
  String orders;
  String prices;
  String ordernumbers;
  String orderstatus;

  Posts({
    this.userid,
    this.orders,
    this.prices,
    this.ordernumbers,
    this.orderstatus,
  });

  factory Posts.fromJson(Map<String, dynamic> json) {
    return new Posts(
      userid: json['userid'].toString(),
      orders: json['orders'].toString(),
      prices: json['prices'].toString(),
      ordernumbers: json['ordernumbers'].toString(),
      orderstatus: json['orderstatus'].toString(),
    );
  }
}

// new Center(child:  (error=='[MESSAGE]: No photo exist. Please upload profile Picture!')? warningmessage():
//                                 Container(
//                                   margin: EdgeInsets.only(top: 30),
//                                   height: 120,
//                                   width: 120,
//                                 decoration: new BoxDecoration(
//                                   border: new Border.all(
//                                            color: Colors.white,
//                                            width: 5.0,
//                                       ),
//                                   borderRadius: BorderRadius.circular(1000),
//                                 image: new DecorationImage(
//                                   image: new NetworkImage(imageurl),
//                                 fit: BoxFit.cover)
//                                   ),
//                                  )
//                                ),
