import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  Future<dynamic> get(String url) async {
    var headers = await getHeaders();
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return convert.json.decode(convert.utf8.decode(response.bodyBytes));
  }

  Future<dynamic> post(String url, dynamic data) async {
    var headers = await getHeaders();
    http.Response response =
        await http.post(url, body: convert.json.encode(data), headers: headers);
    updateCookie(response);
    return convert.json.decode(convert.utf8.decode(response.bodyBytes));
  }

  void updateCookie(http.Response response) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      prefs.setString(
          "cookie", (index == -1) ? rawCookie : rawCookie.substring(0, index));
    }
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("accessToken");
    var headers = {
      "cookie": prefs.getString("cookie"),
      "Content-Type": "application/json"
    };
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }
}
