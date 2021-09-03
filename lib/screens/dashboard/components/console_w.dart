import 'package:admin/providers/data_provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../constants.dart';

class Console extends StatelessWidget {
  final scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final data = Provider.of<DataProvider>(context);
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Console",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: size.width * 0.7,
                    height: size.height * 0.6,
                    child: Scrollbar(
                      isAlwaysShown: true,
                      controller: scroll,
                      child: ListView.builder(
                        controller: scroll,
                        itemBuilder: (ctx, i) {
                          return Text(
                            "${data.responseKeyList[i]} : ${data.responseValueList[i]} \n",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        itemCount: data.responseKeyList.length,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
