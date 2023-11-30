class BookingModel {
  final String id;
  final String vendorId;
  final String userName;
  final String ticketId;
  final int memberCount;
  final String checkinDate;
  final String checkoutDate;
  final double priceAmount;
  final bool isPaid;
  final String subvendorId;
  final String userId;
  final String propertyId;
  final String PropertyName;
  final String gender;
  final String status;
  final String location;
  final double discount;
  final String paymentMode;
  final String propertyImages;
  final String bookingStatus;

  BookingModel({
    required this.id,
    required this.vendorId,
    required this.userName,
    required this.ticketId,
    required this.memberCount,
    required this.checkinDate,
    required this.checkoutDate,
    required this.priceAmount,
    required this.isPaid,
    required this.subvendorId,
    required this.PropertyName,
    required this.userId,
    required this.propertyId,
    required this.gender,
    required this.status,
    required this.location,
    required this.discount,
    required this.paymentMode,
    required this.propertyImages,
    required this.bookingStatus,
  });

  factory BookingModel.fromMap(String id, Map<String, dynamic> map) {
    return BookingModel(
      id: id,
      vendorId: map['vendor_id'],
      userName: map['UserName'],
      ticketId: map['ticket_id'],
      memberCount: map['memberCount'],
      checkinDate: map['checkinDate'],
      checkoutDate: map['checkoutDate'],
      priceAmount: map['priceAmount'],
      isPaid: map['isPaid'],
      subvendorId: map['subvendor_id'],
      userId: map['user_id'],
      propertyId: map['property_id'],
      PropertyName:map['PropertyName'],
      gender:map['gender'],
      status: map['status'],
      location: map['location'],
      discount: map['discount'],
      paymentMode: map['paymentMode'],
      propertyImages: map['propertyImages'],
      bookingStatus: map['bookingStatus'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vendor_id': vendorId,
      'UserName': userName,
      'ticket_id': ticketId,
      'memberCount': memberCount,
      'checkinDate': checkinDate,
      'checkoutDate': checkoutDate,
      'priceAmount': priceAmount,
      'isPaid': isPaid,
      'subvendor_id': subvendorId,
      'user_id': userId,
      'property_id': propertyId,
      'PropertyName':PropertyName,
      'gender':gender,
      'status': status,
      'location': location,
      'discount': discount,
      'paymentMode': paymentMode,
      'propertyImages': propertyImages,
      'bookingStatus': bookingStatus,
    };
  }
}

