import 'package:spp/models/login/LoginModel.dart';
import 'package:spp/repository/login/LoginRepo.dart';

import '../../data/remote/network/ApiEndPoints.dart';
import '../../data/remote/network/BaseApiService.dart';
import '../../data/remote/network/NetworkApiService.dart';

class LoginRepolpm implements LoginRepo {
  get http => null;
  BaseApiService _apiService = NetworkApiService();

  @override
  Future<LoginModel?> LoginPost(email, password) async {
    try {
      Map<String, String> data = {"email": email, "password": password};
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().Loginpost, data);
      //print("$response");
      final jsonData = LoginModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }

  @override
  Future<LoginModel?> Logout() {
    // TODO: implement Logout
    throw UnimplementedError();
  }

  @override
  Future<LoginModel?> DetailAccount(id) async {
    try {
      Map<String, String> data = {"id": id};
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().getaccount, data);
      //print("$response");
      final jsonData = LoginModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
    throw UnimplementedError();
  }


}
