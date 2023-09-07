import 'dart:js';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webnfcflutter/helpers/scalable_dp_helper.dart';
import 'package:webnfcflutter/model/listModel.dart';
import 'package:webnfcflutter/shared/dimens.dart';
import 'package:webnfcflutter/shared/styles.dart';

class DataTables extends DataTableSource {
  DataTables({
    List<ListModel>? productData,
  })  : _productData = productData ?? [],
        assert(productData != null);

  final List<ListModel>? _productData;

  @override
  DataRow? getRow(int index) {
    final item = _productData?[index];
    // final formatCurrency =
    //     NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0);

    return DataRow.byIndex(
      onSelectChanged: (value) {},
      index: index,
      cells: <DataCell>[
        DataCell(
          Text(
            '${index + 1}',
            style: montserratBoldTextStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ),
        DataCell(
          Text(
            '${item?.idProduct ?? ''}',
            style: montserratBoldTextStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ),
        DataCell(
          Text(
            '${item?.idCard ?? ''}',
            style: montserratBoldTextStyle.copyWith(
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _productData?.length ?? 0;

  @override
  int get selectedRowCount => 0;
}
