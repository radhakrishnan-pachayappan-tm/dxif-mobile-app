class APIUrls {
  String? baseUrl;
  String? getDealerInfo;
  String? getProgramInfo;
  String? getInventoryModels;
  String? getStationInfo;
  String? post_create_reservation;
  String? apiFleetProgram;
  String? apiFleetInventory;
  String? apiStationInfo;

  APIUrls(
      {this.baseUrl,
        this.getDealerInfo,
        this.getProgramInfo,
        this.getInventoryModels,
        this.getStationInfo,
        this.post_create_reservation,
        this.apiFleetProgram,
        this.apiFleetInventory,
        this.apiStationInfo});

  APIUrls.fromJson(Map<String, dynamic> json) {
    baseUrl = json['base_url'];
    getDealerInfo = json['get_dealer_info'];
    getProgramInfo = json['get_program_info'];
    getInventoryModels = json['get_inventory_models'];
    getStationInfo = json['get_station_info'];
    apiFleetProgram = json['api_fleet_program'];
    apiFleetInventory = json['api_fleet_inventory'];
    apiStationInfo = json['api_station_info'];
    post_create_reservation = json['post_create_reservation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['base_url'] = this.baseUrl;
    data['get_dealer_info'] = this.getDealerInfo;
    data['get_program_info'] = this.getProgramInfo;
    data['get_inventory_models'] = this.getInventoryModels;
    data['get_station_info'] = this.getStationInfo;
    data['api_fleet_program'] = this.apiFleetProgram;
    data['api_fleet_inventory'] = this.apiFleetInventory;
    data['api_station_info'] = this.apiStationInfo;
    data['post_create_reservation'] = this.post_create_reservation;
    return data;
  }
}
