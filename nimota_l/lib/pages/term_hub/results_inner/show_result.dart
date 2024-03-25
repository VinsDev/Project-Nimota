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

    final ByteData byte1 = await rootBundle.load('assets/images/logo.png');
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
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Container(
                    padding: pw.EdgeInsets.all(4),
                    width: double.maxFinite,
                    // height: 160,
                    decoration: const pw.BoxDecoration(color: PdfColors.purple),
                    child: pw.Row(
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
                                pw.Text('NIMOTA MEMORIAL ACADEMY',
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 18,
                                        letterSpacing: 0.1,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.Text('No. 23 Aliade Road Abagu Gboko West',
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold)),
                                pw.SizedBox(height: 4),
                                pw.Text("Knowledge & Integrity",
                                    style: pw.TextStyle(
                                        color: PdfColors.white,
                                        fontSize: 16,
                                        fontWeight: pw.FontWeight.bold,
                                        fontStyle: pw.FontStyle.italic)),
                              ])
                        ]),
                  ),
                  pw.SizedBox(height: 1),
                  pw.Container(
                    decoration: const pw.BoxDecoration(color: PdfColors.red),
                    child: pw.Text("TERMLY CONTINOUS ASSESMENT",
                        style: pw.TextStyle(
                          color: PdfColors.white,
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        )),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text(
                        'NAME OF PUPIL: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].name}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        "CLASS: ${MainStore.classes[widget.index].className}"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'AVERAGE AGE: ${MainStore.classes[widget.index].terms[widget.termIndex].averageAge} years'),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text(
                        'SEX:${MainStore.classes[widget.index].terms[widget.termIndex].students[i].gender}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        "PUPIL'S AGE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].age} years"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        'TERM: ${MainStore.classes[widget.index].terms[widget.termIndex].termName.toUpperCase()}'),
                    pw.Expanded(child: pw.Container()),
                    pw.Text('YEAR: ${MainStore.classes[widget.index].session}'),
                  ]),
                  pw.SizedBox(height: 4),
                  pw.Row(children: [
                    pw.Text(
                      'POSITION IN CLASS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].position}',
                    ),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        "CLASS ENROLMENT: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].classEnrolment}"),
                    pw.Expanded(child: pw.Container()),
                    pw.Text(
                        "DAYS OUT OF SCHOOL: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].doc}"),
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
                                                  pw.Row(children: [
                                                    _box('1ST ASS.\nWEEKS 1-6',
                                                        rotH - aH, aW * 4),
                                                    _box('2ND ASS.\nWEEKS 7-12',
                                                        rotH - aH, aW * 4),
                                                  ]),
                                                  pw.Row(children: [
                                                    _box('A\n5', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('T\n15', aH, aW),
                                                    _box('TT\n25', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('A\n5', aH, aW),
                                                    _box('T\n15', aH, aW),
                                                    _box('TT\n25', aH, aW),
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
                                                _box("A".toLowerCase(), alphH,
                                                    alphW),
                                                _box("B".toLowerCase(), alphH,
                                                    alphW),
                                                _box("C".toLowerCase(), alphH,
                                                    alphW),
                                                _box("D".toLowerCase(), alphH,
                                                    alphW),
                                                _box("E".toLowerCase(), alphH,
                                                    alphW),
                                                _box("F".toLowerCase(), alphH,
                                                    alphW),
                                                _box("G".toLowerCase(), alphH,
                                                    alphW),
                                                _box("H".toLowerCase(), alphH,
                                                    alphW),
                                                _box("I".toLowerCase(), alphH,
                                                    rotW),
                                                _box("J".toLowerCase(), alphH,
                                                    rotW),
                                                _box("K".toLowerCase(), alphH,
                                                    rotW + 10),
                                                _box("L".toLowerCase(), alphH,
                                                    rotW + 10),
                                                _box("M".toLowerCase(), alphH,
                                                    rotW + 10),
                                                _box("N".toLowerCase(), alphH,
                                                    rotW + 10),
                                                _box("O".toLowerCase(), alphH,
                                                    rotW),
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
                              'TOTAL SCORES: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].total}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'MAXIMUM SCORE: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].subjects.length * 100}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'AVERAGE MARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].average.toStringAsFixed(2)}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 8),
                        pw.Text(
                            "CLASS TEACHER'S REMARKS: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].remark} ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.SizedBox(height: 2),
                        pw.Row(children: [
                          pw.Text(
                              "CLASS TEACHER'S NAME: ${MainStore.classes[widget.index].ftName}",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('SIGNATURE: __________________________',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 2),
                        pw.Text(
                            "HEAD TEACHER'S REMARKS: ${_principalRemarks(MainStore.classes[widget.index].terms[widget.termIndex].students[i].average)} ",
                            style: pw.TextStyle(
                              fontSize: 8,
                              fontWeight: pw.FontWeight.bold,
                            )),
                        pw.Row(children: [
                          pw.Text('NAME OF HEAD TEACHER: ${MainStore.htName}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text('SIGNATURE : __________________________',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(height: 4),
                        pw.Row(children: [
                          pw.Text(
                              'NEXT TERM BEGINS: ${MainStore.classes[widget.index].terms[widget.termIndex].nextTermBegins}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'FEES OWED: ${MainStore.classes[widget.index].terms[widget.termIndex].students[i].feesOwed}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Expanded(child: pw.Container()),
                          pw.Text(
                              'BILL FOR NEXT TERM: ${MainStore.classes[widget.index].terms[widget.termIndex].nextTermFees}',
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                        ]),
                        pw.SizedBox(width: 10),
                        pw.Row(children: [
                          pw.Text("KEYS TO GRADING: ",
                              style: pw.TextStyle(
                                fontSize: 8,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Text(
                              "FINAL ASSESSMENT: (A Excellent, B Very Good, C Good, D Fair, E Average, F Fail)\nA 80% and above, B 70-79%, C 60-69, D 50-59, E 40-49%, F 39% and below and below",
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

  _principalRemarks(double a) {
    String rem = "";
    if (a >= 70 && a <= 100) {
      rem = "An Excellent performance. Keep it up";
    } else if (a >= 60 && a < 70) {
      rem = "A good result";
    } else if (a >= 50 && a < 60) {
      rem = "keep on trying you can do better";
    } else if (a >= 40 && a < 50) {
      rem = "work harder";
    } else if (a >= 0 && a < 40) {
      rem = "A poor result, please sit up";
    } else {
      rem = "";
    }
    return rem;
  }

  _freeBoxH(String a, double h, double w) {
    return pw.Container(
        alignment: pw.Alignment.centerLeft,
        padding: pw.EdgeInsets.only(left: 2, top: 2, bottom: 2),
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        // height: h,
        width: w,
        child: pw.Text(a,
            style: pw.TextStyle(
              fontSize: 6,
              fontWeight: pw.FontWeight.bold,
            )));
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
      _freeBoxH("'C'  PSYCHOMOTOR DOMAIN OF EDUCATIONAL DEVELOPMENT",
          scoreboxHeight, rotW * 3),
      pw.Row(
        children: [
          _freeBoxH("HandWriting".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
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
          _freeBoxH("Gymnastic".toUpperCase(), scoreboxHeight, rotW * 1.5),
          _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
        ],
      ),
      pw.Row(
        children: [
          _freeBoxH("Handling of Tools & Agric Equipments".toUpperCase(),
              scoreboxHeight, rotW * 1.5),
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
          _freeBoxH(
              "Crafts Construction".toUpperCase(), scoreboxHeight, rotW * 1.5),
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

  _random() {
    return (Random().nextInt(5 - 3) + 3).toString();
  }

  _attendanceDevelopment() {
    return pw.Container(
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
          _freeBoxH("'B'  EFFECTIVE\nDEVELOPMENT", scoreboxHeight, rotW * 3),
          pw.Row(
            children: [
              _freeBoxH(
                  "BEHAVIOURAL\nTRAITS\n", scoreboxHeight, rotW * 1.5 + 2),
              pw.Column(children: [
                _freeBoxH("RATING SCALE", scoreboxHeight, rotW * 1.5),
                _freeBoxH("1-5               ", scoreboxHeight, rotW * 1.5)
              ])
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
              _freeBoxH("Reliability", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Imitativeness", scoreboxHeight, rotW * 1.5),
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
              _freeBoxH("Fellowship", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Stewardship", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Perseverance", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Considerate & Friendly", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Generosity", scoreboxHeight, rotW * 1.5),
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
              _freeBoxH("Moral Courage", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Physical Courage", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Cooperation", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
          pw.Row(
            children: [
              _freeBoxH("Honesty", scoreboxHeight, rotW * 1.5),
              _freeBoxH(_random(), scoreboxHeight, rotW * 1.5)
            ],
          ),
        ]));
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
          _add([
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[0],
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[1],
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[2]
          ]),
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
          _add([
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[3],
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[4],
            MainStore.classes[widget.index].terms[widget.termIndex]
                .students[stdIndex].subjects[sub].ass[5]
          ]),
          scoreboxHeight,
          alphW),
      _box(
          MainStore.classes[widget.index].terms[widget.termIndex]
              .students[stdIndex].subjects[sub].ass[6]
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
}

String _add(List<int> list) {
  int tot = 0;
  for (int i = 0; i < list.length; i++) {
    tot += list[i];
  }
  return tot.toString();
}
