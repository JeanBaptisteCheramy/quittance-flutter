class TenantModel {
  final int? id;
  final String lastName;
  final String firstName;
  final String address;

  TenantModel({
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

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      id: map['id'],
      firstName: map['firstname'],
      lastName: map['lastname'],
      address: map['address'],
    );
  }
}
