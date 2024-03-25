import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../models/class_model.dart';
import '../../../store/colors.dart';
import '../../../store/store.dart';

class StudentProfile extends StatefulWidget {
  final String studentName;
  final int classKey;
  final int classIndex;
  final int termIndex;
  final int studentIndex;

  const StudentProfile(
      {super.key,
      required this.studentName,
      required this.classKey,
      required this.classIndex,
      required this.termIndex,
      required this.studentIndex});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  late Box<Class> classBox;

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
                      "Student Profile",
                      style: TextStyle(
                          color: textColors,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.1),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 0.5,
              width: double.maxFinite,
              color: const Color.fromARGB(255, 37, 29, 107),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: popTextColors,
                    child: Icon(
                      Icons.person,
                      color: appBackground,
                      size: 40,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.studentName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1),
                      ),
                      Text(
                        MainStore.classes[widget.classIndex].className,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1),
                      ),
                      Text(
                        MainStore.classes[widget.classIndex]
                            .terms[widget.termIndex].termName,
                        style: TextStyle(
                            color: popTextColors,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            field(
                "Admission Number",
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[widget.studentIndex].admissionNumber,
                saveClassEnrolment),
            field(
                "Age",
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[widget.studentIndex].age,
                saveAge),
            field(
                "Days out of School",
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[widget.studentIndex].daysOut,
                saveDaysOutOfSchool),
            field(
                "Fees Owed",
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[widget.studentIndex].feesOwed,
                saveFeesOwed),
            field(
                "Total Fees",
                MainStore.classes[widget.classIndex].terms[widget.termIndex]
                    .students[widget.studentIndex].feesOwed,
                saveTotalFees),
          ],
        ),
      ),
    );
  }

  field(String title, String value, Function function) {
    String temp = "";
    return InkWell(
      onTap: () {
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
                        temp = value;
                      }),
                      cursorColor: Colors.black,
                      decoration:
                          InputDecoration.collapsed(hintText: "Enter $title"),
                      initialValue: value),
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
                      function(temp);
                    },
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: popTextColors),
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: double.maxFinite,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(color: Colors.black, blurRadius: 0.5, spreadRadius: 0.3)
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
                  value.isEmpty ? "$title not set yet" : "$title: $value",
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
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void saveDaysOutOfSchool(String value) {
    setState(() {
      MainStore.classes[widget.classIndex].terms[widget.termIndex]
          .students[widget.studentIndex].daysOut = value;
      classBox.put(widget.classKey, MainStore.classes[widget.classIndex]);
    });
    Navigator.of(context).pop();
  }

  void saveFeesOwed(String value) {
    setState(() {
      MainStore.classes[widget.classIndex].terms[widget.termIndex]
          .students[widget.studentIndex].feesOwed = value;
      classBox.put(widget.classKey, MainStore.classes[widget.classIndex]);
    });
    Navigator.of(context).pop();
  }

  void saveTotalFees(String value) {
    setState(() {
      MainStore.classes[widget.classIndex].terms[widget.termIndex]
          .students[widget.studentIndex].totalFees = value;
      classBox.put(widget.classKey, MainStore.classes[widget.classIndex]);
    });
    Navigator.of(context).pop();
  }

  void saveAge(String value) {
    setState(() {
      MainStore.classes[widget.classIndex].terms[widget.termIndex]
          .students[widget.studentIndex].age = value;
      classBox.put(widget.classKey, MainStore.classes[widget.classIndex]);
    });
    Navigator.of(context).pop();
  }

  void saveClassEnrolment(String value) {
    setState(() {
      MainStore.classes[widget.classIndex].terms[widget.termIndex]
          .students[widget.studentIndex].admissionNumber = value;
      classBox.put(widget.classKey, MainStore.classes[widget.classIndex]);
    });
    Navigator.of(context).pop();
  }
}
