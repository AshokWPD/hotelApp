class PropertyModel {
  final String id; // Unique ID for each property
  final String propertyName;
  final String propertyType;
  final List<String> roomType;
  final String streetAddress;
  final String vendorId;
  final String landmark;
  final String pincode;
  final String description;
  final String price;
  final String status;
  final String isbookedBy;
  final String bookStatus;
  final String statusVendor;
  final String gender;
  final List<String> features;
  final List<String> roomImages;
  final List<String> propertyImages;
  final double latitude;
  final double longitude;

  PropertyModel({
    required this.id,
    required this.propertyName,
    required this.propertyType,
    required this.roomType,
    required this.streetAddress,
    required this.vendorId,
    required this.landmark,
    required this.pincode,
    required this.description,
    required this.price,
    required this.status,
    required this.isbookedBy,
    required this.bookStatus,
    required this.statusVendor,
    required this.gender,
    required this.features,
    required this.roomImages,
    required this.propertyImages,
    required this.latitude,
    required this.longitude,
  });

  // Create a PropertyModel instance from a Map
  factory PropertyModel.fromMap(String id, Map<String, dynamic> map) {
    return PropertyModel(
      id: id,
      propertyName: map['propertyName'],
      propertyType: map['propertyType'],
      roomType: List<String>.from(map['roomType']),
      streetAddress: map['streetAddress'],
      vendorId: map['vendorId'],
      landmark: map['landmark'],
      pincode: map['pincode'],
      description: map['description'],
      price: map['price'],
      status: map['status'],
      isbookedBy: map['isbookedBy'],
      bookStatus: map['bookStatus'],
      statusVendor: map['statusVendor'],
      gender: map['gender'],
      features: List<String>.from(map['features']),
      roomImages: List<String>.from(map['roomImages']),
      propertyImages: List<String>.from(map['propertyImages']),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  // Convert a PropertyModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'propertyName': propertyName,
      'propertyType': propertyType,
      'roomType': roomType,
      'streetAddress': streetAddress,
      'vendorId': vendorId,
      'landmark': landmark,
      'pincode': pincode,
      'description': description,
      'price': price,
      'status': status,
      'isbookedBy': isbookedBy,
      'bookStatus': bookStatus,
      'statusVendor': statusVendor,
      'gender': gender,
      'features': features,
      'roomImages': roomImages,
      'propertyImages': propertyImages,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
// class PropertyModel {
//   final String id; // Added a unique ID for each property
//   final String propertyName;
//   final String propertyType;
//   final List<String> roomType;
//   final String streetAddress;
//   final String vendorId;
//   final String landmark;
//   final String pincode;
//   final String description;
//   final String price;
//   final String status;
//   final String isbookedBy;
//   final String bookStatus;
//   final String statusVendor;
//   final String gender;
//   final List<String> features;
//   late final List<String> roomImages;
//   final List<String> propertyImages;
//   final double latitude;
//   final double longitude;

//   PropertyModel({
//     required this.id,
//     required this.propertyName,
//     required this.propertyType,
//     required this.roomType,
//     required this.streetAddress,
//     required this.vendorId,
//     required this.landmark,
//     required this.pincode,
//     required this.description,
//     required this.price,
//     required this.status,
//     required this.isbookedBy,
//     required this.bookStatus,
//     required this.statusVendor,
//     required this.gender,
//     required this.features,
//     required this.roomImages,
//     required this.propertyImages,
//     required this.latitude,
//     required this.longitude,
//   });

//   factory PropertyModel.fromMap(Map<String, dynamic> map, String id) {
//     return PropertyModel(
//       id: id,
//       propertyName: map['property_name'] as String,
//       propertyType: map['property_type'] as String,
//       roomType: List<String>.from(map['roomType']),
//       streetAddress: map['street_address'] as String,
//       vendorId: map['vendor_id'] as String,
//       landmark: map['landmark'] as String,
//       pincode: map['pincode'] as String,
//       description: map['description'] as String,
//       price: map['price'] as String,
//       status: map['status'] as String,
//       isbookedBy: map['isbookedBy'] as String,
//       bookStatus: map['bookStatus'] as String,
//       statusVendor: map['status_vendor'] as String,
//       gender: map['gender'] as String,
//       features: List<String>.from(map['features']),
//       roomImages: List<String>.from(map['room_images']),
//       propertyImages: List<String>.from(map['property_images']),
//       latitude: (map['latitude'] as num).toDouble(),
//       longitude: (map['longitude'] as num).toDouble(),
//     );
//   }

  
//   Map<String, dynamic> toMap() {
//     return {
//       'propertyName': propertyName,
//       'propertyType': propertyType,
//       'roomType': roomType,
//       'streetAddress': streetAddress,
//       'vendorId': vendorId,
//       'landmark': landmark,
//       'pincode': pincode,
//       'description': description,
//       'price': price,
//       'status': status,
//       'isbookedBy': isbookedBy,
//       'bookStatus': bookStatus,
//       'statusVendor': statusVendor,
//       'gender': gender,
//       'features': features,
//       'roomImages': roomImages,
//       'propertyImages': propertyImages,
//       'latitude': latitude,
//       'longitude': longitude,
//     };
//   }
// }
