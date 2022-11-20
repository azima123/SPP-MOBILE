import 'package:spp/models/monitoring/HafalanModel.dart';

import '../../../data/remote/network/ApiEndPoints.dart';
import '../../../data/remote/network/BaseApiService.dart';
import '../../../data/remote/network/NetworkApiService.dart';
import 'HafalanRepo.dart';

class HafalanRepolpm implements HafalanRepo {
  get http => null;
  BaseApiService _apiService = NetworkApiService();

  @override
  Future<HafalanModel?> getlisthafalan(
      String kelas, String sekolah, String nis) async {
    try {
      Map<String, String> data = {
        "idkelas": kelas,
        "idsekolah": sekolah,
        "nis": nis
      };
      dynamic response =
          await _apiService.postResponse(ApiEndPoints().gethafalan, data);
      //print("$response");
      final jsonData = HafalanModel.fromJson(response);
      return jsonData;
    } catch (e) {
      throw e;
      print("MARAJ-E $e}");
    }
  }
}
