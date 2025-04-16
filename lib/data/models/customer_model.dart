class CustomerModel {
  final int id;
  final String name;
  final String gender;
  final String aadharCard;
  final String? aadharImage;
  final String? aadharImageUrl;
  final String? drivingLicense;
  final String email;
  final String? address;
  final String? preferredMechanic;
  final bool verified;
  final String phoneNumber;
  final String? secondaryPhoneNumber;
  final double? latitude;
  final double? longitude;
  final int user;

  CustomerModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.aadharCard,
    this.aadharImage,
    this.aadharImageUrl,
    this.drivingLicense,
    required this.email,
    this.address,
    this.preferredMechanic,
    required this.verified,
    required this.phoneNumber,
    this.secondaryPhoneNumber,
    this.latitude,
    this.longitude,
    required this.user,
  });

  // Convert JSON to CustomerModel object
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json["id"],
      name: json["name"],
      gender: json["gender"],
      aadharCard: json["aadhar_card"],
      aadharImage: json["aadhar_image"],
      aadharImageUrl: json["aadhar_image_url"],
      drivingLicense: json["driving_license"],
      email: json["email"],
      address: json["address"],
      preferredMechanic: json["preferred_mechanic"],
      verified: json["verified"],
      phoneNumber: json["phone_number"],
      secondaryPhoneNumber: json["secondary_phone_number"],
      latitude: json["latitude"]?.toDouble(),
      longitude: json["longitude"]?.toDouble(),
      user: json["user"],
    );
  }

  // Convert CustomerModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "gender": gender,
      "aadhar_card": aadharCard,
      "aadhar_image": aadharImage,
      "aadhar_image_url": aadharImageUrl,
      "driving_license": drivingLicense,
      "email": email,
      "address": address,
      "preferred_mechanic": preferredMechanic,
      "verified": verified,
      "phone_number": phoneNumber,
      "secondary_phone_number": secondaryPhoneNumber,
      "latitude": latitude,
      "longitude": longitude,
      "user": user,
    };
  }
}
