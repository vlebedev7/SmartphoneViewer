import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/models.dart';

class PhoneApi {
  static const String _api_token =
      'b9807ee5a877f86fb2f5b2ef70c588fb71454978a4a4e464';

  static Future<List<Phone>> getPhones(SearchSettings settings) async {
    //var list = await Future.wait([asyncFunc1(), asyncFunc2()]);
    //print(list[1]);
    List phonesData = (await loadPhones(settings.brandName)) as List;
    print('getPhones() phonesData:${phonesData.length}');
    var phones = <Phone>[];
    if (phonesData == null) return phones;
    phones = phonesData.map((phoneData) => Phone.fromJson(phoneData)).toList();
    
    print("phones: ${phones.length}");
    return phones;
  }

  static Future<dynamic> loadPhones(String brandName) async {
    var res = await http.post("https://fonoapi.freshpixl.com/v1/getlatest",
        body: {'token': _api_token, 'brand': brandName});
    var decodedResuslt = jsonDecode(res.body);
    print("decodedResuslt: ${decodedResuslt.toString().length}");
    return decodedResuslt;
  }
}
