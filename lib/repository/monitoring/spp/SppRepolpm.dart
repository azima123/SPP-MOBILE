import 'package:spp/models/monitoring/SppModel.dart';
import 'package:spp/repository/monitoring/spp/SppRepo.dart';

import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';

class SppRepolpm implements SppRepo {
  get http => null;
  BaseApiService _apiService = NetworkApiService();

  @override
  Future<SppModel?> getlistpay(id) async {
    try {
      Map<String, String> data = {"id": id};
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().getinfospp, data);
      //print("$response");
      final jsonData = SppModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }
}
