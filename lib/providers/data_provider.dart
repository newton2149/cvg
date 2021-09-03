import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import "package:flutter/services.dart" as s;
import 'package:yaml/yaml.dart';

class DataProvider with ChangeNotifier {
  bool public = true;
  var username = TextEditingController();
  var password = TextEditingController();
  var gitRepoName = TextEditingController();
  Map<String, dynamic> item = {};
  var action = "";
  var responseKeyList = [];
  var responseValueList = [];
  var activityKeyList = [];
  var activityValueList = [];
  Map<String, dynamic> verified = {};
  Map<String, DateTime> activityLog = {};
  var activity = false;
  Map<String, String> activityNam = {
    "HC": "Hard Coding",
    "SS": "Static Scan",
    "CA": "Code Analysis",
    "SES": "Security Scan",
    "BP": "Best Practice",
    "CC": "Code Coverage",
  };

  Map get toJsonPublic {
    return {
      "GitUrl": gitRepoName,
      "isPublic": public,
      "Actions": action,
    };
  }

  Map get toJsonPrivate {
    return {
      "GitUrl": gitRepoName,
      "isPublic": public,
      "Actions": action,
      "Username": username,
      "Password": password,
    };
  }

  set publicKey(bool str) {
    this.public = str;
  }

  void falser() {
    this.public = !this.public;
    notifyListeners();
  }

  void listUpdate() {
    this.item.forEach((key, value) {
      this.responseKeyList.add(key);
      this.responseValueList.add(value);
    });
  }

  void fileSaver(String text) {
    // final text = 'this is the text file';
// prepare
    final bytes = utf8.encode(text);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '${DateTime.now()}.txt';
    html.document.body!.children.add(anchor);

// download
    anchor.click();

// cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  Future postMethodPublic(String action) async {
    print("Entered PostMethod Public");

    // final data = await s.rootBundle.loadString('assets/config.yaml');
    // final mapData = loadYaml(data);
    // print(mapData);
    // final Map json = {
    //   "GitUrl": gitRepoName.text,
    //   "isPublic": public,
    //   "Actions": action,
    // };

    try {
      http.Response response = await http.get(
        Uri.parse("https://reqres.in/api/users?page=2"),
        // body: jsonEncode(json),
      );

      if (response.statusCode == 200) {
        this.item = jsonDecode(response.body);
        final String? keyAction = activityNam[action];

        activityKeyList.insert(0, keyAction);
        activityValueList.insert(0, DateTime.now());

        listUpdate();
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  void itemClear() {
    this.item = {};
    notifyListeners();
  }

  void activityClear() {
    this.activityLog = {};
    this.activityKeyList = [];
    this.activityValueList = [];
    notifyListeners();
  }

  Future postMethodPrivate(String action) async {
    final data = await s.rootBundle.loadString('assets/config.yaml');
    final mapData = loadYaml(data);
    print(mapData);
    print("Entered PostMethod Private");
    final Map json = {
      "GitUrl": gitRepoName.text,
      "isPublic": public,
      "Actions": action,
      "Username": username.text,
      "Password": password.text,
    };

    try {
      http.Response response = await http.post(Uri.parse(mapData["httpUrl"]),
          body: jsonEncode(json));
      if (response.statusCode == 201) {
        this.item = jsonDecode(response.body);
        listUpdate();
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future isVerifiedPublic() async {
    final Map json = {
      "GitUrl": gitRepoName.text,
    };
    final data = await s.rootBundle.loadString('assets/config.yaml');
    final mapData = loadYaml(data);
    try {
      http.Response response = await http
          .post(Uri.parse(mapData["httpUrlVerify"]), body: jsonEncode(json));
      if (response.statusCode == 201) {
        this.verified = jsonDecode(response.body);
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
    }
  }

  Future isVerifiedPrivate() async {
    final Map json = {
      "GitUrl": gitRepoName.text,
      "Username": username.text,
      "Password": password.text,
    };
    final data = await s.rootBundle.loadString('assets/config.yaml');
    final mapData = loadYaml(data);
    try {
      http.Response response = await http
          .post(Uri.parse(mapData["httpUrlVerify"]), body: jsonEncode(json));
      if (response.statusCode == 201) {
        this.verified = jsonDecode(response.body);
        notifyListeners();
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
