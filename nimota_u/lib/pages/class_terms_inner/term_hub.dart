import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../models/class_model.dart';
import '../../store/colors.dart';
import '../../store/store.dart';
import '../term_hub/assessments.dart';
import '../term_hub/results.dart';
import '../term_hub/students.dart';
import '../term_hub/subjects.dart';

class ClassPage extends StatefulWidget {
  final String name;
  final int classKey;
  final int classIndex;
  final String termName;

  final int termIndex;

  const ClassPage(
      {super.key, 
      required this.name,
      required this.classKey,
      required this.classIndex,
      required this.termName,
      required this.termIndex})
     ;

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late Box<Class> classBox;
  String nextTermBegins = "";
  String nextTermBills = "";
  String resultIssuedDate = "";

  @override
  void initState() {
    super.initState();
    classBox = Hive.box<Class>("name");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackground,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                width: double.maxFinite,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 20, left: 15, bottom: 20, right: 5),
                        child: Icon(
                          Icons.arrow_back,
                          color: iconColor,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${widget.name} ${widget.termName}",
                      style: TextStyle(
                          color: textColors,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5),
                    ),
                    Expanded(child: Container()),
                    /*  const Icon(
                      Icons.more_vert_rounded,
                      size: 24,
                    ), */
                  ],
                ),
              ),
            ),
            Container(
              height: 0.5,
              width: double.maxFinite,
              color: const Color.fromARGB(255, 37, 29, 107),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectPage(
                              className: widget.name,
                              classKey: widget.classKey,
                              classIndex: widget.classIndex,
                              termIndex: widget.termIndex,
                            )));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColors, width: 0.5),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 0.5, spreadRadius: 0.5)
                    ],
                    color: Colors.white),
                child: Row(
                  children: [
                    const Text(
                      "Subjects",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 38,
                      width: 38,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: borderColors, width: 0.5)),
                      child: Center(
                          child: Text(
                        MainStore.classes[widget.classIndex]
                                .terms[widget.termIndex].subjects.isNotEmpty
                            ? MainStore.classes[widget.classIndex]
                                .terms[widget.termIndex].subjects.length
                                .toString()
                            : "0",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      )),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentsPage(
                              className: widget.name,
                              classKey: widget.classKey,
                              classIndex: widget.classIndex,
                              termIndex: widget.termIndex,
                            )));
              },
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 0.5, spreadRadius: 0.5)
                    ],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: borderColors, width: 0.5),
                    color: Colors.white),
                child: Row(
                  children: [
                    const Text(
                      "Students",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2),
                    ),
                    Expanded(child: Container()),
                    Container(
                      height: 38,
                      width: 38,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: borderColors, width: 0.5)),
                      child: Center(
                          child: Text(
                        MainStore.classes[widget.classIndex]
                                .terms[widget.termIndex].students.isNotEmpty
                            ? MainStore.classes[widget.classIndex]
                                .terms[widget.termIndex].students.length
                                .toString()
                            : "0",
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5),
                      )),
                    )
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Assessments(
                                  className: widget.name,
                                  classKey: widget.classKey,
                                  classIndex: widget.classIndex,
                                  termIndex: widget.termIndex,
                                )));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 0.5,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Assesments",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Results(
                                  className: widget.name,
                                  classKey: widget.classKey,
                                  classIndex: widget.classIndex,
                                  termIndex: widget.termIndex,
                                )));
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: borderColors, width: 0.5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 0.5,
                            spreadRadius: 0.5)
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Results",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Next Term Begins",
                    style: TextStyle(
                      color: textColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (MainStore.classes.isNotEmpty) {
                  nextTermBegins = MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBegins;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(43, 173, 172, 172),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColors)),
                            child: TextFormField(
                                onChanged: ((value) {
                                  nextTermBegins = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter next term start date"),
                                initialValue:
                                    MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBegins),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBegins =
                                      nextTermBegins;
                                  classBox.put(widget.classKey,
                                      MainStore.classes[widget.classIndex]);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'SAVE',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "You need to create atleast one Class before you can add this"),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 0.5, spreadRadius: 0.3)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColors, width: 0.3),
                    color: Colors.white),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBegins.isNotEmpty
                              ? MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBegins
                              : "Not set yet",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Tap to change",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColors),
                            color: borderColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: iconColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Next Term Bill",
                    style: TextStyle(
                      color: textColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (MainStore.classes.isNotEmpty) {
                  nextTermBills = MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBills;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(43, 173, 172, 172),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColors)),
                            child: TextFormField(
                                onChanged: ((value) {
                                  nextTermBills = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter next term bill"),
                                initialValue:
                                    MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBills),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBills =
                                      nextTermBills;
                                  classBox.put(widget.classKey,
                                      MainStore.classes[widget.classIndex]);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'SAVE',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "You need to create atleast one Class before you can add this"),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 0.5, spreadRadius: 0.3)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColors, width: 0.3),
                    color: Colors.white),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBills.isNotEmpty
                              ? MainStore.classes[widget.classIndex].terms[widget.termIndex].nextTermBills
                              : "Not set yet",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Tap to change",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColors),
                            color: borderColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: iconColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Result Issue Date",
                    style: TextStyle(
                      color: textColors,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                if (MainStore.classes.isNotEmpty) {
                  resultIssuedDate = MainStore.classes[widget.classIndex].terms[widget.termIndex].resultIssuedDate;
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(43, 173, 172, 172),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: borderColors)),
                            child: TextFormField(
                                onChanged: ((value) {
                                  resultIssuedDate = value;
                                }),
                                cursorColor: Colors.black,
                                decoration: const InputDecoration.collapsed(
                                    hintText: "Enter results issue date"),
                                initialValue:
                                    MainStore.classes[widget.classIndex].terms[widget.termIndex].resultIssuedDate),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'CANCEL',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  MainStore.classes[widget.classIndex].terms[widget.termIndex].resultIssuedDate =
                                      resultIssuedDate;
                                  classBox.put(widget.classKey,
                                      MainStore.classes[widget.classIndex]);
                                });
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'SAVE',
                                style: TextStyle(color: popTextColors),
                              ),
                            ),
                          ],
                        );
                      });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "You need to create atleast one Class before you can add this"),
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: double.maxFinite,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, blurRadius: 0.5, spreadRadius: 0.3)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: borderColors, width: 0.3),
                    color: Colors.white),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MainStore.classes[widget.classIndex].terms[widget.termIndex].resultIssuedDate.isNotEmpty
                              ? MainStore.classes[widget.classIndex].terms[widget.termIndex].resultIssuedDate
                              : "Not set yet",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1.0),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Tap to change",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8),
                        ),
                      ],
                    ),
                    Expanded(child: Container()),
                    InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(color: borderColors),
                            color: borderColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Icon(
                          Icons.refresh_rounded,
                          color: iconColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
