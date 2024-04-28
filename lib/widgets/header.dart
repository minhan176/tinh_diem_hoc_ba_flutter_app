import 'package:flutter/material.dart';
import 'package:tinh_diem_hoc_ba/screen/common_screen.dart';

final namHKHeader = <TableRow>[
  TableRow(children: [
    TitleCell(title: 'Lớp 10'),
    TitleCell(title: 'Lớp 11'),
    TitleCell(title: '12'),
  ]),
  TableRow(children: [
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
    TitleCell(title: 'HK I'),
  ])
];

final sauHKHeader = <TableRow>[
  TableRow(children: [
    TitleCell(title: 'Lớp 10'),
    TitleCell(title: 'Lớp 11'),
    TitleCell(title: 'Lớp 12'),
  ]),
  TableRow(children: [
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
  ])
];

final baHKHeader = <TableRow>[
  TableRow(children: [
    TitleCell(title: 'Lớp 11'),
    TitleCell(title: 'Lớp 12'),
  ]),
  TableRow(children: [
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'HK I'), TitleCell(title: 'HK II')])
    ]),
    TitleCell(title: 'HK I'),
  ])
];

final lop12Header = [
  TableRow(children: [
    TitleCell(title: 'ĐTB Cả Năm Lớp 12'),
  ]),
];

final lop11Header = <TableRow>[
  TableRow(children: [
    TitleCell(title: 'ĐTB Cả Năm Lớp 11'),
    TitleCell(title: 'HKI Lớp 12')
  ])
];

final lop1011Header = <TableRow>[
  TableRow(children: [
    Table(border: TableBorder.all(color: Colors.black, width: 1), children: [
      TableRow(children: [TitleCell(title: 'ĐTB Cả Năm')]),
      TableRow(children: [
        Table(
            border: TableBorder.all(color: Colors.black, width: 1),
            children: [
              TableRow(
                children: [
                  TitleCell(title: 'Lớp 10'),
                  TitleCell(title: 'Lớp 11')
                ],
              )
            ]),
      ]),
    ]),
    TitleCell(title: 'HKI Lớp 12'),
  ]),
];
