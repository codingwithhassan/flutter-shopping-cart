import 'package:get/get.dart';

class DummyService extends GetConnect implements GetxService {
  late String token;
  final String serviceBaseUrl;
  late Map<String, String> _mainHeaders;

  DummyService({required this.serviceBaseUrl}){
   baseUrl = serviceBaseUrl;
   timeout = const Duration(seconds: 15);
   _mainHeaders = {
     'Content-Type': 'application/json; charset=UTF-8',
   };
  }

  Future<Response> getData(String uri) async {
    try{
      Response response = await get(uri);
      return response;
    }catch(e){
      return Response(statusCode: 500, statusText: e.toString());
    }
  }
}