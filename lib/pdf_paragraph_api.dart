import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

class PdfApii {
  static Future<File> generateCenteredText(
      {String school = "",
      String classSub = "",
      String unitTest = "",
      String marks = "",
      String date = "",
      String dateNow = "",
      String watermark = "",
      String totalTime = "",
      List list,
      List<List<Uint8List>> answer,
      List list2,
      bool show=false,
      String footer = "",
      String pdfname = ""}) async {
    final imageJpg =
        (await rootBundle.load('assets/pic6.JPG')).buffer.asUint8List();
    final image =
        (await rootBundle.load('assets/pic2.JPG')).buffer.asUint8List();

    final pdf = pw.Document();
    final font1 = await PdfGoogleFonts.acmeRegular();
    pdf.addPage(pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: pw.EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          buildBackground: (context) => pw.Container(
              child: pw.Column(children: [
                pw.Spacer(),
                pw.Center(
                    child: pw.Transform.rotate(
                        angle: 1,
                        child: pw.Opacity(
                            opacity: 0.3,
                            child: pw.Text(
                              watermark,
                              style: pw.TextStyle(
                                  fontSize: 92,
                                  color: PdfColor.fromInt(0xff808080),
                                  fontWeight: pw.FontWeight.bold),
                            )))),
                pw.Spacer(),
                footer != ""
                    ? pw.Container(
                        alignment: pw.Alignment.center,
                        width: double.infinity,
                        height: 20,
                        decoration: pw.BoxDecoration(
                            color: PdfColor.fromInt(0xffD3D0D0),
                            border: pw.Border.all(color: PdfColors.black)),
                        child: pw.Text(footer,
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 12)))
                    : pw.Container()
              ]),
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black))),
          theme: pw.ThemeData.withFont(
            base: font1,
          ),
          // pw.Column(children: [
          //    pw.Spacer(),
          //    pw.Center(
          //        child: pw.Transform.rotate(
          //            angle: 1,
          //            child: pw.Opacity(
          //                opacity: 0.3,
          //                child: pw.Text(
          //                  "GRM School",
          //                  style: pw.TextStyle(
          //                      fontSize: 92,
          //                      color: PdfColor.fromInt(0xff808080),
          //                      fontWeight: pw.FontWeight.bold),
          //                )))),
          //    pw.Spacer(),
          //    pw.Container(
          //        alignment: pw.Alignment.center,
          //        width: double.infinity,
          //        height: 20,
          //        decoration: pw.BoxDecoration(
          //          color: PdfColor.fromInt(0xffD3D0D0),
          //          border: pw.Border.all(
          //            color: PdfColors.black
          //          )
          //        ),
          //        child: pw.Text("Wish You - All the best",
          //            style: pw.TextStyle(
          //                color: PdfColors.black, fontSize: 12)))
          // ])
        ),
        build: (pw.Context context) => [
              pw.ListView(children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text(school, style: pw.TextStyle(fontSize: 24)),
                    ]),
                pw.ListView(children: [
                  pw.Stack(children: [
                    pw.Container(
                        width: double.infinity,
                        height: 30,
                        child: pw.Stack(children: [
                          pw.Positioned(
                              right: 0,
                              bottom: 0,
                              child: pw.Padding(
                                padding:
                                    pw.EdgeInsets.symmetric(horizontal: 10),
                                child: pw.Text("Date: $dateNow",
                                    style: pw.TextStyle(fontSize: 14)),
                              )),
                        ])),
                    pw.Container(
                        width: double.infinity,
                        height: 30,
                        child: pw.Stack(children: [
                          pw.Row(
                              mainAxisAlignment: pw.MainAxisAlignment.center,
                              children: [
                                pw.Text(classSub,
                                    style: pw.TextStyle(fontSize: 24)),
                              ])
                        ]))
                  ])
                ]),
                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("Marks: $marks",
                            style: pw.TextStyle(fontSize: 20)),
                        pw.Text(unitTest, style: pw.TextStyle(fontSize: 24)),
                        pw.Text("Time: $totalTime",
                            style: pw.TextStyle(fontSize: 20)),
                      ]),
                ),
                pw.Container(
                    width: double.infinity,
                    height: 4,
                    decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.black))),
                pw.SizedBox(height: 10),

                for (int i = 0; i < list2.length; i++)
                  pw.Container(
                      alignment: pw.Alignment.bottomRight,
                      width: double.infinity,
                      padding: pw.EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Column(children: [
                              pw.SizedBox(height: 2),
                              pw.Container(
                                child: pw.Text("Q) ${i + 1}",
                                    style: pw.TextStyle(
                                      color: PdfColor.fromInt(0xff252323),
                                    )),
                              )
                            ]),
                            pw.Container(
                                width: 530,
                                child:
                                    pw.Image(pw.MemoryImage(list[list2[i]]))),
                          ])),

                // pw.Container(
                //   alignment: pw.Alignment.bottomRight,
                //   width: double.infinity,
                //   padding: pw.EdgeInsets.only(left: 10,right: 10,top: 10),
                //   child: pw.Row(
                //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //       pw.Column(
                //
                //         children: [
                //           pw.SizedBox(height: 2),
                //           pw.Container(
                //             child: pw.Text("Q) ${i+1}",style: pw.TextStyle(
                //               color: PdfColor.fromInt(0xff252323),
                //             )),
                //           )
                //         ]
                //       ),

                //     ]
                //   )
                //
                //
                // ),
              ])
            ]));
   show ? pdf.addPage(pw.MultiPage(
        pageTheme: pw.PageTheme(
          margin: pw.EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
          pageFormat: PdfPageFormat.a4,
          orientation: pw.PageOrientation.portrait,
          buildBackground: (context) => pw.Container(
              child: pw.Column(children: [
                pw.Spacer(),
                pw.Center(
                    child: pw.Transform.rotate(
                        angle: 1,
                        child: pw.Opacity(
                            opacity: 0.3,
                            child: pw.Text(
                              watermark,
                              style: pw.TextStyle(
                                  fontSize: 92,
                                  color: PdfColor.fromInt(0xff808080),
                                  fontWeight: pw.FontWeight.bold),
                            )))),
                pw.Spacer(),
                footer != ""
                    ? pw.Container(
                        alignment: pw.Alignment.center,
                        width: double.infinity,
                        height: 20,
                        decoration: pw.BoxDecoration(
                            color: PdfColor.fromInt(0xffD3D0D0),
                            border: pw.Border.all(color: PdfColors.black)),
                        child: pw.Text(footer,
                            style: pw.TextStyle(
                                color: PdfColors.black, fontSize: 12)))
                    : pw.Container()
              ]),
              decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black))),
          theme: pw.ThemeData.withFont(
            base: font1,
          ),
          // pw.Column(children: [
          //    pw.Spacer(),
          //    pw.Center(
          //        child: pw.Transform.rotate(
          //            angle: 1,
          //            child: pw.Opacity(
          //                opacity: 0.3,
          //                child: pw.Text(
          //                  "GRM School",
          //                  style: pw.TextStyle(
          //                      fontSize: 92,
          //                      color: PdfColor.fromInt(0xff808080),
          //                      fontWeight: pw.FontWeight.bold),
          //                )))),
          //    pw.Spacer(),
          //    pw.Container(
          //        alignment: pw.Alignment.center,
          //        width: double.infinity,
          //        height: 20,
          //        decoration: pw.BoxDecoration(
          //          color: PdfColor.fromInt(0xffD3D0D0),
          //          border: pw.Border.all(
          //            color: PdfColors.black
          //          )
          //        ),
          //        child: pw.Text("Wish You - All the best",
          //            style: pw.TextStyle(
          //                color: PdfColors.black, fontSize: 12)))
          // ])
        ),
        build: (pw.Context context) => [
              pw.ListView(
                  padding: pw.EdgeInsets.only(bottom: 20),
                  children: [
                pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.center,
                    children: [
                      pw.Text("", style: pw.TextStyle(fontSize: 24)),
                    ]),
                show ? pw.Text("Answers") : pw.Container(),
                show ? pw.Divider() : pw.Container(),

                for (int i = 0; i < list2.length; i++)
                  for (int j = 0; j < answer[list2[i]].length; j++)
                    pw.Container(
                      margin: j == 0
                          ? pw.EdgeInsets.only(top: 20)
                          : pw.EdgeInsets.all(0),
                      child: pw.Row(children: [
                        j == 0
                            ? pw.Text(" ans: ${i + 1}",
                                style: pw.TextStyle(fontSize: 10))
                            : pw.Text(""),
                        pw.Container(
                          margin: pw.EdgeInsets.only(left: 10, top: 5),
                          alignment: pw.Alignment.topLeft,
                          width: 530,
                          child: pw.Image(pw.MemoryImage(answer[list2[i]][j])),
                        ),
                      ]),
                    )

                // pw.Container(
                //   alignment: pw.Alignment.bottomRight,
                //   width: double.infinity,
                //   padding: pw.EdgeInsets.only(left: 10,right: 10,top: 10),
                //   child: pw.Row(
                //     crossAxisAlignment: pw.CrossAxisAlignment.start,
                //     children: [
                //       pw.Column(
                //
                //         children: [
                //           pw.SizedBox(height: 2),
                //           pw.Container(
                //             child: pw.Text("Q) ${i+1}",style: pw.TextStyle(
                //               color: PdfColor.fromInt(0xff252323),
                //             )),
                //           )
                //         ]
                //       ),

                //     ]
                //   )
                //
                //
                // ),
              ])
            ])):pw.Text("");

    return PdfApii.saveDocument(name: '$pdfname.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    String name,
    pw.Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytesSync(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
