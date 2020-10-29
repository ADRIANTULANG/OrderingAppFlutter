// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'Updatedogs.dart';
// import 'displayphotos.dart';

// class UserProfile extends  StatelessWidget {

// UserProfile({this.email, this.address, this.userid, this.fullname, this.imageurl, this.error, this.urll});
// final String email;
// final String address;
// final String userid;
// final String fullname;
// final String imageurl;
// final String error;
// final String urll;

//  Widget warningmessage(){
//       return Column(children: <Widget>[
//        new Container(
//                         child: Container(
//                           margin: EdgeInsets.only(top: 40),
//                           height: 140,
//                           width: 140,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(1000),
//                               image: DecorationImage(
//                               image: AssetImage("images/nonprofile.png"),
//                               fit: BoxFit.cover,
//                             )
//                           ),
//                            )
//                       ),
//       ],);
//     }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Container(

//         child: Column(
//           children: <Widget>[
//             new Center(
//               child:Container(
//                 height: 370,
//                 width: 430,
//                 decoration: new BoxDecoration(
//                   boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     offset: Offset(1.0, 12.0), //(x,y)
//                     blurRadius: 6.0,
//                   ),
//                 ],
//                   image: new DecorationImage(
//                                                   image: AssetImage("images/huskylandingpage.jpg"),
//                                                   fit: BoxFit.cover,
//                                                    colorFilter: ColorFilter.mode(Colors.black, BlendMode.hue)
//                                                   ),
//                    borderRadius: new BorderRadius.only(
//                             bottomRight:  const  Radius.circular(40.0),
//                             bottomLeft: const  Radius.circular(40.0))
//                 ),
//                 child: Column(
//                   children: <Widget>[
//                     new Padding(padding: EdgeInsets.only(top: 50)),
//                     new Center(
//                       child: Text("Dog Mingle",
//                     style: TextStyle(
//                       fontFamily: "Pacifico",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 60,
//                       color: Colors.white
//                     ),
//                     ),),
//                   ],
//                 )

//               ),

//              ),
//              new Padding(padding: EdgeInsets.only(top: 40)),
//              new Container(
//                height: 485,
//                width: 430,
//                decoration: new BoxDecoration(
//                   boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey,
//                     offset: Offset(1.0, 12.0), //(x,y)
//                     blurRadius: 6.0,
//                   ),
//                 ],
//                    borderRadius: new BorderRadius.only(
//                             topRight:  const  Radius.circular(40.0),
//                             topLeft: const  Radius.circular(40.0))
//                 ),
//                child: Column(children: <Widget>[
//                  Padding(padding: EdgeInsets.only(top:40)),
//                     new Center(child:  (error=='[MESSAGE]: No photo exist. Please upload profile Picture!')? warningmessage():
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
//                                new Padding(padding: EdgeInsets.only(top: 30)),
//                                new Text("                                                                                        ",
//                                           style: TextStyle(
//                                              decoration: TextDecoration.underline,
//                                           ),
//                                           ),
//                                 new Container(
//                                   margin: EdgeInsets.only(right: 20),
//                                   height: 200,
//                                   width: 600,

//                                   child: Column(children: <Widget>[
//                                     new Container(

//                                                 width: 330,
//                                                 padding: EdgeInsets.only(left: 10),
//                                                 margin: EdgeInsets.only( top: 20),
//                                                 child: Text("Name:  "+fullname,
//                                                 textAlign: TextAlign.left,
//                                                       style: TextStyle(
//                                                           fontSize: 16,
//                                                             color: Colors.black,
//                                                             fontWeight: FontWeight.bold,
//                                                     )
//                                                 )
//                                               ),
//                                               new Container(

//                                                 width: 330,
//                                                 padding: EdgeInsets.only(left: 10),
//                                                   margin: EdgeInsets.only( top: 10,),
//                                                   child: Text("Address:  "+address,
//                                                   textAlign: TextAlign.left,
//                                                         style: TextStyle(
//                                                             fontSize: 10,
//                                                               color: Colors.black,
//                                                               fontWeight: FontWeight.bold,
//                                             )
//                                         )
//                                       ),
//                                       new Padding(padding: EdgeInsets.only(top: 20)),
//                                       Row(
//                                          children: <Widget>[
//                                           new Padding(padding: EdgeInsets.only(left: 47)),
//                                           new RawMaterialButton(
//                                               onPressed: () {
//                                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => AddDogpage(urll: urll,email: email, userid: userid,address:address, fullname:fullname)));

//                                             },
//                                               elevation: 2.0,
//                                               fillColor: Colors.white,
//                                               child: Icon(
//                                                 Icons.add_circle,
//                                                 color: Colors.black,
//                                                 size: 35.0,
//                                               ),
//                                               padding: EdgeInsets.all(15.0),
//                                               shape: CircleBorder(),
//                                             ),
//                                              new Padding(padding: EdgeInsets.only(left: 30)),
//                                           new RawMaterialButton(
//                                               onPressed: () {
//                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => SelecttoUpdate(userid: userid)));
//                                             },
//                                               elevation: 2.0,
//                                               fillColor: Colors.white,
//                                               child: Icon(
//                                                 Icons.update,
//                                                 color: Colors.black,
//                                                 size: 35.0,
//                                               ),
//                                               padding: EdgeInsets.all(15.0),
//                                               shape: CircleBorder(),
//                                             ),
//                                              new Padding(padding: EdgeInsets.only(left: 30)),
//                                           new RawMaterialButton(
//                                               onPressed: () {
//                                                 Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayUserphto(userid: userid)));
//                                       },
//                                               elevation: 2.0,
//                                               fillColor: Colors.white,
//                                               child: Icon(
//                                                 Icons.photo_library,
//                                                 color: Colors.black,
//                                                 size: 35.0,
//                                               ),
//                                               padding: EdgeInsets.all(15.0),
//                                               shape: CircleBorder(),
//                                             ),
//                                          ],
//                                        ),
//                                   ],),
//                                 )
//                ],),
//               )

//           ],
//         )
//       ),
//     );
//   }
// }
