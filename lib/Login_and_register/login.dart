import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app/Login_and_register/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'AccountRegister.dart';
import 'ForgotPassword.dart';
import 'package:flutter_app/HomePage/HomePage.dart';
import 'auth.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: LoginDemo(),
//     );
//   }
// }

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {

  //========variables==========
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _account = new TextEditingController();
  TextEditingController _password = new TextEditingController();

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  bool hidePass = true;

  Auth auth = Auth();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn.disconnect();
  }

  void isSingedIn() async {
    setState(() {
      loading = true;
    });

    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();

    //======== dang nhap thanh cong ==========
    User user = await firebaseAuth.currentUser;
      if (user != null) {
        setState(() => isLogedin = true);
      }
    if (isLogedin) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }

    setState(() {
      loading = false;
    });
  }

  Future HandleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
    // User firebaseUser = await firebaseAuth.signInWithGoogle(
    //     idToken: googleSignInAuthentication.idToken,
    //     accessToken: googleSignInAuthentication.accessToken);
    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    User firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection("user")
          .where("id", isEqualTo: firebaseUser.uid)
          .get();
      final List<DocumentSnapshot> documents = result.docs;
      if (documents.length == 0) {
        //========== insert user to collection ==========
        FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseUser.uid)
            .set({
          "id": firebaseUser.uid,
          "username": firebaseUser.displayName,
          'profilePicture': firebaseUser.photoURL
        });

        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("photoUrl", firebaseUser.photoURL);
      } else {
        await preferences.setString("id", documents[0]['id']);
        await preferences.setString("username", documents[0]['username']);
        await preferences.setString("photoUrl", documents[0]['photoUrl']);
      }
      Fluttertoast.showToast(msg: "Logging successful");

      setState(() {
        loading = false;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Fluttertoast.showToast(msg: '"login failed >.<');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(
                        'https://wallpapercave.com/wp/wp2252568.jpg'))),
          ),
          Center(
            child: Visibility(
                visible: loading ?? true,
                child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ))),
          ),
          Center(
            child: SingleChildScrollView(
              // padding: EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Center(
                      child: Container(
                          width: 200,
                          height: 150,
                          // decoration: BoxDecoration(
                          //     color: Colors.blue,
                          //     borderRadius: BorderRadius.circular(50.0)),
                          child: Image.asset('assets/loginlogo.png')),
                    ),
                  ),

                  // SizedBox(
                  //   height: 20.0,
                  // ),

                  Form(
                    key: _formKey,
                    child: Material(
                      borderRadius: BorderRadius.circular((20.0)),
                      color: Colors.white.withOpacity(0.5),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Colors.black54),
                            keyboardType: TextInputType.phone,
                            controller: _account,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white70,
                              ),
                              labelStyle: TextStyle(color: Colors.black54),
                              labelText: 'Số Điện Thoại',
                              hintStyle: TextStyle(color: Colors.black54),
                              fillColor: Colors.white,
                              hintText: 'Vui Lòng nhập số điện thoại',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'phone number cannot be empty';
                              } else {
                                Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regex = new RegExp(pattern);
                                if (!regex.hasMatch(value))
                                  return 'Tài khoản hoặc mật khẩu không phù hợp';
                                else
                                  return null;
                              }
                            },
                          ),
                          // SizedBox(
                          //   height: 20.0,
                          // ),
                          ListTile(
                            title: TextFormField(
                              obscureText: hidePass,
                              controller: _password,
                              // keyboardType: TextInputType.text,
                              style: TextStyle(color: Colors.black54),
                              decoration: InputDecoration(
                                  // filled: true,
                                  prefixIcon:
                                      Icon(Icons.lock, color: Colors.white70),
                                  labelStyle: TextStyle(color: Colors.black54),
                                  labelText: 'Mật khẩu ',
                                  hintStyle: TextStyle(color: Colors.black54),
                                  fillColor: Colors.white,
                                  hintText: 'Mật khẩu phải trên 6 ký tự '),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'password cannot be empty';
                                } else if (value.length < 6) {
                                  return 'password has to be at least 6 character long';
                                }
                                return null;
                              },
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.remove_red_eye),
                              onPressed: () {
                                setState(() {
                                  if (hidePass == true) {
                                    hidePass = false;
                                  } else {
                                    hidePass = true;
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Form(
                  //   key: _formKey,
                  //   child: Material(
                  //     borderRadius: BorderRadius.circular((20.0)),
                  //     color: Colors.white.withOpacity(0.5),

                  //   ),
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ForgotPassword()));
                      },
                      child: Text(
                        'Quên mật khẩu?',
                        style: TextStyle(color: Colors.white),
                      )),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => HomePage()));
                        // HandleSignIn();
                      },
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Đăng Nhập',
                          )),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),

                  Center(
                    child: Text(
                      'Chưa có tài khoản? ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 8.0,
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),

                      Expanded(
                        child: Divider(
                          color: Colors.white,
                          height: 8.0,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AccountRegister()));
                      },
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('Tạo tài khoản')),
                      color: Colors.grey,
                      textColor: Colors.white,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RaisedButton(
                      onPressed: () {
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (_) => HomePage()));
                        HandleSignIn();
                      },
                      child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Đăng Nhập với tài khoản Google',
                          )),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
