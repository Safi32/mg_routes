class DeliveryResponse {
  final bool success;
  final String result;
  final DeliveryData data;

  DeliveryResponse({
    required this.success,
    required this.result,
    required this.data,
  });

  factory DeliveryResponse.fromJson(Map<String, dynamic> json) {
    return DeliveryResponse(
      success: json['success'],
      result: json['result'],
      data: DeliveryData.fromJson(json['data']),
    );
  }
}

class DeliveryData {
  final String trackingNumber;
  final String name;
  final String description;
  final String urgencyLevel;
  final List<DeliveryRouteDTO> deliveryRouteDTOS;
  final String packageStatus;
  final String departmentName;

  DeliveryData({
    required this.trackingNumber,
    required this.name,
    required this.description,
    required this.urgencyLevel,
    required this.deliveryRouteDTOS,
    required this.packageStatus,
    required this.departmentName,
  });

  factory DeliveryData.fromJson(Map<String, dynamic> json) {
    var deliveryRouteDTOSJson = json['deliveryRouteDTOS'] as List;
    List<DeliveryRouteDTO> deliveryRouteDTOS = deliveryRouteDTOSJson != null
        ? deliveryRouteDTOSJson
            .map((route) => DeliveryRouteDTO.fromJson(route))
            .toList()
        : [];

    return DeliveryData(
      trackingNumber: json['trackingNumber'],
      name: json['name'],
      description: json['description'],
      urgencyLevel: json['urgencyLevel'],
      deliveryRouteDTOS: deliveryRouteDTOS,
      packageStatus: json['packageStatus'],
      departmentName: json['departmentName'],
    );
  }
}

class DeliveryRouteDTO {
  final int id;
  final Location pickupLocation;
  final Location deliveryLocation;

  DeliveryRouteDTO({
    required this.id,
    required this.pickupLocation,
    required this.deliveryLocation,
  });

  factory DeliveryRouteDTO.fromJson(Map<String, dynamic> json) {
    return DeliveryRouteDTO(
      id: json['id'],
      pickupLocation: Location.fromJson(json['pickupLocation']),
      deliveryLocation: Location.fromJson(json['deliveryLocation']),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}
