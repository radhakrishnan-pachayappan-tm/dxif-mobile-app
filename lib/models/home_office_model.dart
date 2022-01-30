class HomeOffice {
  List<Data>? data;

  HomeOffice({this.data});

  HomeOffice.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? name;
  List<Subname>? subname;

  Data({this.name, this.subname});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['subname'] != null) {
      subname = <Subname>[];
      json['subname'].forEach((v) {
        subname!.add(new Subname.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.subname != null) {
      data['subname'] = this.subname!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subname {
  String? name;
  String? displayName;

  Subname({this.name, this.displayName});

  Subname.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    return data;
  }
}
