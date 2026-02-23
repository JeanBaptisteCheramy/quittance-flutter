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
    final map = <String, dynamic>{
      'firstname': firstName,
      'lastname': lastName,
      'address': address,
    };

    if (id != null) {
      map['id'] = id as dynamic;
    }

    return map;
  }

  factory TenantModel.fromMap(Map<String, dynamic> map) {
    return TenantModel(
      id: map['id'] as int?,
      firstName: map['firstname'] as String,
      lastName: map['lastname'] as String,
      address: map['address'] as String,
    );
  }
}