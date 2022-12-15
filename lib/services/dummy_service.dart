import 'package:get/get.dart';

class DummyService extends GetConnect implements GetxService {
  final String serviceBaseUrl;

  DummyService({required this.serviceBaseUrl});

  @override
  void onInit() {
    httpClient.baseUrl = serviceBaseUrl;
    httpClient.addRequestModifier<Object?>((request) {
      request.headers['Content-Type'] = 'application/json; charset=UTF-8';
      return request;
    });
    httpClient.timeout = const Duration(seconds: 15);
  }

  Future<Response> getData(String uri) async {
    try {
      Response response = await get(uri);
      return response;
    } catch (e) {
      return Response(statusCode: 500, statusText: e.toString());
    }
  }
}
