class OwnerModel {
  final int? id;
  final String lastName;
  final String firstName;
  final String address;

  OwnerModel({
    this.id,
    required this.lastName,
    required this.firstName,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'address': address,
    };
  }

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      id: map['id'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      address: map['address'],
    );
  }
}
