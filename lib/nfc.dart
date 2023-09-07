import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:stacked/stacked.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'package:webnfcflutter/helpers/scalable_dp_helper.dart';
import 'package:webnfcflutter/home.dart';
import 'package:webnfcflutter/list_drawer.dart';
import 'package:webnfcflutter/model/listModel.dart';
import 'package:webnfcflutter/nfc_viewmodel.dart';
import 'package:http/browser_client.dart' as client;
import 'package:webnfcflutter/shared/colors.dart';
import 'package:webnfcflutter/shared/custom_search_dropdownlist.dart';
import 'package:webnfcflutter/shared/dimens.dart';
import 'package:webnfcflutter/shared/styles.dart';
import 'package:webnfcflutter/shared/ui_helpers.dart';
import 'package:webnfcflutter/widget/data_product_total.dart';
import 'package:webnfcflutter/widget/data_stock_product.dart';
import 'package:webnfcflutter/widget/data_table.dart';

class Nfc extends StatefulWidget {
  const Nfc({super.key});

  @override
  State<Nfc> createState() => _NfcState();
}

class _NfcState extends State<Nfc> with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("001"), value: "001"),
      DropdownMenuItem(child: Text("002"), value: "002"),
      DropdownMenuItem(child: Text("003"), value: "003"),
      DropdownMenuItem(child: Text("004"), value: "004"),
    ];
    return menuItems;
  }

  TextEditingController txttes = TextEditingController();

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatCurrency =
        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);
    SDP.init(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => NfcViewModel(),
        builder: (context, vm, child) {
          return Scaffold(
              backgroundColor: Color.fromRGBO(191, 211, 203, 1),
              body: SingleChildScrollView(
                  child: Stack(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Image.asset(
                  //     width: 150,
                  //     height: 150,
                  //     "images/logo.png",
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Container(
                          //   height: 50,
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.5),
                          //         spreadRadius: 2,
                          //         blurRadius: 10,
                          //         offset:
                          //             Offset(0, 3), // Mengatur posisi bayangan (x, y)
                          //       ),
                          //     ],
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(),
                          //       Row(
                          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           GestureDetector(
                          //               onTap: () {},
                          //               child: Icon(Icons.people_alt_sharp)),
                          //           SizedBox(
                          //             width: 10,
                          //           ),
                          //           InkWell(child: Icon(Icons.login_outlined)),
                          //           SizedBox(
                          //             width: 20,
                          //           ),
                          //         ],
                          //       )
                          //     ],
                          //   ),
                          // ),

                          Container(
                              width: 370,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(0,
                                        3), // Mengatur posisi bayangan (x, y)
                                  ),
                                ],
                              ),
                              child: TabBar(
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      10.0,
                                    ),
                                    color: Color.fromRGBO(143, 197, 175, 1),
                                  ),
                                  controller: tabController,
                                  unselectedLabelColor: Colors.black,
                                  tabs: const <Widget>[
                                    Tab(
                                      icon: Icon(Icons.app_registration_sharp),
                                    ),
                                    Tab(
                                      icon: Icon(Icons.list_alt_outlined),
                                    ),
                                    Tab(
                                        icon:
                                            Icon(Icons.shopping_bag_outlined)),
                                  ])),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Container(
                              height: 900,
                              width: 1300,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 90, 89, 89)
                                        .withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 20,
                                    offset: Offset(0,
                                        3), // Mengatur posisi bayangan (x, y)
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: TabBarView(
                                    controller: tabController,
                                    children: [
                                      Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      Text("Product Code",
                                                          style:
                                                              montserratBoldTextStyle),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          height: 50,
                                                          width: 200,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                            border: Border.all(
                                                                color: BaseColors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.3)),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child:
                                                                CustomSearchableDropDown(
                                                              // menuMode: true,
                                                              items: vm
                                                                  .listItemProduct,
                                                              label:
                                                                  'Product Code',
                                                              labelStyle:
                                                                  montserratRegularTextStyle
                                                                      .copyWith(
                                                                fontSize: 10,
                                                                color:
                                                                    BaseColors
                                                                        .black,
                                                              ),
                                                              padding:
                                                                  EdgeInsets
                                                                      .zero,
                                                              // searchBarHeight: SDP.sdp(40),
                                                              hint:
                                                                  'Product Code',
                                                              dropdownHintText:
                                                                  'Cari Product Code',
                                                              dropdownItemStyle:
                                                                  montserratRegularTextStyle
                                                                      .copyWith(
                                                                fontSize: 15,
                                                                color:
                                                                    BaseColors
                                                                        .black,
                                                              ),
                                                              dropDownMenuItems: vm
                                                                  .listItemProduct
                                                                  .map((item) {
                                                                return "${item.id}.${item.prodName}";
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                if (value !=
                                                                    null) {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                  setState(() {
                                                                    vm.selectedValueProdCode =
                                                                        value;

                                                                    vm.codeId = vm
                                                                        .selectedValueProdCode
                                                                        ?.id;
                                                                    print(
                                                                        "data id : ${vm.codeId}");
                                                                    // print(vm
                                                                    //     .selectedValueProdCodeString);
                                                                  });
                                                                } else {
                                                                  FocusManager
                                                                      .instance
                                                                      .primaryFocus
                                                                      ?.unfocus();
                                                                  vm.selectedValueProdCode =
                                                                      null;
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "ID",
                                                        style:
                                                            montserratSemiBoldTextStyle,
                                                      ),
                                                      SizedBox(
                                                        width: 100,
                                                      ),
                                                      Container(
                                                        width: 200,
                                                        height: 60,
                                                        child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller: vm
                                                                .selectedValueIdCodeString,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                vm.sendData(
                                                                    value);
                                                                print(
                                                                    "value : ${value}");
                                                              });
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              label: Text('ID',
                                                                  style:
                                                                      montserratBoldTextStyle),
                                                              enabledBorder:
                                                                  const OutlineInputBorder(
                                                                      //Outline border type for TextFeild
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              10)),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey,
                                                                        width:
                                                                            1,
                                                                      )),
                                                              focusedBorder:
                                                                  const OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.all(Radius.circular(
                                                                              20)),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            1,
                                                                      )),
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Padding(
                                                //     padding: EdgeInsets.all(15),
                                                //     child: Row(
                                                //       children: [
                                                //         SizedBox(
                                                //           width: 200,
                                                //         ),
                                                //         ElevatedButton(
                                                //             style: ButtonStyle(
                                                //               backgroundColor:
                                                //                   MaterialStateProperty.all<
                                                //                           Color>(
                                                //                       Color.fromARGB(
                                                //                           255,
                                                //                           102,
                                                //                           135,
                                                //                           108)), // Ganti dengan warna latar belakang yang Anda inginkan
                                                //               foregroundColor:
                                                //                   MaterialStateProperty
                                                //                       .all<Color>(Colors
                                                //                           .white), // Ganti dengan warna teks yang Anda inginkan
                                                //             ),
                                                //             onPressed: () async {
                                                //               await vm
                                                //                   .postItemData();
                                                //               // final response = await http.get(Uri.parse(
                                                //               //     "http://192.168.1.105:1345/api/getNFCTableProduct"));
                                                //               // print(response.body);
                                                //               // // await vm.getDataProduct();
                                                //               setState(() {
                                                //                 vm.getDataId();
                                                //                 vm.selectedValueIdCodeString
                                                //                     ?.text = "";
                                                //               });
                                                //             },
                                                //             child: Text("Add")),
                                                //       ],
                                                //     )),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: product(
                                                      vm.listItemDataID),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            print("delete");
                                                            vm.deleteTableId();
                                                          });
                                                        },
                                                        child: Text("Reset")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Container(
                                          width: 700,
                                          height: 600,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 10,
                                                offset: Offset(0,
                                                    3), // Mengatur posisi bayangan (x, y)
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Text(
                                                    "Stock Opname",
                                                    style:
                                                        montserratSemiBoldTextStyle,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 200,
                                                    height: 60,
                                                    child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        controller: vm
                                                            .selectedValueIdCodeString2,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            vm.selectedValueIdCodeString2
                                                                ?.text = value;
                                                            print(vm
                                                                .selectedValueIdCodeString2);
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                          label: Text('ID Card',
                                                              style:
                                                                  montserratBoldTextStyle),
                                                          enabledBorder:
                                                              const OutlineInputBorder(
                                                                  //Outline border type for TextFeild
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              10)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1,
                                                                  )),
                                                          focusedBorder:
                                                              const OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 1,
                                                                  )),
                                                        )),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: productStock(
                                                      vm.listTableSo),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        onPressed: () async {
                                                          setState(() {
                                                            print("delete");
                                                            vm.deleteTableSO();
                                                          });
                                                        },
                                                        child: Text("Reset")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      Container(
                                        width: 1000,
                                        height: 800,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20),
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 10,
                                              offset: Offset(0,
                                                  3), // Mengatur posisi bayangan (x, y)
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Text(
                                                  "Total",
                                                  style:
                                                      montserratSemiBoldTextStyle,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 200,
                                                  height: 60,
                                                  child: TextField(
                                                      keyboardType:
                                                          TextInputType.number,
                                                      controller: vm
                                                          .selectedValueIdCodeString3,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          vm.selectedValueIdCodeString3
                                                              ?.text = value;
                                                          print(vm
                                                              .selectedValueIdCodeString3);
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        label: Text('ID Card',
                                                            style:
                                                                montserratBoldTextStyle),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                                //Outline border type for TextFeild
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1,
                                                                )),
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .blue,
                                                                  width: 1,
                                                                )),
                                                      )),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: productTotal(
                                                    vm.listDataGetInv),
                                              ),
                                              Container(
                                                  child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Total",
                                                              style:
                                                                  montserratSemiBoldTextStyle,
                                                            ),
                                                            SizedBox(
                                                              width: 20,
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              height: 60,
                                                              child: TextField(
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller: vm
                                                                      .totalSubtotal,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    label: Text(
                                                                      'Total',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        //Outline border type for TextFeild
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                            borderSide: BorderSide(
                                                                              color: Colors.blue,
                                                                              width: 1,
                                                                            )),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "PPN",
                                                              style:
                                                                  montserratSemiBoldTextStyle,
                                                            ),
                                                            SizedBox(
                                                              width: 23,
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              height: 60,
                                                              child: TextField(
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller: vm
                                                                      .totalPPNText,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    label: Text(
                                                                      'PPN',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        //Outline border type for TextFeild
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                            borderSide: BorderSide(
                                                                              color: Colors.blue,
                                                                              width: 1,
                                                                            )),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "Net",
                                                              style:
                                                                  montserratSemiBoldTextStyle,
                                                            ),
                                                            SizedBox(
                                                              width: 24,
                                                            ),
                                                            Container(
                                                              width: 200,
                                                              height: 60,
                                                              child: TextField(
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  controller: vm
                                                                      .totalNetText,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    label: Text(
                                                                      'Net',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              13),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                        //Outline border type for TextFeild
                                                                        borderRadius: BorderRadius.all(Radius.circular(10)),
                                                                        borderSide: BorderSide(
                                                                          color:
                                                                              Colors.grey,
                                                                          width:
                                                                              1,
                                                                        )),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                            borderRadius:
                                                                                BorderRadius.all(Radius.circular(20)),
                                                                            borderSide: BorderSide(
                                                                              color: Colors.blue,
                                                                              width: 1,
                                                                            )),
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          print("delete");
                                                          vm.deleteTableInvoice();
                                                        });
                                                      },
                                                      child: Text("Reset")),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )));
        });
  }
}

