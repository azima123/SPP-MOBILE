abstract class BaseApiService {
  final String baseUrl = "https://spp.kanalapps.web.id/api/";
  //Untuk GET
  Future<dynamic> getResponse(String url);

  //untuk POST

  Future<dynamic> postResponse(String url, data);
}
