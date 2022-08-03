import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mrsool_test/models/order.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

import 'utils.dart';

class PdfUtils {
  static Future<File> printOrder(Order order, BuildContext buildContext) async {
    final pdf = pw.Document(
      deflate: zlib.encode,
    );

    final logo = (await rootBundle.load('assets/mrsool_logo.png')).buffer.asUint8List();

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: pw.Font.ttf(await rootBundle.load("assets/Cairo-Regular.ttf")),
          bold: pw.Font.ttf(await rootBundle.load("assets/Cairo-Regular.ttf")),
          italic: pw.Font.ttf(await rootBundle.load("assets/Cairo-Regular.ttf")),
          boldItalic: pw.Font.ttf(await rootBundle.load("assets/Cairo-Regular.ttf")),
        ),
        margin: const pw.EdgeInsets.all(0),
        header: (context) => pw.Container(
          decoration: const pw.BoxDecoration(color: PdfColors.blue100),
          height: 100,
          width: double.infinity,
          padding: const pw.EdgeInsets.all(10),
          alignment: pw.Alignment.centerRight,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Image(pw.MemoryImage(logo)),
            ],
          ),
        ),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(height: 20),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(
                            "OrderID: ${order.id}",
                            textDirection: pw.TextDirection.rtl,
                          ),
                          pw.Text(
                            "Date: ${Utils.getFormattedDate(order.receivedAt, buildContext)}",
                            textDirection: pw.TextDirection.rtl,
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            "Mrsool",
                            style: pw.TextStyle(
                              color: PdfColors.grey.shade(700),
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 20),
                  pw.Text("Items: "),
                  if (order.orderDetails?.items != null)
                    ...order.orderDetails!.items!
                        .map(
                          (e) => pw.Container(
                              margin: const pw.EdgeInsets.all(10),
                              child: pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text(e.enName ?? ""),
                                  pw.Text("SAR ${e.itemPrice}"),
                                ],
                              )),
                        )
                        .toList(),
                  pw.SizedBox(height: 20),
                  if (order.orderDetails?.grandTotal != null)
                    pw.Text("Grand Total: SAR ${order.orderDetails?.grandTotal}"),
                ],
              ),
            )
          ];
        },
      ),
    );

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    File file = File("$documentPath/Mrsool Order #${order.id}.pdf");

    file.writeAsBytesSync(await pdf.save());
    return file;
  }
}
