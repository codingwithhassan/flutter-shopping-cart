import 'package:flutter/material.dart';
import 'package:products/screens/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:products/Widgets/product_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {

  List<Map<String, dynamic>> _data = [];
  ScrollController scrollController = ScrollController();

  void getData() async {
    print("init api call");
    var url = Uri.https('dummyjson.com', '/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
      convert.jsonDecode(response.body) as Map<String, dynamic>;
      for (Map product in jsonResponse['products']) {
        Map<String, dynamic> data = {
          "id": product["id"],
          "thumbnail": product["thumbnail"],
          "title": product["title"],
          "description": product["description"],
          "price": product["price"],
          "category": product["category"],
        };
        setState(() {
          _data.add(data);
        });
      }
    }
  }

  void _openProduct(context, dynamic id) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Product(id: id)));
  }

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(_onScrollListView);
  }

  void _onScrollListView(){
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: ListView.builder(
        controller: scrollController,
        itemCount: _data.length,
        itemBuilder: (context, index) {

          double itemOffset = index * 90;
          double totalOffset = scrollController.offset;

          double animationValue = 1;
          double opacity = 1;
          if(itemOffset < totalOffset){
            double difference = (totalOffset - itemOffset) / 100;
            animationValue = difference;
            opacity = animationValue.abs();
            if(opacity > 1){
              opacity = 1;
            }else if(opacity < 0){
              opacity = 0;
            }
            animationValue = (1 - animationValue).abs();
          }

          return Opacity(
            opacity: opacity,
            child: Transform.scale(
              alignment: Alignment.center,
              scale: animationValue,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: InkWell(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ProductItem(
                      thumbnail: CachedNetworkImage(
                        imageUrl: _data[index]["thumbnail"],
                        placeholder: (context, url) => Image.asset(
                          'assets/images/default.png',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                      title: _data[index]["title"],
                      category: _data[index]["category"],
                      price: _data[index]["price"],
                    ),
                  ),
                  onTap: () {
                    _openProduct(context, _data[index]["id"]);
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
