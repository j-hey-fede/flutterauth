import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../services/authservice.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var name;
  var password;
  var token;
  bool _isNewUser;
  bool _isAuthenticated;

  @override
  void initState() {
    _isNewUser = false;
    _isAuthenticated = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter here!',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  size: 18,
                  color: Colors.grey,
                ),
                labelText: 'Name',
              ),
              onChanged: (val) {
                name = val;
              },
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  size: 18,
                  color: Colors.grey,
                ),
                labelText: 'Password',
              ),
              onChanged: (val) {
                password = val;
              },
            ),
            SizedBox(height: 30),
            RaisedButton(
                color: Colors.purple,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    _isNewUser ? 'SIGN UP' : 'LOG IN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                onPressed: () {
                  _isNewUser
                      ? Authservice().signup(name, password).then((val) {
                          Fluttertoast.showToast(
                            msg: val.data['msg'],
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.purple,
                            textColor: Colors.white,
                            fontSize: 16,
                          );
                        })
                      : Authservice().login(name, password).then((val) {
                          if (val.data['success']) {
                            token = val.data['token'];
                            Fluttertoast.showToast(
                              msg: 'Authenticated',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.purple,
                              textColor: Colors.white,
                              fontSize: 16,
                            );
                          }
                          setState(() {
                            _isAuthenticated = true;
                          });
                        });
                }),
            SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _isNewUser
                        ? 'Already have an account?'
                        : 'Need an account?',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isNewUser = !_isNewUser;
                      });
                    },
                    child: Text(
                      _isNewUser ? 'Login' : 'Signup',
                      style: TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isAuthenticated
          ? FloatingActionButton(
              child: Icon(
                Icons.person,
                size: 32,
              ),
              onPressed: () {
                Authservice().getinfo(token).then((val) {
                  Fluttertoast.showToast(
                    msg: val.data['msg'],
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.purple,
                    textColor: Colors.white,
                    fontSize: 16,
                  );
                });
              },
            )
          : null,
    );
  }
}
