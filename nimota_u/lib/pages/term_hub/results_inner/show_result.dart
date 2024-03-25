import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:math';

import '../../../store/colors.dart';
import '../../../store/store.dart';

double alphH = 20;
double alphW = 15;
double rotH = alphH * 2.7;
double rotW = alphW * 2.0;
double aH = alphH * 1.2;
double aW = alphW;
double scoreboxHeight = 16;

class ShowResult extends StatefulWidget {
  final int index;
  final int termIndex;
  const ShowResult({super.key, required this.index, required this.termIndex});

  @override
  State<ShowResult> createState() => _ShowResultState();
}

class _ShowResultState extends State<ShowResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      appBar: AppBar(
        title: const Text('Results PDF Preview'),
      ),
      body: PdfPreview(
        dynamicLayout: false,
        canChangePageFormat: false,
        canDebug: false,
        maxPageWidth: 700,
        build: (format) => generateDocument(format),
      ),
    );
  }

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    // final ByteData byte = await rootBundle.load('assets/stamp.jpg');
    // final Uint8List list = byte.buffer.asUint8List();

    final ByteData byte1 = await rootBundle.load('assets/images/logo.jpeg');
    final Uint8List list1 = byte1.buffer.asUint8List();

    for (int i = 0;
        i <
            MainStore
                .classes[widget.index].terms[widget.termIndex].students.length;
        i++) {
      doc.addPage(
        pw.Page(
          build: (context) {
            return pw.Padding(
              padding: const pw.EdgeInsets.only(
                left: 0,
                right: 0,
                bottom: 0,
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          height: 70,
                          width: 70,
                          child: pw.Image(pw.MemoryImage(list1)),
                        ),
                        pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.center,
                            children: [
                              pw.SizedBox(height: 4),
                              pw.Text('NIMOTA INTERNATIONAL SCIENCE COLLEGE',
                                  style: pw.TextStyle(
                                      fontSize: 20,
                                      color: PdfColors.green,
                                      letterSpacing: 0.1,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.Text('No. 23 Aliade Road Abagu Gboko West',
                                  style: pw.TextStyle(
                                      fontSize: 16,
                                      fontWeight: pw.FontWeight.bold)),
                              pw.SizedBox(height: 4),
                              pw.Text("TERMLY CONTINOUS ASSESMENT DOSSIER",
                                  style: pw.TextStyle(
                                      fontSize: 18,
                                      color: PdfColors.deepPurple,
                                      fontWeight: pw.FontWeight.bold,
                                      fontStyle: pw.FontStyle.italic)),
                            ])
                      ]),
                  pw.SizedBox(height: 4),
                  pw.Text(
                      'NAME OF STUDENT: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].name}'),
                  pw.SizedBox(height: 5),
                  pw.Row(children: [
                    pw.Text(
                        "CLASS: ${MainStore.classes[widget.index].className}"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'TERM: ${MainStore.classes[widget.index].terms[widget.termIndex].termName.toUpperCase()}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'SESSION: ${MainStore.classes[widget.index].session}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('ADM NO:        '),
                  ]),
                  pw.Row(children: [
                    pw.Text("ATTENDANCE:      "),
                    pw.Expanded(child: pw.Container()),
                    pw.Text("DAYS OUT OF:      "),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'SEX:${MainStore.classes[widget.index].terms[widget.termIndex].students[i].gender}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'AGE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].age} years'),
                  ]),
                  pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Row(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          _box("SUBJECTS", rotH + alphH, 100),
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Row(children: [
                                                pw.Column(children: [
                                                  _box(
                                                      'SUMMARY OF\nASSESSMENT SCORES',
                                                      rotH - aH,
                                                      aW * 7),
                                                  pw.Row(children: [
                                                    _box('A\n5', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('T\n10', aH, aW),
                                                    _box('T\n10', aH, aW),
                                                    _box('T\n10', aH, aW),
                                                  ])
                                                ]),
                                                _rotBox(
                                                    'TERM\nEXAM', rotH, rotW),
                                                _rotBox(
                                                    'TERM\nTOTAL', rotH, rotW),
                                                _rotBox('CLASS\nAVERAGE', rotH,
                                                    rotW + 10),
                                                _rotBox('HIGHEST\nIN CLASS',
                                                    rotH, rotW + 10),
                                                _rotBox('LOWEST\nIN CLASS',
                                                    rotH, rotW + 10),
                                                _rotBox('POSITION\nIN CLASS',
                                                    rotH, rotW + 10),
                                                _rotBox('GRADE', rotH, rotW),
                                              ]),
                                              pw.Row(children: [
                                                _box("A", alphH, alphW),
                                                _box("B", alphH, alphW),
                                                _box("C", alphH, alphW),
                                                _box("D", alphH, alphW),
                                                _box("E", alphH, alphW),
                                                _box("F", alphH, alphW),
                                                _box("G", alphH, alphW),
                                                _box("H", alphH, rotW),
                                                _box("I", alphH, rotW),
                                                _box("J", alphH, rotW + 10),
                                                _box("K", alphH, rotW + 10),
                                                _box("L", alphH, rotW + 10),
                                                _box("M", alphH, rotW + 10),
                                                _box("N", alphH, rotW),
                                                // _box("O", alphH, alphW),
                                              ]),
                                            ],
                                          ),
                                        ]),
                                    pw.Column(
                                      children: _scores(i),
                                    ),
                                  ]),
                              pw.SizedBox(width: 2),
                              pw.Column(children: [
                                _attendanceDevelopment(),
                                pw.SizedBox(height: 5),
                                _psychomotorSkills()
                              ])
                            ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text(
                              'NUMBER OF SUBJ.: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].subjects.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'MAXIMUM MARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].subjects.length * 100}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'MARKS OBTAINED: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].total}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text(
                              'AVERAGE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].average.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'POSITION IN CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].position}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'OUT OF: ${MainStore.classes[widget.index].terms[widget.termIndex].students.length}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 8),
                        pw.Text(
                            "FORM MASTER'S REMARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].remark} ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text(
                              "FORM MASTTER'S NAME: ${MainStore.classes[widget.index].ftName}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'SIGNATURE/DATE: _____________  ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text(
                              'TERM ENDS:  ${MainStore.classes[widget.index].terms[widget.termIndex].resultIssuedDate}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'NEXT TERM BEGINS:${MainStore.classes[widget.index].terms[widget.termIndex].nextTermBegins}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text(
                              'OLD SCHOOL FEES BAL: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].feesOwed}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'NEXT TERM FEES:NGN ${MainStore.classes[widget.index].terms[widget.termIndex].nextTermBills}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'TOTAL: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].feesOwed}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 5),
                        pw.Text(
                            "PRINCIPAL'S REMARKS: ${_principalRemarks(MainStore.classes[widget.index].terms[widget.termIndex].students[i].average)} ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 5),
                        pw.Row(children: [
                          pw.Text('NAME OF PRINCIPAL: ${MainStore.htName}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'SIGNATURE/DATE: _____________ ${DateTime.now().day} / ${DateTime.now().month} / ${DateTime.now().year}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('STAMP :_______________',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 10),
                        pw.Row(children: [
                          pw.Text("KEYS TO GRADING: ",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Text(
                              "FINAL ASSESSMENT: (A Distinction, B Very Good, C Good, D Fair, E Poor)\nA 75 and above, B 60-74, C 50-59, D 40-49, E 48 and below",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              ))
                        ])
                      ])
                ],
              ),
            );
          },
        ),
      );
    }

    return await doc.save();
  }

  _box(String a, double h, double w) {
    return pw.Container(
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      height: h,
      width: w,
      child: pw.Center(
          child: pw.Text(a,
              style: pw.TextStyle(
                fontSize: 8,
                fontWeight: pw.FontWeight.bold,
              ))),
    );
  }

  _freeBoxH(String a, double h, double w) {
    return pw.Container(
      padding: pw.EdgeInsets.all(1),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      // height: h,
      width: w,
      child: pw.Center(
          child: pw.Text(a,
              style: pw.TextStyle(
                fontSize: 6,
                fontWeight: pw.FontWeight.bold,
              ))),
    );
  }

  _rotBox(String a, double h, double w) {
    return pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        height: h,
        width: w,
        child: pw.Transform.rotate(
          angle: pi / 2,
          child: pw.Center(
              child: pw.Text(a,
                  style: pw.TextStyle(
                    fontSize: 8,
                    fontWeight: pw.FontWeight.bold,
                  ))),
        ));
  }

  _psychomotorSkills() {
    return pw.Container(
        child: pw
            .Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
      _freeBoxH("'C'  PSYCHOMOTOR\nSKILLS", scoreboxHeight, rotW * 3),
      pw.Row(
        children: [
          _freeBoxH("SCALE".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH("1-5", scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH("HandWriting".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(".\n.", scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH("Fluency".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH("Game/Sport".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH(
              "Drawing & Painting".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH("Musical Skills".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
        ],
      ),
    ]));
  }

  _attendanceDevelopment() {
    return pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
          _freeBoxH("'B'  ATTENDANCE\nDEVELOPMENT", scoreboxHeight, rotW * 3),
          pw.Row(
            children: [
              _freeBoxH("SCALE", scoreboxHeight, rotW * 1.5),
              _freeBoxH("1-5", scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Attendance", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Attentiveness", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Punctuality", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Neatness", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Politeness", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Self Control", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Relationship with others", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Curiosity", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Honesty", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Humility", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Tolerance", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Leadership", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Courage", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Obedient", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
        ]));
  }

  _random() {
    return (Random().nextInt(5 - 3) + 3).toString();
  }

  _scores(int stdIndex) {
    List<pw.Widget> temp = [];
    for (int i = 0;
        i <
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects.length;
        i++) {
      temp.add(_sujectRow(i, stdIndex));
    }
    return temp;
  }

  _sujectRow(int sub, int stdIndex) {
    return pw.Row(children: [
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].name,
          scoreboxHeight,
          100),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[0]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[1]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[2]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[3]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[4]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[5]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[6]
              .toString(),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[7]
              .toString(),
          scoreboxHeight,
          rotW),

      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].total
              .toString(),
          scoreboxHeight,
          rotW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].average
              .toStringAsFixed(2),
          scoreboxHeight,
          rotW + 10),
      // Highest in Class . . .
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].highest
              .toString(),
          scoreboxHeight,
          rotW + 10),
      // Lowest in class . . .
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].lowest
              .toString(),
          scoreboxHeight,
          rotW + 10),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].pos
              .toString(),
          scoreboxHeight,
          rotW + 10),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].grade
              .toString(),
          scoreboxHeight,
          rotW),
    ]);
  }

  _principalRemarks(double a) {
    String rem = "";
    if (a > 70 && a < 100) {
      rem = "An Excellent performance. Keep it up";
    } else if (a > 60 && a < 70) {
      rem = "A good result";
    } else if (a > 50 && a < 60) {
      rem = "keep on trying you can do better";
    } else if (a > 40 && a < 50) {
      rem = "work harder";
    } else if (a > 0 && a < 40) {
      rem = "A poor result, please sit up";
    } else {
      rem = "";
    }
    return rem;
  }
}
