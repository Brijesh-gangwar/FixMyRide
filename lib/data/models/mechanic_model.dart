import 'dart:convert';

class MechanicModel {
  final int id;
  final String name;
  final String gender;
  final String aadharCard;
  final String aadharImage;
  final String aadharImageUrl;
  final String serviceType;
  final int experience;
  final double? averageRating;
  final bool available;
  final String email;
  final String phoneNumber;
  final String address;
  final int user;

  MechanicModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.aadharCard,
    required this.aadharImage,
    required this.aadharImageUrl,
    required this.serviceType,
    required this.experience,
    this.averageRating,
    required this.available,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.user,
  });

  // Convert JSON to Model
  factory MechanicModel.fromJson(Map<String, dynamic> json) {
    return MechanicModel(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      aadharCard: json['aadhar_card'],
      aadharImage: json['aadhar_image'],
      aadharImageUrl: json['aadhar_image_url'],
      serviceType: json['service_type'],
      experience: json['experience'],
      averageRating: json['average_rating'] != null
          ? json['average_rating'].toDouble()
          : null,
      available: json['available'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
      user: json['user'],
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'aadhar_card': aadharCard,
      'aadhar_image': aadharImage,
      'aadhar_image_url': aadharImageUrl,
      'service_type': serviceType,
      'experience': experience,
      'average_rating': averageRating,
      'available': available,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'user': user,
    };
  }


  static MechanicModel fromJsonString(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return MechanicModel.fromJson(data);
  }

  // Convert Model to JSON String
  String toJsonString() {
    return jsonEncode(toJson());
  }
}
