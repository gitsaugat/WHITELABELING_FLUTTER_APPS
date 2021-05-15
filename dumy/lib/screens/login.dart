import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:primo_flutter_app/models/arguments.dart';
import 'package:primo_flutter_app/models/quiz_list.dart';
import 'package:primo_flutter_app/services/login.dart';
import 'package:primo_flutter_app/utils/udf.dart';
import 'package:primo_flutter_app/widgets/bottom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';

InputDecoration customDecoration(
    String hintText, IconData icon, double iconSize) {
  return InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.white),
      prefixIcon: Icon(icon, color: Colors.white, size: iconSize));
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  bool showLoading = false;

  void onPressedLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (userNameCtrl.text.trim().length == 0) {
      _showToast("Username is required");
      return;
    }

    if (passwordCtrl.text.trim().length == 0) {
      _showToast("Password is required");
      return;
    }

    setState(() {
      showLoading = true;
    });

    bool isMail = EmailValidator.validate(userNameCtrl.text);

    var apiData = {"password": passwordCtrl.text};
    if (isMail) {
      apiData["email"] = userNameCtrl.text;
    } else {
      apiData["username"] = userNameCtrl.text;
    }

    var loginData = await LoginService().getToken(apiData);

    if (loginData["access"] != null) {
      prefs.setStringList("crede", [userNameCtrl.text, passwordCtrl.text]);
      prefs.setString("accessToken", loginData["access"]);

      var userData = loginData["user"];
      prefs.setStringList(
          "userData", [userData["first_name"], userData["last_name"]]);

      try {
        var response = await LoginService().getQuizId();
        setState(() {
          showLoading = false;
        });
        List<QuizListItem> quizList = [];
        if (response != null) {
          for (var item in response) {
            quizList.add(QuizListItem(id: item["id"], title: item["title"]));
          }
          if (quizList.length == 1) {
            Navigator.of(context).pushReplacementNamed("/category-list",
                arguments: CategoryListArguments(quizId: quizList[0].id));
          } else {
            Navigator.of(context).pushReplacementNamed("/quiz-list",
                arguments: QuizListArguments(quizList: quizList));
          }
        }
      } catch (e) {
        _showDialog("Error", "Something went wrong.");
      }
    } else {
      setState(() {
        showLoading = false;
      });
      _showDialog("Error", "Username/password not correct.");
    }
  }

  void _showToast(String message) {
    UDF().showToast(message);
  }

  void _showDialog(String title, String content) {
    UDF().showAlert(context, title, content);
  }

  void joinMeeting(url, room) async {
    try {
      var options = JitsiMeetingOptions()
        ..room = room
        ..serverURL = "https://$url";
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print(error.toString());
    }
  }

  parseLink(Uri uri) {
    var segments = uri.pathSegments;
    var host = uri.host;

    if (segments.length > 0) {
      var room = segments[0];
      joinMeeting(host, room);
    }
  }

  void initDynamicLinks() async {
    getLinksStream().listen((String link) {
      if (link != null) {
        var parsedUri = Uri.parse(link);
        parseLink(parsedUri);
      }
    }, onError: (err) {
      print(err);
    });

    Uri initialUri;
    try {
      var initialLink = await getInitialLink();
      if (initialLink != null) initialUri = Uri.parse(initialLink);
    } on PlatformException {
      initialUri = null;
    } on FormatException {
      initialUri = null;
    }
    if (initialUri != null) {
      parseLink(initialUri);
    }
  }

  fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void setIntialData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var credData = prefs.getStringList("crede");

    if (credData != null) {
      String userName = credData[0];
      String password = credData[1];

      setState(() {
        userNameCtrl.text = userName;
        passwordCtrl.text = password;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
    this.setIntialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            "images/home.jpg",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    "images/logo.png",
                    width: 150,
                    height: 150,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: ListView(
                      children: <Widget>[
                        TextField(
                            controller: userNameCtrl,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white),
                            textInputAction: TextInputAction.next,
                            focusNode: userNameFocus,
                            onSubmitted: (term) {
                              fieldFocusChange(
                                  context, userNameFocus, passwordFocus);
                            },
                            decoration: customDecoration(
                                "Username", Icons.person_outline, 25)),
                        TextField(
                            controller: passwordCtrl,
                            textInputAction: TextInputAction.go,
                            obscureText: true,
                            focusNode: passwordFocus,
                            onSubmitted: (term) {
                              SystemChannels.textInput
                                  .invokeMethod('TextInput.hide');
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: customDecoration(
                                "Password", Icons.lock_outline, 22)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomBarButton(
                    buttonName: !showLoading ? "Login" : "",
                    onPressed: () {
                      onPressedLogin();
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
