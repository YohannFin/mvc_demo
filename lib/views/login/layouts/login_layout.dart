import 'package:flutter/material.dart';
import 'package:mvc_demo/controllers/main/main_controller.dart';
import 'package:mvc_demo/views/login/components/FadeAnimation.dart';
import 'package:smart_flare/smart_flare.dart';


class LoginLayout extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _LoginLayout();
  }
}


class _LoginLayout extends State<LoginLayout> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _isOK = false;
  bool _isError = false;
  void _submit(username, password, viewController, context) {
    viewController.getLogin(context, username, password).then((etat){
      if (etat)
      {
        setState(() => _isOK = true);
        setState(() => _isError = false);
        Future.delayed(Duration(seconds: 3), () => Navigator.of(context).pushReplacementNamed("/home"));
      }
      else
      {
        setState(() => _isOK = false);
        setState(() => _isError = true);
      }
    });
  }
   

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 80,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    MainController viewController = MainController();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        padding: EdgeInsets.only(left: 30, right: 30),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 30.0),
                child: SmartFlareActor(
                  width: 325.0,
                  height: 251.0,
                  filename: 'assets/FlyBank_logo.flr',
                  startingAnimation: 'activate')
              ),
              FadeAnimation(1.2, Text("Login", 
              style: TextStyle(color: Colors.black, fontFamily: "Poppins-Bold", fontSize: 40, fontWeight: FontWeight.bold),)),
              SizedBox(height: 30,),
              AnimatedOpacity(opacity: _isError ? 1.0 : 0.0, duration: Duration(milliseconds: 1500), child: Padding(padding: EdgeInsets.only(left: 12.0, bottom: 5), child: Text("Invalid username or password", style: TextStyle(color: Colors.red[500], fontSize: 16)))),
              FadeAnimation(1.5, Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Colors.grey[300]))
                      ),
                      child: TextField(
                        controller: _username,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: "Email or Username"
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                      ),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: "Password"
                        ),
                      ),
                    ),
                  ],
                ),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 12.0),
                    child:FadeAnimation(1.2,
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Poppins-Medium",
                              fontSize: 16),
                        )
                      ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              new FadeAnimation(1.8, Center(
                child: RaisedButton(
                  color: Colors.lightGreen[600],
                  onPressed: () => _submit(_username.text, _password.text, viewController, context),
                  padding: EdgeInsets.all(15),
                  child: Center(child: Text("Login", style: TextStyle(color: Colors.white.withOpacity(1)),)),
                ),
              )),
              _isOK ? Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5.0),
                child: SmartFlareActor(
                  width: 310.0,
                  height: 155.0,
                  filename: 'assets/success.flr',
                  startingAnimation: 'Untitled',
                  playStartingAnimationWhenRebuilt: true)
              ) :  Container(),
              _isError ? Padding(
                padding: EdgeInsets.only(left: 15.0, top: 5.0),
                child: SmartFlareActor(
                  width: 310.0,
                  height: 155.0,
                  filename: 'assets/error.flr',
                  startingAnimation: 'Error',
                  playStartingAnimationWhenRebuilt: true)
              ) :  Container()
            ],
          ),
      ),
    );
  }
}
