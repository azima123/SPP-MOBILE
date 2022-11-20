import 'package:flutter/cupertino.dart';
import '../../data/remote/response/ApiResponse.dart';
import '../../models/monitoring/KesehatanModel.dart';
import '../../repository/monitoring/health/KesehatanRepolpm.dart';

class HealthVM extends ChangeNotifier {
  final _myRepo = KesehatanRepolpm();

  ApiResponse<KesehatanModel> health = ApiResponse.loading();

  void _setMain(ApiResponse<KesehatanModel> response) {
    print("$response");
    health = response;
    notifyListeners();
  }

  //getlistpay
  Future<void> getlisthealth(
      String idkelas, String idsekolah, String nis) async {
    _myRepo
        .getlisthealth(idkelas, idsekolah, nis)
        .then((value) => _setMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMain(ApiResponse.error(error.toString())));
  }
}
