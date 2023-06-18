class SetpointValue {
  String? message;
  String? id;
  String? setPoint;
  String? setpointDate;
  String? setpointTime;


  SetpointValue(
      {this.message,
      this.id,
      this.setPoint,
      this.setpointDate,
      this.setpointTime});

  SetpointValue.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    setPoint = json['setPoint'];
    setpointDate = json['setpointDate'];
    setpointTime = json['setpointTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['setPoint'] = this.setPoint;
    data['setpointDate'] = this.setpointDate;
    data['setpointTime'] = this.setpointTime;
    return data;
  }
}
