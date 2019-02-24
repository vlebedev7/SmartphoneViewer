import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/models.dart';

class PhoneApi {
  static const String _api_token =
      'b9807ee5a877f86fb2f5b2ef70c588fb71454978a4a4e464';

  static List<Phone> getPhones(SearchSettings settings) {
    dynamic phonesData = loadPhones(settings.brandName);
    var phones = <Phone>[];
    if (phonesData == null) return phones;
    phonesData.foreach((phoneData) {
      phones.add(new Phone("$phoneData['Brand'] $phoneData['DeviceName']"));
    });
    print("phones: ${phones.length}");
    return phones;
  }

  static Future<dynamic> loadPhones(String brandName) async {
    var res = await http.post("https://fonoapi.freshpixl.com/v1/getlatest",
        body: {'token': _api_token, 'brand': brandName});
    var decodedResuslt = jsonDecode(res.body);
    print("decodedResuslt: $decodedResuslt");
    return decodedResuslt;
  }
}
