import 'package:quittance_app/models/renter_model.dart';

import '../repository/renter_repository.dart';

class RenterService {
  final RenterRepository _repository = RenterRepository();

  /// Méthode save pour le renter
  /// Pas de return
  /// Permet de créer / mettre à jour les informations du locataire
  Future<void> save(RenterModel renter) async {
    await _repository.save(renter);
  }

  Future<List<RenterModel?>> getAll() async{
    return await _repository.getAll();
  }

}
