class StateListModel {
  bool? error;
  String? msg;
  Data? data;

  StateListModel({this.error, this.msg, this.data});

  StateListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? iso3;
  String? iso2;
  List<StatesList>? statesList;

  Data({this.name, this.iso3, this.iso2, this.statesList});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    iso3 = json['iso3'];
    iso2 = json['iso2'];
    if (json['states'] != null) {
      statesList = <StatesList>[];
      json['states'].forEach((v) {
        statesList!.add(new StatesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['iso3'] = this.iso3;
    data['iso2'] = this.iso2;
    if (this.statesList != null) {
      data['states'] = this.statesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StatesList {
  String? name;
  String? stateCode;

  StatesList({this.name, this.stateCode});

  StatesList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    stateCode = json['state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['state_code'] = this.stateCode;
    return data;
  }
}
