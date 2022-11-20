import 'package:spp/models/monitoring/KesehatanModel.dart';

import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';
import 'KesehatanRepo.dart';

class KesehatanRepolpm implements KesehatanRepo {
  get http => null;
  BaseApiService _apiService = NetworkApiService();

  @override
  Future<KesehatanModel?> getlisthealth(
      String kelas, String sekolah, String nis) async {
    try {
      Map<String, String> data = {
        "idkelas": kelas,
        "idsekolah": sekolah,
        "nis": nis
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().gethealth, data);
      //print("$response");
      final jsonData = KesehatanModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }
}
