import 'package:flutter/cupertino.dart';
import '../../data/remote/response/ApiResponse.dart';
import '../../models/monitoring/HafalanModel.dart';
import '../../repository/monitoring/hafalan/HafalanRepolpm.dart';

class HafalanVM extends ChangeNotifier {
  final _myRepo = HafalanRepolpm();

  ApiResponse<HafalanModel> hafalan = ApiResponse.loading();

  void _setMain(ApiResponse<HafalanModel> response) {
    print("$response");
    hafalan = response;
    notifyListeners();
  }

  //getlistpay
  Future<void> getlisthafalan(
      String idkelas, String idsekolah, String nis) async {
    _myRepo
        .getlisthafalan(idkelas, idsekolah, nis)
        .then((value) => _setMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMain(ApiResponse.error(error.toString())));
  }
}
