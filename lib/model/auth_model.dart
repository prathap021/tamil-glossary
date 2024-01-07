class Tokens {
  String? logintoken;

  Tokens({this.logintoken});

  Tokens.fromJson(Map<String, dynamic> json) {
    logintoken = json['logintoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['logintoken'] = this.logintoken;
    return data;
  }
}
