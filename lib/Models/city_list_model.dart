class CityListModel {
  bool? error;
  String? msg;
  List<String>? cityList;

  CityListModel({this.error, this.msg, this.cityList});

  CityListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    cityList = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    data['data'] = this.cityList;
    return data;
  }
}
