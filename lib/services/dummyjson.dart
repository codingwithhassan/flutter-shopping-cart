import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:products/models/product.dart';

class DummyJson {
  static const String BASE_URL = "dummyjson.com";

  static Future getProduct(int id) async {
    var url = Uri.https(BASE_URL, '/products/$id');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<String> images = [];
      for (String image in jsonResponse["images"]) {
        images.add(image);
      }

      return Future(() => ProductData(
            jsonResponse["id"],
            images,
            jsonResponse["stock"],
            jsonResponse["title"],
            jsonResponse["description"],
            jsonResponse["price"],
            jsonResponse["discountPercentage"],
            jsonResponse["rating"],
            jsonResponse["brand"],
            jsonResponse["category"],
            jsonResponse["thumbnail"],
          ));
    }
  }
}
