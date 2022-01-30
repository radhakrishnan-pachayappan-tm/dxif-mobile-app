class Reservation {
  String? dealerCd;
  bool? contactLess;
  String? action;
  String? reservationType;
  Filter? filter;
  List<DriverDetails>? driverDetails;
  ReservedBy? reservedBy;
  ReservedFor? reservedFor;
  String? timezoneOffset;
  Department? department;
  Reserve? reserve;
  TermsAndCondition? termsAndCondition;

  Reservation(
      {this.dealerCd,
        this.contactLess,
        this.action,
        this.reservationType,
        this.filter,
        this.driverDetails,
        this.reservedBy,
        this.reservedFor,
        this.timezoneOffset,
        this.department,
        this.reserve,
        this.termsAndCondition});

  Reservation.fromJson(Map<String, dynamic> json) {
    dealerCd = json['dealerCd'];
    contactLess = json['contactLess'];
    action = json['action'];
    reservationType = json['reservationType'];
    filter =
    json['filter'] != null ? new Filter.fromJson(json['filter']) : null;
    if (json['driverDetails'] != null) {
      driverDetails = <DriverDetails>[];
      json['driverDetails'].forEach((v) {
        driverDetails!.add(new DriverDetails.fromJson(v));
      });
    }
    reservedBy = json['reservedBy'] != null
        ? new ReservedBy.fromJson(json['reservedBy'])
        : null;
    reservedFor = json['reservedFor'] != null
        ? new ReservedFor.fromJson(json['reservedFor'])
        : null;
    timezoneOffset = json['timezoneOffset'];
    department = json['department'] != null
        ? new Department.fromJson(json['department'])
        : null;
    reserve =
    json['reserve'] != null ? new Reserve.fromJson(json['reserve']) : null;
    termsAndCondition = json['termsAndCondition'] != null
        ? new TermsAndCondition.fromJson(json['termsAndCondition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dealerCd'] = this.dealerCd;
    data['contactLess'] = this.contactLess;
    data['action'] = this.action;
    data['reservationType'] = this.reservationType;
    if (this.filter != null) {
      data['filter'] = this.filter!.toJson();
    }
    if (this.driverDetails != null) {
      data['driverDetails'] =
          this.driverDetails!.map((v) => v.toJson()).toList();
    }
    if (this.reservedBy != null) {
      data['reservedBy'] = this.reservedBy!.toJson();
    }
    if (this.reservedFor != null) {
      data['reservedFor'] = this.reservedFor!.toJson();
    }
    data['timezoneOffset'] = this.timezoneOffset;
    if (this.department != null) {
      data['department'] = this.department!.toJson();
    }
    if (this.reserve != null) {
      data['reserve'] = this.reserve!.toJson();
    }
    if (this.termsAndCondition != null) {
      data['termsAndCondition'] = this.termsAndCondition!.toJson();
    }
    return data;
  }
}

class Filter {
  Model? model;

  Filter({this.model});

  Filter.fromJson(Map<String, dynamic> json) {
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    return data;
  }
}

class Model {
  String? modelDescription;

  Model({this.modelDescription});

  Model.fromJson(Map<String, dynamic> json) {
    modelDescription = json['modelDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelDescription'] = this.modelDescription;
    return data;
  }
}

class DriverDetails {
  String? title;
  String? firstName;
  String? lastName;
  String? licence;
  String? expiry;
  String? state;
  String? email;
  String? secEmail;
  String? customerType;
  String? phone;
  String? homeOffice;

  DriverDetails(
      {this.title,
        this.firstName,
        this.lastName,
        this.licence,
        this.expiry,
        this.state,
        this.email,
        this.secEmail,
        this.customerType,
        this.phone,
        this.homeOffice});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    licence = json['licence'];
    expiry = json['expiry'];
    state = json['state'];
    email = json['email'];
    secEmail = json['secEmail'];
    customerType = json['customerType'];
    phone = json['phone'];
    homeOffice = json['homeOffice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['licence'] = this.licence;
    data['expiry'] = this.expiry;
    data['state'] = this.state;
    data['email'] = this.email;
    data['secEmail'] = this.secEmail;
    data['customerType'] = this.customerType;
    data['phone'] = this.phone;
    data['homeOffice'] = this.homeOffice;
    return data;
  }
}

class ReservedBy {
  String? firstName;
  String? lastName;
  String? userId;

  ReservedBy({this.firstName, this.lastName, this.userId});

  ReservedBy.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userId'] = this.userId;
    return data;
  }
}

class ReservedFor {
  String? firstName;
  String? lastName;
  String? userId;
  String? customerType;
  String? email;
  String? phone;

  ReservedFor(
      {this.firstName,
        this.lastName,
        this.userId,
        this.customerType,
        this.email,
        this.phone});

  ReservedFor.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    userId = json['userId'];
    customerType = json['customerType'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userId'] = this.userId;
    data['customerType'] = this.customerType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}

class Department {
  String? name;
  String? code;

  Department({this.name, this.code});

  Department.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class Reserve {
  String? startDateTime;
  String? endDateTime;
  String? station;

  Reserve({this.startDateTime, this.endDateTime, this.station});

  Reserve.fromJson(Map<String, dynamic> json) {
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    station = json['station'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['station'] = this.station;
    return data;
  }
}

class TermsAndCondition {
  String? accepted;
  String? timestamp;

  TermsAndCondition({this.accepted, this.timestamp});

  TermsAndCondition.fromJson(Map<String, dynamic> json) {
    accepted = json['accepted'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accepted'] = this.accepted;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
