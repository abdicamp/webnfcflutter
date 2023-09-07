import 'dart:convert';

List<ListModel> ListModelFromJson(String str) =>
    List<ListModel>.from(json.decode(str).map((x) => ListModel.fromJson(x)));

String ListModelToJson(List<ListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListModel {
  String? id;
  String? prodCode;
  String? idProduct;
  String? stock;
  num? disc;
  String? price;
  String? idCard;
  num? uid;
  String? nameProduct;
  String? prodName;
  int? StockSystem;
  int? StockAct;
  int? StockDiff;
  int? qty;
  int? SubTotal;

  ListModel(
      {this.idProduct,
      this.prodCode,
      this.idCard,
      this.prodName,
      this.nameProduct,
      this.stock,
      this.disc,
      this.uid,
      this.id,
      this.qty,
      this.SubTotal,
      this.StockSystem,
      this.StockAct,
      this.StockDiff,
      this.price});

  factory ListModel.fromJson(Map<String, dynamic> json) => ListModel(
        prodCode: json["ProdCode"],
        idCard: json["idCard"],
        idProduct: json["idProduct"],
        stock: json["Stock"],
        disc: json["disc"],
        price: json["Price"],
        nameProduct: json["nameProduct"],
        prodName: json["ProdName"],
        uid: json["uid"],
        StockSystem: json["StockSystem"],
        StockAct: json["StockAct"],
        StockDiff: json["StockDiff"],
        id: json["Id"],
        qty: json["QTY"],
        SubTotal: json["SubTotal"],
      );
  Map<String, dynamic> toJson() => {
        "idCard": idCard,
        "ProdName": prodName,
        "Price": price,
        "Stock": stock,
        "uid": uid,
        "Id": id,
        "QTY": qty,
        "StockSystem": StockSystem,
        "StockAct": StockAct,
        "StockDiff": StockDiff,
        "SubTotal": SubTotal,
      };
}
