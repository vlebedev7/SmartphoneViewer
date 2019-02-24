part of models;

class Phone {
  String title;

  Phone(this.title);

  static Phone fromJson(dynamic data){
    var phone = new Phone("${data['DeviceName']}");
    return phone;
  } 
}
