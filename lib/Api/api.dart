import 'dart:convert';
import 'dart:developer';

import 'package:bloc_demo/Api/url.dart';
import 'package:bloc_demo/Get/getmodal.dart';
import 'package:http/http.dart' as http;

import '../comman.dart';

class Api {
  getdata(int page, ProgressLoader pl) async {
    var request = http.MultipartRequest(
      'GET',
      Uri.parse('${Urls().basicUrl}${Urls().data}page=$page'),
    );
    var response = await http.Response.fromStream(await request.send());
    print('response.body Category List get ..........................');
    print(response.body);
    if (response.statusCode == 200) {
      await pl.hide();
      return GetModal.fromJson(jsonDecode(response.body));
    } else {
      await pl.hide();
      print('Error in getDistrictList()');
    }
  }


  post(String name, String job, ProgressLoader pl) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Urls().basicUrl + Urls().postdata),
    );
    print({
      'name': name,
      'job': job,
    });
    request.fields.addAll({
      'name': name,
      'job': job,
    });
    var response = await http.Response.fromStream(await request.send());
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      await pl.hide();
    }
  }
}

Api api = Api();
