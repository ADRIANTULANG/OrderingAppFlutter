import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Basketscreen extends StatefulWidget {
  Basketscreen({Key key, this.basket, this.sum, this.userid}) : super(key: key);
  final basket;
  final sum;
  final String userid;

  @override
  _BasketscreenState createState() =>
      _BasketscreenState(basket: basket, sum: sum, userid: userid);
}

class _BasketscreenState extends State<Basketscreen> {
  _BasketscreenState({this.basket, this.sum, this.userid});
  final String userid;
  final basket;
  var sum;
  var total;

  int stringprice;
  int integerprice;
  String order;
  String pricefinal;

  List newList = [];

  void removeList(index) {
    var stringprice = basket[index].menuprice;
    print(stringprice);
    var integerprice = int.parse(stringprice);

    setState(() {
      basket.removeAt(index);
      print("sum under");
      print(sum);
      print(integerprice);
      sum = sum - integerprice;
      print(sum);
      print(basket);
    });
  }

  Future<void> messageorderdone() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Ordered'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Confirm'),
              onPressed: () {
                clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void dataaddorder() {
    String onevariableListOrder = "";
    basket.forEach((element) {
      setState(() {
        String a = element.menuname.toString();
        print(a);
        newList.add(a);
        print(newList.toString());
        onevariableListOrder = newList.join('  ,  ');
        print(onevariableListOrder);
      });
    });
    pricefinal = sum.toString();
    print(pricefinal);
    var url = "http://192.168.43.156/OrderingAppAPI/addDataOrder.php";
    http.post(url, body: {
      "userid": userid,
      "orders": onevariableListOrder,
      "prices": pricefinal,
    });
    var urll = "http://192.168.43.156/OrderingAppAPI/addAdminOrders.php";
    http.post(urll, body: {
      "userid": userid,
      "orders": onevariableListOrder,
      "prices": pricefinal,
      "orderstatus": "pending",
    });
    messageorderdone();
  }

  void clear() {
    int end = newList.length;
    print(end.toString());
    newList.removeRange(0, end);
    print("n");
    print(newList.toString());
    print("n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: new Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                        color: Colors.grey[200],
                        elevation: 3,
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Container(
                              color: Colors.grey[200],
                              child: Row(
                                children: <Widget>[
                                  new Container(
                                      // color: Colors.red,
                                      height: 100,
                                      width: 80,
                                      child: IconButton(
                                          icon:
                                              Icon(Icons.remove_circle_rounded),
                                          color: Colors.red,
                                          onPressed: () {
                                            removeList(index);
                                          })),
                                  new Container(
                                    // color: Colors.blue,
                                    height: 100,
                                    width: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        // new Padding(padding: EdgeInsets.only(top: 25)),
                                        new Container(
                                          child: Text(
                                            basket[index].menuname,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(top: 5)),
                                        new Container(
                                          child: Text(
                                            basket[index].menudescription,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        new Padding(
                                            padding: EdgeInsets.only(top: 5)),
                                        new Container(
                                          child: Text(
                                            basket[index].menuprice +
                                                " " +
                                                "Php.",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Container(
                                    height: 100,
                                    width: 120,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: new DecorationImage(
                                          image: new NetworkImage(
                                              basket[index].menuimg),
                                          fit: BoxFit.cover),
                                      border: new Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ));
                  },
                  itemCount: basket.length,
                  shrinkWrap: true,
                ),
              ),
            ),
            // FloatingActionButton(onPressed: () {
            //   dataaddorder(index);
            // }),
            Divider(),
            Center(
              child: Container(
                height: 100.0,
                width: 365.0,
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    child: new Center(
                      child: new Text(
                        "Total Amount:" + "        ₱" + sum.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Container(
                width: 365,
                height: 90,
                child: new Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.pink,
                    child: Text("Order"),
                    onPressed: () {
                      dataaddorder();
                    },
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
