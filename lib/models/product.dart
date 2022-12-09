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