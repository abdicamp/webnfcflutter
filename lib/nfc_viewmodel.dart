import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:webnfcflutter/model/listModel.dart';

class NfcViewModel extends FutureViewModel {
  List<dynamic> listID = [];

  List<ListModel> listItemProduct = [];

  List<ListModel> listItemUID = [];
  List<ListModel> listItemDataID = [];

  List<ListModel> listDataInv = [];
  List<ListModel> listDataGetInv = [];

  List<ListModel> listTableSo = [];

  late Timer timer;

  ListModel? selectedValueProdCode;
  ListModel? selectedValueIdCode;

  TextEditingController? selectedValueIdCodeString = TextEditingController();
  TextEditingController? selectedValueIdCodeString2 = TextEditingController();
  TextEditingController? selectedValueIdCodeString3 = TextEditingController();
  TextEditingController? totalSubtotal = TextEditingController();
  TextEditingController? totalPPNText = TextEditingController();
  TextEditingController? totalNetText = TextEditingController();

  String? codeId;
  String? uid;
  String? uid2;
  String? uid3;
  dynamic totalValue;

  // void sendData2() async {
  //   try {
  //     final response = await http.get(Uri.parse("uri"));
  //   } catch (e) {}
  // }

  void sendData(String value) async {
    if (value.isNotEmpty) {
      final Map<String, dynamic> data = {
        'idProduct': '${codeId}',
        'idCard': '${value}',
      };
      print("data post : ${data}");

      final Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final response = await http.post(
        Uri.parse("http://192.168.1.105:1345/api/postId"),
        headers: headers,
        body: jsonEncode(data),
      );
      print("data body : ${response.body}");
      if (response.statusCode == 201) {
        updateStockSystem();
        print("Berhasil");
        notifyListeners();
      } else if (response.statusCode == 500) {
        print("gagal");
        // timer.cancel();
        notifyListeners();
      }

      print(response.statusCode);
      notifyListeners();
    }
  }

  updateStockSystem() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.1.105:1345/api/updateStockSystem/${codeId.toString()}/${uid.toString()}"));
      print("respons update ${response.statusCode}");
    } catch (e) {
      print(e);
    }
  }

  updateStockAct() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.1.105:1345/api/updateStockAct/${uid2.toString()}"));
      print("respons update ${response.statusCode}");
    } catch (e) {
      print(e);
    }
  }

  getDataId() async {
    try {
      final response =
          await http.get(Uri.parse("http://192.168.1.105:1345/api/getId"));
      Iterable it = jsonDecode(response.body);
      List<ListModel> datalist = it.map((e) => ListModel.fromJson(e)).toList();
      listItemDataID = List.from(datalist);

      notifyListeners();
      return datalist;
    } catch (e) {
      print(e);
    }
  }

  getDataProduct() async {
    print("jalan");

    final response = await http
        .get(Uri.parse("http://192.168.1.105:1345/api/getNFCTableProduct"));
    Iterable it = jsonDecode(response.body);
    List<ListModel> dataJson = it.map((e) => ListModel.fromJson(e)).toList();
    listItemProduct = List.from(dataJson);
    final data = jsonDecode(response.body);

    // print("it : ${it}");
    // print("dataJson : ${dataJson}");
    // print("listItemProduct : ${listItemProduct}");
    // print("response.body ${response.body}");

    notifyListeners();
    return dataJson;
  }

  getData() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.105:1345/api/mobile/uid"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      uid = data['uid'];
      selectedValueIdCodeString?.text = uid.toString();
      sendData(uid.toString());
      getDataId();
      print(uid);

      notifyListeners();
    }
    notifyListeners();
  }

  getData2() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.105:1345/api/mobile/uid2"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      uid2 = data['uids'];
      selectedValueIdCodeString2?.text = uid2.toString();
      print(response.statusCode);
      updateStockAct();
      print("uid2 : ${uid2}");
      notifyListeners();
    }
    notifyListeners();
  }

  getData3() async {
    final response =
        await http.get(Uri.parse("http://192.168.1.105:1345/api/mobile/uid3"));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      uid3 = data['uids'];
      selectedValueIdCodeString3?.text = uid3.toString();
      print(response.statusCode);
      goInvoice();
      // updateStockAct();
      print("uid3 : ${uid3}");
      notifyListeners();
    }
    notifyListeners();
  }

  goInvoice() async {
    try {
      final response = await http.get(Uri.parse(
          "http://192.168.1.105:1345/api/createtInvoice/${uid3.toString()}"));
      Iterable it = jsonDecode(response.body);
      List<ListModel> dataList = it.map((e) => ListModel.fromJson(e)).toList();
      print("invoice jalan");
      listDataInv = List.from(dataList);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  dynamic calculateTotalQty(List<Map<String, dynamic>> items) {
    num totalQty = 0;

    for (var item in items) {
      if (item.containsKey("SubTotal")) {
        totalQty += item["SubTotal"];
      }
    }

    return totalQty;
  }

  getDataInvoice() async {
    print("jalan invoice");
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    final response =
        await http.get(Uri.parse("http://192.168.1.105:1345/api/getInvoice"));
    Iterable it = jsonDecode(response.body);
    List<ListModel> dataJson = it.map((e) => ListModel.fromJson(e)).toList();
    listDataGetInv = List.from(dataJson);
    List<Map<String, dynamic>> jsonDataList =
        jsonDecode(response.body).cast<Map<String, dynamic>>();

    int? totalAll = calculateTotalQty(jsonDataList);

    totalValue = totalAll;
    totalSubtotal?.text = formatCurrency.format(totalValue);
    dynamic ppn = 0.11;
    totalPPNText?.text = ppn.toString();
    dynamic totalPPN = totalValue * ppn;
    totalNetText?.text = formatCurrency.format(totalPPN);
    print("totalPPN : ${totalPPN}");

    print(totalValue);
    notifyListeners();
    return dataJson;
  }

  getTableSo() async {
    print("jalan invoice");

    final response =
        await http.get(Uri.parse("http://192.168.1.105:1345/api/getTableSo"));
    Iterable it = jsonDecode(response.body);
    List<ListModel> dataJson = it.map((e) => ListModel.fromJson(e)).toList();
    listTableSo = List.from(dataJson);

    // print("it : ${it}");
    // print("dataJson : ${dataJson}");
    // print("listItemProduct : ${listItemProduct}");
    // print("response.body ${response.body}");

    notifyListeners();
    return dataJson;
  }

  deleteTableId() async {
    try {
      final response = await http
          .delete(Uri.parse("http://192.168.1.105:1345/api/deleteTableId"));
      getDataId();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  deleteTableSO() async {
    try {
      final response = await http
          .delete(Uri.parse("http://192.168.1.105:1345/api/deleteTableSO"));
      getTableSo();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  deleteTableInvoice() async {
    try {
      final response = await http.delete(
          Uri.parse("http://192.168.1.105:1345/api/deleteTableInvoice"));
      getDataInvoice();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future futureToRun() async {
    print(selectedValueIdCodeString);
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData2());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getData3());

    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getDataProduct());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getDataInvoice());
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => getTableSo());

    // timer = Timer.periodic(Duration(seconds: 2), (Timer t) => postItemData());

    // timer = Timer.periodic(Duration(seconds: 2), (Timer t) => getDataId());
    await getDataId();
    await getData();
    await getDataProduct();
  }
}
