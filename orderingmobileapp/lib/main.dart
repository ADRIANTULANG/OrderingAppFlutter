import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Menupage.dart';
import 'Adminpage.dart';
import 'package:orderingmobileapp/Menupage.dart';

void main() {
  runApp(MyApp());
}

String username = '';
String password = '';
String userid = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
        routes: <String, WidgetBuilder>{
          '/Menupage': (BuildContext context) => new Menupage(userid: userid),
          '/Adminpage': (BuildContext context) =>
              new Adminpage(userid: userid, username: username),
          '/LoginPage': (BuildContext context) => new MyHomePage(),
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController usernameinput = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> alertdialogError() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error Message'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Invalid Email or Password.'),
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

  Future<dynamic> _login() async {
    try {
      final response = await http
          .post("http://192.168.43.156/OrderingAppAPI/login.php", body: {
        "username": usernameinput.text,
        "password": password.text,
      });

      var datauser = json.decode(response.body);

      if (datauser.length == 0) {
        alertdialogError();
        //  setState(() {
        //    msg="Login fail";
        //  });
      } else {
        if (datauser[0]['usertype'] == 'admin') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Adminpage(
                        userid: userid,
                        username: username,
                      )));
        } else if (datauser[0]['usertype'] == 'member') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Menupage(userid: userid)));
        }
        setState(() {
          userid = datauser[0]['userid'];
          username = datauser[0]['username'];
          password = datauser[0]['password'];
          print(userid);
        });
      }
      return datauser;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.only(top: 250),
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 100),
              child: new Container(
                  width: 365,
                  child: new TextField(
                    controller: usernameinput,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              width: 20,
                            )),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: " Username",
                        fillColor: Colors.white70),
                  )),
            ),
            new Padding(
              padding: const EdgeInsets.only(top: 40),
              child: new Container(
                  width: 365,
                  child: new TextField(
                    controller: password,
                    obscureText: true,
                    decoration: new InputDecoration(
                        border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              width: 20,
                            )),
                        filled: true,
                        hintStyle: new TextStyle(color: Colors.grey[800]),
                        hintText: " Password",
                        fillColor: Colors.white70),
                  )),
            ),
            Container(
              width: 365,
              height: 90,
              child: new Padding(
                padding: EdgeInsets.only(top: 40),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.pink,
                  child: Text("Login"),
                  onPressed: () {
                    _login();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.red)),
                ),
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(

      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
