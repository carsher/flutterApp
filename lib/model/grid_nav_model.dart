class GridNavModel {
  GridNavItem hotel;
  GridNavItem flight;
  GridNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  GridNavModel.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new GridNavItem.fromJson(json['hotel']) : null;
    flight =
    json['flight'] != null ? new GridNavItem.fromJson(json['flight']) : null;
    travel =
    json['travel'] != null ? new GridNavItem.fromJson(json['travel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
    if (this.flight != null) {
      data['flight'] = this.flight.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel.toJson();
    }
    return data;
  }
}

class GridNavItem {
  String startColor;
  String endColor;
  MainItem mainItem;
  Item item1;
  Item item2;
  Item item3;
  Item item4;

  GridNavItem(
      {this.startColor,
        this.endColor,
        this.mainItem,
        this.item1,
        this.item2,
        this.item3,
        this.item4});

  GridNavItem.fromJson(Map<String, dynamic> json) {
    startColor = json['startColor'];
    endColor = json['endColor'];
    mainItem = json['mainItem'] != null
        ? new MainItem.fromJson(json['mainItem'])
        : null;
    item1 = json['item1'] != null ? new Item.fromJson(json['item1']) : null;
    item2 = json['item2'] != null ? new Item.fromJson(json['item2']) : null;
    item3 = json['item3'] != null ? new Item.fromJson(json['item3']) : null;
    item4 = json['item4'] != null ? new Item.fromJson(json['item4']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startColor'] = this.startColor;
    data['endColor'] = this.endColor;
    if (this.mainItem != null) {
      data['mainItem'] = this.mainItem.toJson();
    }
    if (this.item1 != null) {
      data['item1'] = this.item1.toJson();
    }
    if (this.item2 != null) {
      data['item2'] = this.item2.toJson();
    }
    if (this.item3 != null) {
      data['item3'] = this.item3.toJson();
    }
    if (this.item4 != null) {
      data['item4'] = this.item4.toJson();
    }
    return data;
  }
}

class MainItem {
  String title;
  String icon;
  String url;
  String statusBarColor;

  MainItem({this.title, this.icon, this.url, this.statusBarColor});

  MainItem.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon = json['icon'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon'] = this.icon;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}

class Item {
  String title;
  String url;
  String statusBarColor;

  Item({this.title, this.url, this.statusBarColor});

  Item.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    statusBarColor = json['statusBarColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['statusBarColor'] = this.statusBarColor;
    return data;
  }
}