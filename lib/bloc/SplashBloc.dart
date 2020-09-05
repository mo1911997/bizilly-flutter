import 'package:flutter/cupertino.dart';
import 'package:VeViRe/Screens/Community_Screen/community_screen.dart';
import 'package:VeViRe/Screens/Walkthrough.dart';
import 'package:VeViRe/repositories/Repositories.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashBloc {
  var token;
  final storage = FlutterSecureStorage();
  Repositories repositories = Repositories();
  getCommunitiesAndCategories() {
    repositories.getCommunitiesAndCategories();
  }

  Future<Widget> getToken() async { 
    token = await storage.read(key: "first_time");
    if (token == null) {
      getCommunitiesAndCategories();
      print("inhere");
      return Walkthrough();
    } else {
      getCommunitiesAndCategories();
      return CommunityScreen();
    }
  }
}

final splashBloc = SplashBloc();
