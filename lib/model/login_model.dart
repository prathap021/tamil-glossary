class LoginModel {
  String? result;
  String? reason;
  int? lguserid;
  String? lgusername;

  LoginModel({this.result, this.reason, this.lguserid, this.lgusername});

  LoginModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    reason = json['reason'];
    lguserid = json['lguserid'];
    lgusername = json['lgusername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['reason'] = this.reason;
    data['lguserid'] = this.lguserid;
    data['lgusername'] = this.lgusername;
    return data;
  }
}
