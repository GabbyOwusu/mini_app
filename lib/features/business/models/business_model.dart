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
      businessName: json['businessName'],
      businessLocation: json['businessLocation'],
      contactNumber: json['contactNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'businessName': businessName,
      'businessLocation': businessLocation,
      'contactNumber': contactNumber,
    };
  }
}