Widget product(List<ListModel>? source) {
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: PaginatedDataTable(
        showCheckboxColumn: false,
        showFirstLastButtons: true,
        rowsPerPage: 7,
        columnSpacing: 20.0,
        arrowHeadColor: Colors.black,
        columns: [
          DataColumn(
            label: Text("No", style: montserratBoldTextStyle),
            tooltip: "No",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "ID Product",
                  style: montserratBoldTextStyle,
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "ID",
          ),
          DataColumn(
            label: Row(
              children: [
                Text("ID Card", style: montserratBoldTextStyle),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "ID Card",
          ),
        ],
        source: DataTables(
          productData: source ?? [],
        ),
      ),
    ),
  );
}

Widget productStock(List<ListModel>? source) {
  // print("list data : ${source}");
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: PaginatedDataTable(
        showCheckboxColumn: false,
        showFirstLastButtons: true,
        rowsPerPage: 8,
        columnSpacing: 20.0,
        columns: [
          DataColumn(
            label: Text(
              "No",
              style: blackSemiBoldTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
            tooltip: "No",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "Id",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "ProdCode",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "Nama Product",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "Nama Product",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "Stock System",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "Stock System",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "StockAct",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "StockAct",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "StockDif",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "StockDif",
          ),
        ],
        source: DataTablesStockProduct(
          productData: source ?? [],
        ),
      ),
    ),
  );
}

Widget productTotal(List<ListModel>? source) {
  return Container(
    width: double.infinity,
    child: SingleChildScrollView(
      child: PaginatedDataTable(
        showCheckboxColumn: false,
        showFirstLastButtons: true,
        rowsPerPage: 6,
        columnSpacing: 20.0,
        columns: [
          DataColumn(
            label: Text(
              "No",
              style: blackSemiBoldTextStyle.copyWith(
                fontSize: 10,
              ),
            ),
            tooltip: "No",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "ProdName",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "ProdName",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "QTY",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "QTY",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "Disc",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "Disc",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "Price",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "Price",
          ),
          DataColumn(
            label: Row(
              children: [
                Text(
                  "SubTotal",
                  style: blackSemiBoldTextStyle.copyWith(
                    fontSize: 10,
                  ),
                ),
                horizontalSpace(SDP.sdp(4.0)),
              ],
            ),
            tooltip: "SubTotal",
          ),
        ],
        source: DataTablesTotalProduct(
          productData: source ?? [],
        ),
      ),
    ),
  );
}
