import 'package:admin/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class ActivityLog extends StatelessWidget {
  final scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(
              "Activity Log",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: ElevatedButton(
              onPressed: () {
                data.activityClear();
              },
              child: Text("Clear Activity Log"),
            ),
          ),
          SizedBox(height: defaultPadding),
          ListTile(
            title: Text("Action"),
            trailing: Text("Date&Time"),
          ),
          Container(
            height: size.height * 0.3,
            child: Scrollbar(
              isAlwaysShown: true,
              controller: scroll,
              child: ListView.builder(
                controller: scroll,
                itemBuilder: (context, i) {
                  print(data.activityKeyList);
                  return ListTile(
                    title: Text(data.activityKeyList[i]),
                    trailing: Text(data.activityValueList[i].toString()),
                  );
                },
                itemCount: data.activityKeyList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
