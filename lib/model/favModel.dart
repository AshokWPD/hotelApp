import 'propertyModel.dart';

class FavoriteModel {
  final String id; // Unique ID for each favorite
  final String userId;
  final String propertyId;
  final String roomId;
  final String otherDetails;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.propertyId,
    required this.roomId,
    required this.otherDetails,
  });

  // Create a FavoriteModel instance from a Map
  factory FavoriteModel.fromMap(String id, Map<String, dynamic> map) {
    return FavoriteModel(
      id: id,
      userId: map['user_id'] ?? '',
      propertyId: map['property_id'] ?? '',
      roomId: map['room_id'] ?? '',
      otherDetails: map['other_details'] ?? '',
    );
  }

  // Convert a FavoriteModel instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'property_id': propertyId,
      'room_id': roomId,
      'other_details': otherDetails,
    };
  }
}


class FavoritePropertyModel {
  final FavoriteModel favorite;
  final PropertyModel property;

  FavoritePropertyModel({
    required this.favorite,
    required this.property,
  });

  factory FavoritePropertyModel.fromMap(String id, Map<String, dynamic> map, PropertyModel property) {
    return FavoritePropertyModel(
      favorite: FavoriteModel.fromMap(id, map),
      property: property,
    );
  }
}
