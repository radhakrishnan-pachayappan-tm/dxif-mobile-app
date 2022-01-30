class StateModel {
  List<StateDetails>? data;

  StateModel({this.data});

  StateModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <StateDetails>[];
      json['data'].forEach((v) {
        data!.add(new StateDetails.fromJson(v));
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

class StateDetails {
  String? viewValue;
  String? abbrev;
  String? value;

  StateDetails({this.viewValue, this.abbrev, this.value});

  StateDetails.fromJson(Map<String, dynamic> json) {
    viewValue = json['viewValue'];
    abbrev = json['Abbrev'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewValue'] = this.viewValue;
    data['Abbrev'] = this.abbrev;
    data['value'] = this.value;
    return data;
  }
}
