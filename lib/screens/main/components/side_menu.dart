import 'package:admin/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  SnackBar showSnackBarBefore(BuildContext context, String message) {
    return SnackBar(
      content: Text(
        "$message Initiated ",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  SnackBar showSnackBarAfter(BuildContext context, String message) {
    return SnackBar(
      duration: Duration(seconds: 4),
      content: Text(
        "$message succesfully finished ",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).canvasColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataProvider>(context, listen: false);
    var st = ScaffoldMessenger.of(context);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              "Code Validation Gateway",
              style: TextStyle(
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          DrawerListTile(
            title: "Hard Coding",
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              print(data.gitRepoName.text);
              st.showSnackBar(
                showSnackBarBefore(context, "Hard Coding"),
              );

              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("HC").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Hard Coding"));
                });
              } else {
                data.postMethodPrivate("HC").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Hard Coding"));
                });
              }
            },
          ),
          DrawerListTile(
            title: "Static Scan",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("SS").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Static Scan"));
                });
              } else {
                data.postMethodPrivate("SS").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Static Scan"));
                });
              }
            },
          ),
          DrawerListTile(
            title: "Code Analysis",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("CA").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Code Analysis"));
                });
              } else {
                data.postMethodPrivate("CA").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Code Analysis"));
                });
              }
            },
          ),
          DrawerListTile(
            title: "Security Scan",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("SES").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Securtiy Scan"));
                });
              } else {
                data.postMethodPrivate("SES").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Securtiy Scan"));
                });
              }
            },
          ),
          DrawerListTile(
            title: "Best Practices",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              
              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("BP").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Best Practice"));
                });
              } else {
                data.postMethodPrivate("BP").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Best Practice"));
                });
              }
            },
          ),
          DrawerListTile(
            title: "Code Coverage",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              data.itemClear();
              data.responseKeyList = [];
              data.responseValueList = [];
              if (data.public) {
                data.postMethodPublic("CC").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Code Coverage"));
                });
              } else {
                data.postMethodPrivate("CC").then((value) {
                  st.clearSnackBars();
                  st.showSnackBar(showSnackBarAfter(context, "Code Coverage"));
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
