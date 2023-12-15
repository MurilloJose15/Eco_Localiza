import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String id;
  String company_name;
  List<String> trash_type;
  String address;
  double Lat;
  double Lng;
  final String? userId;

  Company({
    required this.id,
    required this.company_name,
    required this.trash_type,
    required this.address,
    required this.Lat,
    required this.Lng,
    required this.userId,
  });

  factory Company.saveFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Company(
        id: doc.id,
        company_name: data['company_name'],
        trash_type: List<String>.from(data['trash_type'] ?? []),
        address: data['address'],
        Lat: data['Lat'],
        Lng: data['Lng'],
        userId: data['userId'],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'company_name': company_name,
      'trash_type': trash_type,
      'address': address,
      'Lat': Lat,
      'Lng': Lng,
      'userId': userId,
    };
  }

  Company copyWith({
    String? userId,
  }) {
    return Company(
        id: id,
        company_name: company_name,
        trash_type: trash_type,
        address: address,
        Lat: Lat,
        Lng: Lng,
        userId: userId ?? this.userId,
    );
  }
}