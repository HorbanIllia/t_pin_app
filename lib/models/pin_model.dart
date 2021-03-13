class Pin{
  bool access;
  String message;

  Pin({this.access, this.message,});

  Pin.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    message = json['message'];
  }

}