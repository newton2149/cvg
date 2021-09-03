import 'package:admin/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../components/access.dart';

class Authentication extends StatelessWidget {
  const Authentication({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "Auth",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          Form(
            child: Column(
              children: [
                Container(
                  height: 45,
                  child: TextFormField(
                    controller: data.gitRepoName,
                    decoration: InputDecoration(
                      labelText: "RepoName",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: defaultPadding),
                AccessRadiotile(),
                data.public
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (data.public) {
                                data.isVerifiedPublic();
                              } else {
                                data.isVerifiedPublic();
                              }
                              var verified = data.verified["exists"];
                              //
                              String displayText = "";
                              if (verified) {
                                displayText = "succesfully";
                              } else {
                                displayText = "and does not exist";
                              }
                              showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Verification Status",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      content: Text(
                                        "${data.gitRepoName.text} verified $displayText with  \nbranch -> ${data.verified["fullBranchName"]} ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context, 'OK');
                                            data.verified = {};
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  });

                              print(data.gitRepoName.text);
                            },
                            child: Text("Validate"),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            height: 45,
                            child: TextFormField(
                              controller: data.username,
                              decoration: InputDecoration(
                                labelText: "UserName",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          Container(
                            height: 45,
                            child: TextFormField(
                              controller: data.password,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: defaultPadding),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Validate"),
                              ),
                            ],
                          )
                        ],
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
