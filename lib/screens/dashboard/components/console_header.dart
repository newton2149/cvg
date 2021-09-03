import 'package:admin/models/MyFiles.dart';
import 'package:admin/providers/data_provider.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class ConsoleHeader extends StatelessWidget {
  const ConsoleHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context);
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                if (data.item.length == 0) {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).canvasColor,
                          title: Text(
                            "No Report Found",
                            style: TextStyle(color: Colors.deepOrange.shade100),
                          ),
                          content: Text(
                            "Please trigger some actions to download the \nbuild report",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          actions: [
                            // TextButton(
                            //   onPressed: () =>
                            //       Navigator.pop(context, 'Cancel'),
                            //   child: const Text('Cancel'),
                            // ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                } else {
                  data.fileSaver(data.item.toString());
                }
              },
              child: Text("Download"),
            ),
            SizedBox(width: defaultPadding),
            ElevatedButton(
              onPressed: () {
                if (data.item.length != 0) {
                  data.itemClear();
                  data.responseKeyList = [];
                  data.responseValueList = [];
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Theme.of(context).canvasColor,
                          title: Text(
                            "Nothing to Clear",
                            style: TextStyle(color: Colors.deepOrange.shade100),
                          ),
                          content: Text(
                            "Console is empty ",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      });
                }
              },
              child: Text("Clear"),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demoMyFiles[index]),
    );
  }
}
