
import 'package:flutter_app/model/common_model.dart';

class SalesBoxModel{
  final String icon;
  final String moreUrl;
  final CommonModel bigCart1;
  final CommonModel bigCart2;
  final CommonModel smallCart1;
  final CommonModel smallCart2;
  final CommonModel smallCart3;
  final CommonModel smallCart4;

  SalesBoxModel({this.icon, this.moreUrl, this.bigCart1, this.bigCart2, this.smallCart1, this.smallCart2, this.smallCart3, this.smallCart4});

  factory SalesBoxModel.fromJson(Map<String,dynamic> json){
    return SalesBoxModel(
      icon: json['icon'],
        moreUrl: json['moreUrl'],
        bigCart1: CommonModel.fromJson(json['bigCard1']),
        bigCart2: CommonModel.fromJson(json['bigCard2']),
        smallCart1: CommonModel.fromJson(json['smallCard1']),
        smallCart2: CommonModel.fromJson(json['smallCard2']),
        smallCart3: CommonModel.fromJson(json['smallCard3']),
        smallCart4: CommonModel.fromJson(json['smallCard4']),
    );
  }
}