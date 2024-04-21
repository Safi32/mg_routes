import 'dart:convert';

enum MediaTypeEnum { PACKAGE_IMAGE, SIGNATURE }

class MediaRequestDTO {
  String orderTrackingNumber;
  String packageTrackingNumber;
  MediaTypeEnum mediaTypeEnum;
  String imageUrl;

  MediaRequestDTO({
    required this.orderTrackingNumber,
    required this.packageTrackingNumber,
    required this.mediaTypeEnum,
    required this.imageUrl,
  });

  factory MediaRequestDTO.fromRawJson(String str) =>
      MediaRequestDTO.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MediaRequestDTO.fromJson(Map<String, dynamic> json) =>
      MediaRequestDTO(
        orderTrackingNumber: json["orderTrackingNumber"],
        packageTrackingNumber: json["packageTrackingNumber"],
        mediaTypeEnum: json["mediaTypeEnum"] == "PACKAGE_IMAGE"
            ? MediaTypeEnum.PACKAGE_IMAGE
            : MediaTypeEnum.SIGNATURE,
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "orderTrackingNumber": orderTrackingNumber,
        "packageTrackingNumber": packageTrackingNumber,
        "mediaTypeEnum": mediaTypeEnum == MediaTypeEnum.PACKAGE_IMAGE
            ? "PACKAGE_IMAGE"
            : "SIGNATURE",
        "imageUrl": imageUrl,
      };
}
