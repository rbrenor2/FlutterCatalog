import 'dart:async';

class Category {
  final String name;
  final List products;
  final String image;

  const Category({this.name, this.products, this.image});
}

class Product {
  final String name;
  final double price;
  final String description;
  final String image;

  const Product({this.name, this.price, this.description, this.image});

  String getPrice(){
    return "R\$ " + price.toString();
  }

}