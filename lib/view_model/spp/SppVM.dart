import 'package:flutter/cupertino.dart';
import '../../data/remote/response/ApiResponse.dart';
import '../../models/monitoring/SppModel.dart';
import '../../repository/monitoring/spp/SppRepolpm.dart';

class SppVM extends ChangeNotifier {
  final _myRepo = SppRepolpm();

  ApiResponse<SppModel> spp = ApiResponse.loading();

  void _setMain(ApiResponse<SppModel> response) {
    print("$response");
    spp = response;
    notifyListeners();
  }

  //getlistpay
  Future<void> getlistpay(String id) async {
    _myRepo
        .getlistpay(id)
        .then((value) => _setMain(ApiResponse.completed(value)))
        .onError((error, stackTrace) =>
            _setMain(ApiResponse.error(error.toString())));
  }
}
