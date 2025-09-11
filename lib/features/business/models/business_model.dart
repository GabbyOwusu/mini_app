class Business {
  final String businessName;
  final String businessLocation;
  final String contactNumber;

  const Business({
    required this.businessName,
    required this.businessLocation,
    required this.contactNumber,
  });

  factory Business.fromJson(Map<String, dynamic> json) {
    return Business(
      businessName: json['biz_name'] ?? '',
      businessLocation: json['bss_location'] ?? '',
      contactNumber: json['contct_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biz_name': businessName,
      'bss_location': businessLocation,
      'contct_no': contactNumber,
    };
  }
}
