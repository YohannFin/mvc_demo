import 'package:flutter/material.dart';
import 'package:mvc_demo/controllers/main/main_controller.dart';
import 'package:mvc_demo/models/home/home_model.dart';
import 'package:mvc_demo/views/home/components/photo_card.dart';
import 'package:mvc_demo/views/home/components/photo_error_card.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MainController viewController = MainController();
    final viewModel = Provider.of<HomeModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("FlyBank"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewController.getter(context);
        },
        child: Icon(Icons.refresh),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (viewModel.status == HomeModelStatus.Loading)
              ? LinearProgressIndicator()
              : Container(),
          (viewModel.status == HomeModelStatus.Error)
              ? PhotoErrorCard(
                  errorMessage: viewModel.errorMessage,
                  onPressed: () {
                    viewController.getter(context);
                  },
                )
              : Container(),
          Expanded(
            flex: 1,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: viewModel.photos.length,
              itemBuilder: (context, index) {
                return PhotoCard(
                  thumbnailUrl: viewModel.photos[index].thumbnailUrl,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
