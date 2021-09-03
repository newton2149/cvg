import 'package:admin/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessRadiotile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: RadioListTile(
              title: Text(
                "Private",
              ),
              value: false,
              groupValue: data.public,
              onChanged: (dynamic value) {
                data.falser();
              }),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: RadioListTile(
              title: Text(
                "Public",
              ),
              value: true,
              groupValue: data.public,
              onChanged: (dynamic value) {
                data.falser();
              }),
        ),
      ],
    );
  }
}
