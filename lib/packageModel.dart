import 'dart:convert';

class PackageDataList {
  bool success;
  String result;
  List<Package> data;

  PackageDataList({
    required this.success,
    required this.result,
    required this.data,
  });

  factory PackageDataList.fromRawJson(String str) =>
      PackageDataList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageDataList.fromJson(Map<String, dynamic> json) =>
      PackageDataList(
        success: json["success"],
        result: json["result"],
        data: json["data"] != null
            ? List<Package>.from(json["data"].map((x) => Package.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "result": result,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Package {
  String orderTrackingNumber;
  String packageTrackingNumber;
  String pickupAddress;
  String deliveryAddress;

  Package({
    required this.orderTrackingNumber,
    required this.packageTrackingNumber,
    required this.pickupAddress,
    required this.deliveryAddress,
  });

  factory Package.fromRawJson(String str) => Package.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        orderTrackingNumber: json["orderTrackingNumber"],
        packageTrackingNumber: json["packageTrackingNumber"],
        pickupAddress: json["pickupAddress"],
        deliveryAddress: json["deliveryAddress"],
      );

  Map<String, dynamic> toJson() => {
        "orderTrackingNumber": orderTrackingNumber,
        "packageTrackingNumber": packageTrackingNumber,
        "pickupAddress": pickupAddress,
        "deliveryAddress": deliveryAddress,
      };
}
