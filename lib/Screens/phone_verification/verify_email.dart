import 'package:flutter/material.dart';
import 'package:VeViRe/Screens/phone_verification/numeric_pad.dart';
import 'package:VeViRe/bloc/RegistrationBloc.dart';
import 'package:VeViRe/utilities/constants.dart';

class VerifyEmail extends StatefulWidget {
  final String email;

  VerifyEmail({@required this.email});

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  String code = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  loader() {
    Dialog dialog = Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(
              backgroundColor: kPrimaryColor,
            )
          ],
        ),
      ),
    );
    showDialog(context: context, barrierDismissible: false, child: dialog);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Verify Email",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        textTheme: Theme.of(context).textTheme,
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.44,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Code is sent to ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF818181),
                  ),
                ),
                Text(
                  widget.email,
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF818181),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildCodeNumberBox(
                        code.length > 0 ? code.substring(0, 1) : ""),
                    buildCodeNumberBox(
                        code.length > 1 ? code.substring(1, 2) : ""),
                    buildCodeNumberBox(
                        code.length > 2 ? code.substring(2, 3) : ""),
                    buildCodeNumberBox(
                        code.length > 3 ? code.substring(3, 4) : ""),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Didn't recieve code? ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF818181),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        print("Resend the code to the user");
                      },
                      child: Text(
                        "Request again",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: NumericPad(
              onNumberSelected: (value) async {
                print(value);
                setState(() {
                  if (value != -1) {
                    if (code.length < 4) {
                      code = code + value.toString();
                    }
                  } else {
                    code = code.substring(0, code.length - 1);
                  }
                  registrationBloc.code.value = code;
                });
                if (code.length == 4) {
                  loader();
                  var resp = await registrationBloc.verifyEmail();
                  if (resp == 'success') {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context, "from verify email");
                  } else {
                    Navigator.pop(context);
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content: Text(
                        resp.toString(),
                        style: TextStyle(fontFamily: 'Raleway'),
                      ),
                      duration: Duration(seconds: 3),
                    ));
                  }
                }
              },
            ),
          ),
        ],
      )),
    );
  }

  Widget buildCodeNumberBox(String codeNumber) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Container(
          decoration: BoxDecoration(
              color: Color(0xFFF6F5FA),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              border: Border.all(color: kPrimaryColor)
              // boxShadow: <BoxShadow>[
              //   BoxShadow(
              //       color: Colors.black26,
              //       blurRadius: 25.0,
              //       spreadRadius: 1,
              //       offset: Offset(0.0, 0.75))
              // ],
              ),
          child: Center(
            child: Text(
              codeNumber,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1F1F),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
