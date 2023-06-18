class SensorValue {
  String? message;
  String? id;
  String? val;
  String? val2;
  String? date;
  String? time;


  SensorValue(
      {this.message,
      this.id,
      this.val,
      this.val2,
      this.date,
      this.time});

  SensorValue.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    id = json['id'];
    val = json['val'];
    val2 = json['val2'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['id'] = this.id;
    data['val'] = this.val;
    data['val2'] = this.val2;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}
