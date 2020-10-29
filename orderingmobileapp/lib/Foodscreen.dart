import 'package:flutter/material.dart';
import 'Menupage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'Adminpage.dart';

class Foodscreen extends StatefulWidget {
  Foodscreen({Key key, this.valueSetter, this.menuSetter, this.userid})
      : super(key: key);
  final ValueSetter<Post> valueSetter;
  final ValueSetter<Post> menuSetter;
  final String userid;

  @override
  _FoodscreenState createState() =>
      _FoodscreenState(valueSetter, menuSetter, userid);
}

class _FoodscreenState extends State<Foodscreen> {
  _FoodscreenState(this.valueSetter, this.menuSetter, this.userid);
  final String userid;
  final ValueSetter<Post> valueSetter;
  final ValueSetter<Post> menuSetter;

  List<Post> posts = List();
  List<Post> filteredUsers = List();

  String selected = "";

  final search = TextEditingController();

  Future<void> alertdialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Successfuly added'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> deletealertdialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Successfully Removed Item'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Widget colorchangedblack() {
  //   return Column(
  //     children: <Widget>[
  //       new Container(),
  //     ],
  //   );
  // }

  int tappedIndex;

  Future<List<Post>> getdatapom() async {
    http.Response response = await http
        .post("http://192.168.43.156/OrderingAppAPI/getdatapom.php", body: {});
    List responseJson = json.decode(response.body);
    return responseJson.map((m) => new Post.fromJson(m)).toList();
  }

  Future<void> showPicture(index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 300,
                  width: 300,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        image: new NetworkImage(filteredUsers[index].menuimg),
                        fit: BoxFit.cover),
                    border: new Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    getdatapom().then((usersFromServer) {
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
          children: <Widget>[
            new TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  hintText: "Search Food Name"),
              controller: search,
              onChanged: (string) {
                setState(() {
                  filteredUsers = posts
                      .where((u) => (u.menuname
                          .toLowerCase()
                          .contains(string.toLowerCase())))
                      .toList();
                });
              },
            ),
            new Expanded(
              child: ListView.builder(
                padding: EdgeInsets.all(10.0),
                itemCount: filteredUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: SingleChildScrollView(
                          child: Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showPicture(index);
                            },
                            child: new Container(
                              margin: EdgeInsets.only(top: 10),
                              height: 160,
                              width: 150,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: new DecorationImage(
                                    image: new NetworkImage(
                                        filteredUsers[index].menuimg),
                                    fit: BoxFit.cover),
                                border: new Border.all(
                                  color: Colors.black,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          new Padding(padding: EdgeInsets.only(left: 10)),
                          Container(
                            width: 225,
                            height: 140,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "" + filteredUsers[index].menuname,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                new Padding(padding: EdgeInsets.only(top: 10)),
                                new Text(
                                  "     " +
                                      filteredUsers[index].menudescription,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                                new Padding(padding: EdgeInsets.only(top: 5)),
                                new Container(
                                    // color: Colors.red,
                                    height: 50,
                                    child: Row(
                                      children: <Widget>[
                                        new Text(
                                          filteredUsers[index].menuprice +
                                              " Php.",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(left: 35)),
                                        new IconButton(
                                          icon: Icon(Icons.add_shopping_cart),
                                          color: tappedIndex == index
                                              ? Colors.pinkAccent
                                              : Colors.grey,
                                          onPressed: () {
                                            // menuSetter(filteredUsers[index]);
                                            valueSetter(filteredUsers[index]);
                                            alertdialogError();
                                            setState(() {
                                              tappedIndex = index;
                                            });
                                          },
                                        ),
                                      ],
                                    )),
                                new Container(),
                              ],
                            ),
                          ),
                        ],
                      )),
                    ),
                  );

                  // return ListTile(
                  //   title: Text(
                  //     filteredUsers[index].menuname +
                  //         "   " +
                  //         products[index].status,
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  //   ),
                  //   trailing: Text(
                  //     filteredUsers[index].menuprice + " Pesos",
                  //     style:
                  //         TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  //   ),
                  //   onTap: () {
                  //     valueSetter(products[index]);
                  //     alertdialogError();
                  //     setState(() {
                  //       String a = products[index].status;
                  //       print(a);
                  //       products[index].status = "added";
                  //     });
                  //   },
                  //   onLongPress: () {},
                  // );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// new Text(filteredUsers[index].menuid),
//                           new Text(filteredUsers[index].menuname),
//                           new Text(filteredUsers[index].menudescription),
//                           new Text(filteredUsers[index].menuprice),
//                           new IconButton(
//                             icon: Icon(Icons.add),
//                             color: Colors.black,
//                             onPressed: () {
//                               valueSetter(filteredUsers[index]);
//                               alertdialogError();
//                             },
//                           ),
