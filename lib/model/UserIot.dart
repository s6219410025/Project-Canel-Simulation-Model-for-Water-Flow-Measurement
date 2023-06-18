class UserIot {
  String? message;
  String? userId;
  String? userName;
  String? userPassword;
  String? userFullname;
  UserIot(
      {this.message,
      this.userId,
      this.userName,
      this.userPassword,
      this.userFullname});

  UserIot.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    userName = json['userName'];
    userPassword = json['userPassword'];
    userFullname = json['userFullname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['userPassword'] = this.userPassword;
    data['userFullname'] = this.userFullname;
    return data;
  }
}
