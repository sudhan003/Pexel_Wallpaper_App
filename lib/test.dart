import 'package:animals_world/home_screen.dart';
import 'package:animals_world/widgets/custom_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'api/api_function.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  void initState() {
    super.initState();
    print('INITSTATE 1 😎😎😎');
    print('INITSTATE 12 😎😎😎');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(builder: (context, provider, _) {
      return Scaffold(
        body: Column(
          children: [
            buildSearchBar(context, () {
              provider.tinyUrl.clear();
              //NEED TO CREATE A NEW BOOL VAR FOR SEARCH 😗😗😗😗😗
              provider.apiPost(
                  isRefresh: true, tag: textEditingController.text);
            }),
            Expanded(
              flex: 2,
              child: SmartRefresher(
                header: const WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = const Text("pull up load");
                    } else if (mode == LoadStatus.loading) {
                      body = const CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = const Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = const Text("release to load more");
                    } else {
                      body = const Text("thank you for waiting");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: provider.refreshController,
                enablePullUp: true,
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                onRefresh: () async {
                  // print("the test is ${textEditingController.text}🙃🙃🙃");

                  await provider.apiPost(isRefresh: true, tag: "animals");
                  provider.isTextRefresh = true;
                  if (provider.isLoading == false) {
                    provider.refreshController.refreshCompleted();
                  } else {
                    provider.refreshController.refreshFailed();
                  }
                },
                onLoading: () async {
                  print("the test is ${textEditingController.text}🙃🙃🙃");
                  if (provider.isTextRefresh) {
                    textEditingController.text = 'animals';
                  }

                  await provider.apiPost(tag: textEditingController.text);
                  if (provider.isLoading == false) {
                    provider.refreshController.loadComplete();
                  } else {
                    provider.refreshController.loadFailed();
                  }
                },
                child: GridView.builder(
                  itemCount: provider.tinyUrl.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        child: Image(
                          image: NetworkImage(
                            provider.tinyUrl[index],
                          ),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

TextEditingController textEditingController = TextEditingController();

Widget buildSearchBar(BuildContext context, Function() onPressed) {
  return Stack(
    children: [
      SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.3,
        width: MediaQuery.sizeOf(context).width,
        child: Image.asset(
          "assets/search_background.jpg",
          fit: BoxFit.fitWidth,
        ),
      ),
      Positioned(
        top: MediaQuery.sizeOf(context).height * 0.15,
        left: MediaQuery.sizeOf(context).width * 0.1,
        right: MediaQuery.sizeOf(context).width * 0.1,
        child: CustomSearchBar(
          textEditingController: textEditingController,
          onPressed: onPressed,
        ),
      ),
    ],
  );
}
// future: provider.apiPost(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.waiting) {
// return const Center(
// child: SizedBox(
// height: 30,
// width: 50,
// child: LoadingIndicator(
// indicatorType: Indicator.lineScale,
// colors: [
// Colors.purple,
// ],
// ),
// ),
// );
// } else if (snapshot.hasError) {
// return Center(
// child: Text("Error ${snapshot.error}"),
// );
// } else {
// List<String> images = snapshot.data!.cast<String>();
// return GridView.builder(
// itemCount: snapshot.data!.length,
// gridDelegate:
// const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 3,
// crossAxisSpacing: 10,
// mainAxisSpacing: 10,
// ),
// itemBuilder: (context, index) {
// return ClipRRect(
// borderRadius: BorderRadius.circular(15),
// child: SizedBox(
// height: MediaQuery.sizeOf(context).height * 0.15,
// child: Image(
// image: NetworkImage(
// images[index],
// ),
// fit: BoxFit.fitHeight,
// ),
// ),
// );
// },
// );
// }
// }),
