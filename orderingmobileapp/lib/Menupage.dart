import 'package:flutter/material.dart';
import 'package:orderingmobileapp/Basketscreen.dart';
import 'package:orderingmobileapp/Foodscreen.dart';
import 'UserSlip.dart';

class Menupage extends StatefulWidget {
  Menupage({Key key, this.username, this.userid}) : super(key: key);
  final String username;
  final String userid;

  @override
  _MenupageState createState() => _MenupageState(
        userid: userid,
        username: username,
      );
}

class _MenupageState extends State<Menupage> {
  _MenupageState({this.userid, this.username});
  final String username;
  final String userid;

  List<Post> basket = [];
  // List<Post> newbasket = [];

  int sum = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Menu"),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.receipt,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSlip(userid: userid)));
              },
            )
          ],
          bottom: TabBar(tabs: <Widget>[
            Tab(
              text: "Menu",
            ),
            Tab(
              text: "Basket",
            ),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          Foodscreen(
            userid: userid,
            valueSetter: (selectedfood) {
              setState(() {
                basket.add(selectedfood);
                print("basket");
                print(basket);
                sum = 0;
                basket.forEach((element) {
                  var z = int.parse(element.menuprice);
                  sum = sum + z;
                  print(sum);
                });

                // basket.removeWhere((item) => item.price == basket[index].price);
              });
            },
          ),
          Basketscreen(basket: basket, sum: sum, userid: userid),
        ]),
      ),
    );
  }
}

class Post {
  String name;
  String status;
  String menuid;
  String menuname;
  String menudescription;
  String menuprice;
  String menuimg;
  String userid;
  String ordernumber;
  String orders;
  String prices;
  int price;
  String ordernumbers;

  Post({
    this.name,
    this.price,
    this.menuid,
    this.menuname,
    this.menudescription,
    this.menuprice,
    this.menuimg,
    this.status,
    this.userid,
    this.ordernumber,
    this.orders,
    this.prices,
    this.ordernumbers,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return new Post(
      name: json['name'].toString(),
      status: json['status'].toString(),
      // price: json['userid'].toString(),
      menuid: json['menuid'].toString(),
      menuname: json['menuname'].toString(),
      menudescription: json['menudescription'].toString(),
      menuprice: json['menuprice'].toString(),
      menuimg: json['menuimg'].toString(),
      userid: json['userid'].toString(),
      ordernumber: json['ordernumber'].toString(),
      orders: json['orders'].toString(),
      prices: json['prices'].toString(),
      ordernumbers: json['ordernumbers'].toString(),
    );
  }
}
