
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {

    String id;
    String title;
    double value;
    bool available;
    String photoUrl;

    ProductModel({
        this.id,
        this.title = '',
        this.value = 0.0,
        this.available = true,
        this.photoUrl,
    });


    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        title: json["title"],
        value: json["value"],
        available: json["available"],
        photoUrl: json["photoURL"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "value": value,
        "available": available,
        "photoURL": photoUrl,
    };
}
