class InventoryModel {
  List<VehicleSummary>? vehicleSummary;
  Pagination? pagination;

  InventoryModel({this.vehicleSummary, this.pagination});

  InventoryModel.fromJson(Map<String, dynamic> json) {
    if (json['vehicleSummary'] != null) {
      vehicleSummary = <VehicleSummary>[];
      json['vehicleSummary'].forEach((v) {
        vehicleSummary!.add(new VehicleSummary.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vehicleSummary != null) {
      data['vehicleSummary'] =
          this.vehicleSummary!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class VehicleSummary {
  bool? isPromotable;
  String? acquiredMethod;
  String? updatedBy;
  String? inventoryStatus;
  String? dealerCd;
  FleetInfo? fleetInfo;
  IntColor? intColor;
  List<Media>? media;
  String? certificationStatus;
  bool? promoted;
  String? createdAt;
  bool? incomplete;
  String? acquiredDate;
  String? createdBy;
  List<Audit>? audit;
  Price? price;
  String? hardwareCode;
  ExtColor? extColor;
  Model? model;
  String? vin;
  String? brand;
  String? createUpdateTraceId;
  String? mileage;
  String? updatedAt;

  VehicleSummary(
      {this.isPromotable,
        this.acquiredMethod,
        this.updatedBy,
        this.inventoryStatus,
        this.dealerCd,
        this.fleetInfo,
        this.intColor,
        this.media,
        this.certificationStatus,
        this.promoted,
        this.createdAt,
        this.incomplete,
        this.acquiredDate,
        this.createdBy,
        this.audit,
        this.price,
        this.hardwareCode,
        this.extColor,
        this.model,
        this.vin,
        this.brand,
        this.createUpdateTraceId,
        this.mileage,
        this.updatedAt});

  VehicleSummary.fromJson(Map<String, dynamic> json) {
    isPromotable = json['isPromotable'];
    acquiredMethod = json['acquiredMethod'];
    updatedBy = json['updatedBy'];
    inventoryStatus = json['inventoryStatus'];
    dealerCd = json['dealerCd'];
    fleetInfo = json['fleetInfo'] != null
        ? new FleetInfo.fromJson(json['fleetInfo'])
        : null;
    intColor = json['intColor'] != null
        ? new IntColor.fromJson(json['intColor'])
        : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    certificationStatus = json['certificationStatus'];
    promoted = json['promoted'];
    createdAt = json['createdAt'];
    incomplete = json['incomplete'];
    acquiredDate = json['acquiredDate'];
    createdBy = json['createdBy'];
    if (json['audit'] != null) {
      audit = <Audit>[];
      json['audit'].forEach((v) {
        audit!.add(new Audit.fromJson(v));
      });
    }
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    hardwareCode = json['hardwareCode'];
    extColor = json['extColor'] != null
        ? new ExtColor.fromJson(json['extColor'])
        : null;
    model = json['model'] != null ? new Model.fromJson(json['model']) : null;
    vin = json['vin'];
    brand = json['brand'];
    createUpdateTraceId = json['createUpdateTraceId'];
    mileage = json['mileage'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPromotable'] = this.isPromotable;
    data['acquiredMethod'] = this.acquiredMethod;
    data['updatedBy'] = this.updatedBy;
    data['inventoryStatus'] = this.inventoryStatus;
    data['dealerCd'] = this.dealerCd;
    if (this.fleetInfo != null) {
      data['fleetInfo'] = this.fleetInfo!.toJson();
    }
    if (this.intColor != null) {
      data['intColor'] = this.intColor!.toJson();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    data['certificationStatus'] = this.certificationStatus;
    data['promoted'] = this.promoted;
    data['createdAt'] = this.createdAt;
    data['incomplete'] = this.incomplete;
    data['acquiredDate'] = this.acquiredDate;
    data['createdBy'] = this.createdBy;
    if (this.audit != null) {
      data['audit'] = this.audit!.map((v) => v.toJson()).toList();
    }
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['hardwareCode'] = this.hardwareCode;
    if (this.extColor != null) {
      data['extColor'] = this.extColor!.toJson();
    }
    if (this.model != null) {
      data['model'] = this.model!.toJson();
    }
    data['vin'] = this.vin;
    data['brand'] = this.brand;
    data['createUpdateTraceId'] = this.createUpdateTraceId;
    data['mileage'] = this.mileage;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class FleetInfo {
  String? fuelLevel;
  String? fleetStatus;
  String? timeZoneOffset;
  String? health;
  List<Programs>? programs;
  String? currentLocation;

  FleetInfo(
      {this.fuelLevel,
        this.fleetStatus,
        this.timeZoneOffset,
        this.health,
        this.programs,
        this.currentLocation});

  FleetInfo.fromJson(Map<String, dynamic> json) {
    fuelLevel = json['fuelLevel'];
    fleetStatus = json['fleetStatus'];
    timeZoneOffset = json['timeZoneOffset'];
    health = json['health'];
    if (json['programs'] != null) {
      programs = <Programs>[];
      json['programs'].forEach((v) {
        programs!.add(new Programs.fromJson(v));
      });
    }
    currentLocation = json['currentLocation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuelLevel'] = this.fuelLevel;
    data['fleetStatus'] = this.fleetStatus;
    data['timeZoneOffset'] = this.timeZoneOffset;
    data['health'] = this.health;
    if (this.programs != null) {
      data['programs'] = this.programs!.map((v) => v.toJson()).toList();
    }
    data['currentLocation'] = this.currentLocation;
    return data;
  }
}

class Programs {
  String? programName;

  Programs({this.programName});

  Programs.fromJson(Map<String, dynamic> json) {
    programName = json['programName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['programName'] = this.programName;
    return data;
  }
}

class IntColor {
  String? colorSwatch;
  String? colorCd;
  String? marketingName;
  String? colorDesc;

  IntColor(
      {this.colorSwatch, this.colorCd, this.marketingName, this.colorDesc});

  IntColor.fromJson(Map<String, dynamic> json) {
    colorSwatch = json['colorSwatch'];
    colorCd = json['colorCd'];
    marketingName = json['marketingName'];
    colorDesc = json['colorDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['colorSwatch'] = this.colorSwatch;
    data['colorCd'] = this.colorCd;
    data['marketingName'] = this.marketingName;
    data['colorDesc'] = this.colorDesc;
    return data;
  }
}

class Media {
  String? href;
  String? type;
  String? fileName;
  String? size;

  Media({this.href, this.type, this.fileName, this.size});

  Media.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    type = json['type'];
    fileName = json['fileName'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['type'] = this.type;
    data['fileName'] = this.fileName;
    data['size'] = this.size;
    return data;
  }
}

class Audit {
  String? traceId;
  String? transactionSource;
  int? seqNo;
  String? eventSource;
  String? timestamp;

  Audit(
      {this.traceId,
        this.transactionSource,
        this.seqNo,
        this.eventSource,
        this.timestamp});

  Audit.fromJson(Map<String, dynamic> json) {
    traceId = json['traceId'];
    transactionSource = json['transactionSource'];
    seqNo = json['seqNo'];
    eventSource = json['eventSource'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['traceId'] = this.traceId;
    data['transactionSource'] = this.transactionSource;
    data['seqNo'] = this.seqNo;
    data['eventSource'] = this.eventSource;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class Price {
  int? sellingPrice;
  int? advertisedPrice;
  int? baseMsrp;
  String? acvPrice;
  String? retailAmount;
  int? totalMsrp;

  Price(
      {this.sellingPrice,
        this.advertisedPrice,
        this.baseMsrp,
        this.acvPrice,
        this.retailAmount,
        this.totalMsrp});

  Price.fromJson(Map<String, dynamic> json) {
    sellingPrice = json['sellingPrice'];
    advertisedPrice = json['advertisedPrice'];
    baseMsrp = json['baseMsrp'];
    acvPrice = json['acvPrice'];
    retailAmount = json['retailAmount'];
    totalMsrp = json['totalMsrp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sellingPrice'] = this.sellingPrice;
    data['advertisedPrice'] = this.advertisedPrice;
    data['baseMsrp'] = this.baseMsrp;
    data['acvPrice'] = this.acvPrice;
    data['retailAmount'] = this.retailAmount;
    data['totalMsrp'] = this.totalMsrp;
    return data;
  }
}

class ExtColor {
  String? hexCode;
  String? colorCd;
  String? marketingName;
  String? colorDesc;

  ExtColor({this.hexCode, this.colorCd, this.marketingName, this.colorDesc});

  ExtColor.fromJson(Map<String, dynamic> json) {
    hexCode = json['hexCode'];
    colorCd = json['colorCd'];
    marketingName = json['marketingName'];
    colorDesc = json['colorDesc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hexCode'] = this.hexCode;
    data['colorCd'] = this.colorCd;
    data['marketingName'] = this.marketingName;
    data['colorDesc'] = this.colorDesc;
    return data;
  }
}

class Model {
  String? modelDescription;
  String? modelName;
  String? modelNumber;
  String? modelYear;

  Model(
      {this.modelDescription,
        this.modelName,
        this.modelNumber,
        this.modelYear});

  Model.fromJson(Map<String, dynamic> json) {
    modelDescription = json['modelDescription'];
    modelName = json['modelName'];
    modelNumber = json['modelNumber'];
    modelYear = json['modelYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['modelDescription'] = this.modelDescription;
    data['modelName'] = this.modelName;
    data['modelNumber'] = this.modelNumber;
    data['modelYear'] = this.modelYear;
    return data;
  }
}

class Pagination {
  int? pageNo;
  int? pageSize;
  int? totalPages;
  int? totalRecords;

  Pagination({this.pageNo, this.pageSize, this.totalPages, this.totalRecords});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNo = json['pageNo'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalRecords = json['totalRecords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageNo'] = this.pageNo;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    data['totalRecords'] = this.totalRecords;
    return data;
  }
}
