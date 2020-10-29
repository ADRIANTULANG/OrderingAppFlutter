import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Menupage.dart';

class UserSlip extends StatefulWidget {
  UserSlip({Key key, this.userid}) : super(key: key);
  final String userid;
  @override
  _UserSlipState createState() => _UserSlipState(userid: userid);
}

class _UserSlipState extends State<UserSlip> {
  _UserSlipState({this.userid});
  final String userid;

  List<Post> posts = List();
  List<Post> filteredUsers = List();

  Future<List<Post>> getdata() async {
    http.Response response = await http
        .post("http://192.168.43.156/OrderingAppAPI/getdataslip.php", body: {
      "userid": userid,
    });
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Post.fromJson(m)).toList();
  }

  @override
  void initState() {
    super.initState();

    getdata().then((usersFromServer) {
      setState(() {
        posts = usersFromServer;
        filteredUsers = posts;
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
            new Text(" Orders Slip",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40)),
            new Padding(padding: EdgeInsets.only(top: 30)),
            new Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: filteredUsers.length,
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
                                    "#" + filteredUsers[index].ordernumber,
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
                                        filteredUsers[index].orders +
                                        "\n Total Amount:   " +
                                        filteredUsers[index].prices +
                                        " Php.",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
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
