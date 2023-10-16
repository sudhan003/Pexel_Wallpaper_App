// import 'package:animals_world/api/api_function.dart';
// import 'package:animals_world/model/api_response_model.dart';
// import 'package:animals_world/widgets/custom_search_bar.dart';
// import 'package:animals_world/widgets/image_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
//
// import 'api.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   RefreshController waitingController = RefreshController();
//   TextEditingController textEditingController = TextEditingController();
//   bool isWaiting = false;
//
//   // ConnectionState connectionState = ConnectionState.waiting;
//
//   @override
//   void initState() {
//     super.initState();
//     // ApiProvider();
//     Api.apiFunction();
//   }
//
//   RefreshController refreshController = RefreshController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ApiProvider>(builder: (context, provider, _) {
//       return Scaffold(
//         body: Column(
//           children: [
//             buildSearchBar(context),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.only(
//                   left: 20.0,
//                   right: 20.0,
//                   top: 20.0,
//                   bottom: 0.0,
//                 ),
//                 child: SmartRefresher(
//                   controller: refreshController,
//                   enablePullUp: true,
//                   onRefresh: () async {
//                     await provider.apiPost(isRefresh: true);
//                     if (provider.isLoading == false) {
//                       provider.refreshController.refreshCompleted();
//                     } else {
//                       provider.refreshController.refreshFailed();
//                     }
//                   },
//                   onLoading: () async {
//                     await provider.apiPost();
//                     if (provider.isLoading == false) {
//                       provider.refreshController.loadComplete();
//                     } else {
//                       provider.refreshController.loadFailed();
//                     }
//                   },
//                   child: FutureBuilder<List<String>>(
//                       // future: provider.tinyUrl.length,
//                       builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return const Center(
//                         child: SizedBox(
//                           height: 30,
//                           width: 50,
//                           child: LoadingIndicator(
//                             indicatorType: Indicator.lineScale,
//                             colors: [
//                               Colors.purple,
//                             ],
//                           ),
//                         ),
//                       );
//                     } else if (snapshot.hasError) {
//                       return Center(
//                         child: Text("Error ${snapshot.error}"),
//                       );
//                     } else {
//                       List<String> images = snapshot.data!.cast<String>();
//                       return GridView.builder(
//                         itemCount: snapshot.data!.length,
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 3,
//                           crossAxisSpacing: 10,
//                           mainAxisSpacing: 10,
//                         ),
//                         itemBuilder: (context, index) {
//                           return ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: SizedBox(
//                               height: MediaQuery.sizeOf(context).height * 0.15,
//                               child: Image(
//                                 image: NetworkImage(
//                                   images[index],
//                                 ),
//                                 fit: BoxFit.fitHeight,
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                   }),
//                 ),
//               ),
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
//
// // Widget buildSearchBar(BuildContext context) {
// //   return Stack(
// //     children: [
// //       SizedBox(
// //         height: MediaQuery.sizeOf(context).height * 0.3,
// //         width: MediaQuery.sizeOf(context).width,
// //         child: Image.asset(
// //           "assets/search_background.jpg",
// //           fit: BoxFit.fitWidth,
// //         ),
// //       ),
// //       Positioned(
// //         top: MediaQuery.sizeOf(context).height * 0.15,
// //         left: MediaQuery.sizeOf(context).width * 0.1,
// //         right: MediaQuery.sizeOf(context).width * 0.1,
// //         child: const CustomSearchBar(tt),
// //       ),
// //     ],
// //   );
// // }
// // child: FutureBuilder<List<String>>(
// // future: provider.apiPost(),
// // builder: (context, snapshot) {
// // if (snapshot.hasError) {
// // return Center(
// // child: Text("Error ${snapshot.error}"),
// // );
// // } else {
// // List<String> images = snapshot.data!;
// // return GridView.builder(
// // itemCount: snapshot.data!.length,
// // gridDelegate:
// // const SliverGridDelegateWithFixedCrossAxisCount(
// // crossAxisCount: 3,
// // crossAxisSpacing: 10,
// // mainAxisSpacing: 10,
// // ),
// // itemBuilder: (context, index) {
// // return ClipRRect(
// // borderRadius: BorderRadius.circular(15),
// // child: SizedBox(
// // height:
// // MediaQuery.sizeOf(context).height * 0.15,
// // child: Image(
// // image: NetworkImage(
// // images[index],
// // ),
// // fit: BoxFit.fitHeight,
// // ),
// // ),
// // );
// // },
// // );
// // }
// // }),
