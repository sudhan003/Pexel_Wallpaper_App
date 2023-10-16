import 'package:animals_world/api/api_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController textEditingController;
  final Function() onPressed;

  const CustomSearchBar(
      {super.key,
      required this.textEditingController,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiProvider>(builder: (context, provider, _) {
      return Container(
          height: 40,
          width: MediaQuery.sizeOf(context).width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: textEditingController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(7.0),
                suffixIcon: IconButton(
                  padding: EdgeInsets.only(bottom: 10),
                  icon: const Icon(Icons.search),
                  color: Colors.red,
                  onPressed: () {
                    onPressed();
                    // if (provider.isTextRefresh) {
                    //   textEditingController.clear();
                    // }
                  },
                ),
                hintText: 'Search...',
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ));
    });
  }
}
