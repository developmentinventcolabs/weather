class CountryListModel {
  bool? error;
  String? msg;
  List<CountryList>? countryList;

  CountryListModel({this.error, this.msg, this.countryList});

  CountryListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    msg = json['msg'];
    if (json['data'] != null) {
      countryList = <CountryList>[];
      json['data'].forEach((v) {
        countryList!.add(new CountryList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['msg'] = this.msg;
    if (this.countryList != null) {
      data['data'] = this.countryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CountryList {
  String? name;
  String? capital;
  String? iso2;
  String? iso3;

  CountryList({this.name, this.capital, this.iso2, this.iso3});

  CountryList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    capital = json['capital'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['capital'] = this.capital;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    return data;
  }
}
