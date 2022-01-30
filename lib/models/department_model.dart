class Department {
  List<DeptDetails>? deptDetails;

  Department({this.deptDetails});

  Department.fromJson(Map<String, dynamic> json) {
    if (json['deptDetails'] != null) {
      deptDetails = <DeptDetails>[];
      json['deptDetails'].forEach((v) {
        deptDetails!.add(new DeptDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.deptDetails != null) {
      data['deptDetails'] = this.deptDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeptDetails {
  String? deptName;
  String? deptCode;

  DeptDetails({this.deptName, this.deptCode});

  DeptDetails.fromJson(Map<String, dynamic> json) {
    deptName = json['deptName'];
    deptCode = json['deptCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deptName'] = this.deptName;
    data['deptCode'] = this.deptCode;
    return data;
  }
}
