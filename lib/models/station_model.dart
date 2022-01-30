import 'dart:ffi';

class StationModel {
  String? country;
  String? address;
  String? comments;
  String? updatedBy;
  String? city;
  String? timeZoneOffset;
  List<VinList>? vinList;
  String? dealerCd;
  bool? isVisible;
  String? zipcode;
  String? createdAt;
  String? createdBy;
  String? stateName;
  String? stationName;
  String? stationId;
  String? updatedAt;
  double? lat;
  double? lng;

  StationModel(
      {this.country,
        this.address,
        this.comments,
        this.updatedBy,
        this.city,
        this.timeZoneOffset,
        this.vinList,
        this.dealerCd,
        this.isVisible,
        this.zipcode,
        this.createdAt,
        this.createdBy,
        this.stateName,
        this.stationName,
        this.stationId,
        this.updatedAt,
      this.lat,
      this.lng});

  StationModel.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    address = json['address'];
    comments = json['comments'];
    updatedBy = json['updatedBy'];
    city = json['city'];
    timeZoneOffset = json['timeZoneOffset'];
    if (json['vinList'] != null) {
      vinList = <VinList>[];
      json['vinList'].forEach((v) {
        vinList!.add(new VinList.fromJson(v));
      });
    }
    dealerCd = json['dealerCd'];
    isVisible = json['isVisible'];
    zipcode = json['zipcode'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    stateName = json['stateName'];
    stationName = json['stationName'];
    stationId = json['stationId'];
    updatedAt = json['updatedAt'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['address'] = this.address;
    data['comments'] = this.comments;
    data['updatedBy'] = this.updatedBy;
    data['city'] = this.city;
    data['timeZoneOffset'] = this.timeZoneOffset;
    if (this.vinList != null) {
      data['vinList'] = this.vinList!.map((v) => v.toJson()).toList();
    }
    data['dealerCd'] = this.dealerCd;
    data['isVisible'] = this.isVisible;
    data['zipcode'] = this.zipcode;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    data['stateName'] = this.stateName;
    data['stationName'] = this.stationName;
    data['stationId'] = this.stationId;
    data['updatedAt'] = this.updatedAt;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class VinList {
  String? vin;

  VinList({this.vin});

  VinList.fromJson(Map<String, dynamic> json) {
    vin = json['vin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vin'] = this.vin;
    return data;
  }
}
