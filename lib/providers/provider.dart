import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  Future<String> parentLogin(String email, String password,String contact, String loginType) async {
    String result;
    final url = ('https://regalmojo.in/gymeDiary/api/memberApi/signIn');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body: json.encode({
          "loginUserName": email,
          "loginPassword": password,
          "regContact": contact,
          "loginType":loginType,
        }),
      );
      final responseData = json.decode(response.body);
      print('resPonseDataLogin: $responseData');
      if (responseData['messageType'] == 'success') {
        print('vjhhjghg');
        String decodeToken = responseData['data']['token'];
        Map<String, dynamic> decodedToken = JwtDecoder.decode(decodeToken);
        print(decodedToken['data']['role']);
        if (decodedToken['data']['role'] == 'parent') {
          profile(responseData['data']['token']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', responseData['data']['token']);
          result = 'success';
        }
      } else {
        result = responseData['messageType'];
      }
    } catch (error) {
      print('Login Error: $error');
      result = 'failed';
      throw error;
    }
    return result;
  }

  Future<Map<String, dynamic>> forgotPassword({String registeredEmail}) async {
    try {
      String url =
          'https://regalmojo.in/gymeDiary/api/memberApi/changePassword';
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=UTF-8',
          'Charset': 'utf-8'
        },
        body: json.encode({
          "resetPasswordNew": registeredEmail,
        }),
      );
      final responseData = json.decode(response.body);
      print(responseData.runtimeType);
      Map<String, dynamic> responseDataTypeConverted =
          new Map<String, dynamic>.from(responseData);
      print(responseDataTypeConverted);
      return responseDataTypeConverted;
    } catch (error) {
      throw error;
    }
  }

  Future<Map<String, dynamic>> shareMedia({String token}) async {
    try {
      String url = 'https://regalmojo.in/gymeDiary/api/memberApi/shareMedia';
      final response = await http.put(
        Uri.parse(url),
        headers: {
        'Authorization': 'Bearer $token',
        },
       
      );
      final responseData = json.decode(response.body);
      print(responseData.runtimeType);
      Map<String, dynamic> responseDataTypeConverted =
          new Map<String, dynamic>.from(responseData);
      print(responseDataTypeConverted);
      return responseDataTypeConverted;
    } catch (error) {
      throw error;
    }
  }

  Future<void> profile(String token) async {
    try {
      String url =
          'https://regalmojo.in/gymeDiary/api/memberApi/memberProfileData';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Map<String, dynamic> responseData = await json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('memberName', responseData['data']['memberName']);
      await prefs.setString(
          'memberCountry', responseData['data']['memberCountry']);
      await prefs.setString(
          'memberOccupation', responseData['data']['memberOccupation']);
      await prefs.setString('memberDob', responseData['data']['memberDob']);
      await prefs.setString(
          'memberNumber', responseData['data']['memberNumber']);
      await prefs.setString('memberEmail', responseData['data']['memberEmail']);
      await prefs.setString(
          'profileImage', responseData['data']['profileImage']);
      // List<dynamic> data = responseData['childrens'];
      // print(responseData['data']['profile_img']);
    } catch (error) {
      throw error;
    }
  }

  Future<void> gymInfoData(String token) async {
    try {
      String url = 'https://regalmojo.in/gymeDiary/api/memberApi/gymInfoData';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Map<String, dynamic> responseData = await json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'businessWebsite', responseData['data']['businessWebsite']);
      await prefs.setString(
          'businessEmail', responseData['data']['businessEmail']);
      await prefs.setString('address', responseData['data']['address']);
      await prefs.setString('city', responseData['data']['city']);
      await prefs.setString(
          'profileImage', responseData['data']['profileImage']);
      await prefs.setString('state', responseData['data']['state']);
      await prefs.setString(
          'businessName', responseData['data']['businessName']);
      await prefs.setString(
          'businessContact', responseData['data']['businessContact']);
      await prefs.setString(
          'twitterBusiness', responseData['data']['twitterBusiness']);
      await prefs.setString(
          'facebookBusiness', responseData['data']['facebookBusiness']);
      // List<dynamic> data = responseData['childrens'];
      // print(responseData['data']['profile_img']);
    } catch (error) {
      throw error;
    }
  }

  Future<void> timelineData(String token) async {
    try {
      String url =
          'https://regalmojo.in/gymeDiary/api/memberApi/timelineAllData?page=1&limit=2';
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Map<String, dynamic> responseData = await json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('_id', responseData['data']['_id']);
      await prefs.setString(
          'timelineLikes', responseData['data']['timelineLikes']);
      await prefs.setString(
          'timelineMedia', responseData['data']['timelineMedia']);
      await prefs.setString(
          'timelineCaption', responseData['data']['timelineCaption']);
      await prefs.setString('publisherMemberId',
          responseData['data']['PublisherMemberId']['_id']);
      await prefs.setString('publisherMemberId',
          responseData['data']['PublisherMemberId']['memberName']);
      await prefs.setString('publisherMemberId',
          responseData['data']['PublisherMemberId']['profileImage']);
      await prefs.setString('publisherMemberId',
          responseData['data']['PublisherMemberId']['regNo']);
      // List<dynamic> data = responseData['childrens'];
      // print(responseData['data']['profile_img']);
    } catch (error) {
      throw error;
    }
  }

  Future<void> toggleData(String token) async {
    try {
      String url =
          'https://regalmojo.in/gymeDiary/api/memberApi/timelineLikeToggle/6035f8d16867a838c74d1dde';
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      Map<String, dynamic> responseData = await json.decode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('liked', responseData['data']['liked']);

      // List<dynamic> data = responseData['childrens'];
      // print(responseData['data']['profile_img']);
    } catch (error) {
      throw error;
    }
  }
}
