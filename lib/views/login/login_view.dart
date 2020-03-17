import 'package:flutter/material.dart';
//import 'package:mvc_demo/views/home/layouts/home_layout.dart';
import 'package:mvc_demo/views/login/layouts/login_layout.dart';
import 'package:provider/provider.dart';
// import model
import 'package:mvc_demo/models/login/login_model.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new ChangeNotifierProvider<LoginModel>(
      create: (context) => LoginModel.instance(),
      child: Consumer<LoginModel>(
        builder: (context, viewModel, child) {
          return LoginLayout();
        },
      ),
    );
  }
}
