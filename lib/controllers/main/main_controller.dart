import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import view
import 'package:mvc_demo/views/home/home_view.dart';
import 'package:mvc_demo/views/login/login_view.dart';
// import model
import 'package:mvc_demo/models/home/home_model.dart';
import 'package:mvc_demo/models/login/login_model.dart';



final routes = {
  '/login':         (BuildContext context) => new LoginView(),
  '/home':          (BuildContext context) => new HomeView(),
  '/' :             (BuildContext context) => new LoginView(),
};


class MainController {
  MainController();
  bool userOk = false;
  void getter(BuildContext context) {
    HomeModel viewModel = Provider.of<HomeModel>(context, listen: false);
    // Add code here for getter
    viewModel.getter();
  }

  void setter(BuildContext context) {
    HomeModel viewModel = Provider.of<HomeModel>(context, listen: false);
    // Add code here for setter
    viewModel.setter();
  }

  void update(BuildContext context) {
    HomeModel viewModel = Provider.of<HomeModel>(context, listen: false);
    // Add code here for update
    viewModel.update();
  }

  void remove(BuildContext context) {
    HomeModel viewModel = Provider.of<HomeModel>(context, listen: false);
    // Add code here for remove
    viewModel.remove();
  }

  Future<bool> getLogin(BuildContext context, String username, String password) async{
    LoginModel viewModel = Provider.of<LoginModel>(context, listen: false);
    String result = await viewModel.insertUserDefault();
    if (result.toString() == 'ok')
    {
      bool test = await viewModel.getUser(username, password);
      if (test)
      {
        return true;
      }
      else
      {
        return false;
      }
    }
    else
    {
      return false;
    }
  }
}
