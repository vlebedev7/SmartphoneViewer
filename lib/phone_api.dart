import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/models.dart';

class PhoneApi {
  static const String _api_token =
      'b9807ee5a877f86fb2f5b2ef70c588fb71454978a4a4e464';

  List<Phone> getPhones(SearchSettings settings) {
    dynamic phonesData = loadPhones(settings.brand_name);
    var phones = <Phone>[];
    if (phonesData == null) 
      return phones;
    phonesData.foreach((phoneData){
      var phone = new Phone();
      phone.title = "$phoneData['Brand'] $phoneData['DeviceName']";
      phones.add(phone);
    });
    print("phones: ${phones.length}");
    return phones;
  }

  Future<dynamic> loadPhones(String brand_name) async {
    var res = await http.post("https://fonoapi.freshpixl.com/v1/getlatest",
        body: {'token': _api_token, 'brand': brand_name});
    var decRes = jsonDecode(res.body);
    print("decRes: $decRes");
    return decRes;
  }
}
