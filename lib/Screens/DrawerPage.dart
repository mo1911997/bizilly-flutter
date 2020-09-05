import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  var token;
  final storage = FlutterSecureStorage();

  launchURL(String url) async
  {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: false,        
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: Container(
            color: Color.fromRGBO(31, 73, 125, 1.0),
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: RotatedBox(
                      quarterTurns: 1,
                      child: Opacity(
                        opacity: 0.75,
                        child: new Text(
                          "Bizilly",
                          style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 3.0,
                                  color: Colors.black,
                                ),
                                Shadow(
                                  offset: Offset(10.0, 10.0),
                                  blurRadius: 8.0,
                                  color: Colors.black,
                                ),
                              ],
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.12),
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.facebook),
                        color: Colors.white,
                        onPressed: () {
                          launchURL("https://www.facebook.com/unicef/");
                        }),
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.instagram),
                        color: Colors.white,
                        onPressed: () {
                          launchURL("https://www.instagram.com/unicef/");
                        }),                    
                    IconButton(
                        icon: FaIcon(FontAwesomeIcons.twitter),
                        color: Colors.white,
                        onPressed: () {
                          launchURL("https://www.twitter.com/unicef/");
                        }),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
