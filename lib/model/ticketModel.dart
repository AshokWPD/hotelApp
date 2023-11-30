class TicketModel {
  final String ticketId;
  final String propertyId;
  final String userName;
  final String userId;
  final String message;
  final String description;
  final String status;
  final String vendorId;
  final String replyMessage;
  final bool isAdmin;

  TicketModel({
    required this.ticketId,
    required this.propertyId,
    required this.userName,
    required this.userId,
    required this.message,
    required this.description,
    required this.status,
    required this.vendorId,
    required this.replyMessage,
    required this.isAdmin,
  });

  factory TicketModel.fromMap(String ticketId, Map<String, dynamic> map) {
    return TicketModel(
      ticketId: ticketId,
      propertyId: map['property_id'] as String,
      userName: map['user_name'] as String,
      userId: map['user_id'] as String,
      message: map['message'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      vendorId:map['vendorId'] as String,
      replyMessage: map['reply_message'] as String,
      isAdmin: map['isAdmin'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'property_id': propertyId,
      'user_name': userName,
      'user_id': userId,
      'message': message,
      'description': description,
      'status': status,
      'reply_message': replyMessage,
      'isAdmin': isAdmin,
      'vendorId':vendorId
    };
  }
}
