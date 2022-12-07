import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<ProductDetail> createState() => _ProductDetailState(this.id);
}

class ProductData {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int stock = 0;
  String? brand;
  String? category;
  String? thumbnail;
  List<String> images = [];

  ProductData(this.id, this.images, this.stock,
      [this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.brand,
      this.category,
      this.thumbnail]);
}

class _ProductDetailState extends State<ProductDetail> {
  final int id;

  _ProductDetailState(this.id);

  final PageController controller = PageController();

  ProductData productData = ProductData(0, [], 0);

  void getData() async {
    print("init api call");
    var url = Uri.https('dummyjson.com', '/products/' + this.id.toString());
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      setState(() {
        List<String> images = [];
        for(String image in jsonResponse["images"]){
          images.add(image);
        }
        productData = ProductData(
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
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print(this.id);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Detail Screen"),
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight / 2.0,
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: PageView.builder(
              controller: controller,
              itemCount: productData.images.length,
              itemBuilder: (BuildContext context, int index) {
                return Image.network(productData.images[index]);
              },
            ),
          ),
          Text("Price: \$" + productData.price.toString()),
        ],
      ),
    );
  }
}
