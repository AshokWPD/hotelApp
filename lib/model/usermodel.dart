class UserModel {
  final String name;
  final String email;
  final String mobile;
  final String type;
  final String address;
  final double latitude;
  final double longitude;
  final String city;
  final bool isAllowed; // Added "isAllowed" field
  final String pincode;
  final String vendorId;

  UserModel( {
    required this.name,
    required this.email,
    required this.mobile,
    required this.type,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.isAllowed,
    required this.pincode,
    required this.vendorId
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'mobile': mobile,
      'type': type,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'city': city,
      'isAllowed': isAllowed, // Include "isAllowed" in the map
      'pincode': pincode,
      'vendorId':vendorId,
      
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'],
      email: data['email'],
      mobile: data['mobile'],
      type: data['type'],
      address: data['address'],
      latitude: data['latitude'],
      longitude: data['longitude'],
      city: data['city'],
      isAllowed: data['isAllowed'],
      pincode: data['pincode'],
      vendorId:data['vendorId']
    );
  }
}
