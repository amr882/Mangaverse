import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatefulWidget {
  final String manga_photo;
  final String manga_titel;
  final String status;
  final int create_at;
  const DetailsPage(
      {super.key,
      required this.manga_photo,
      required this.manga_titel,
      required this.status,
      required this.create_at});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  String time = "";
  getTime() {
    var dateUtc =
        DateTime.fromMillisecondsSinceEpoch(widget.create_at, isUtc: true);
    var dateInMyTimezone = dateUtc.add(Duration(hours: 8));
    var month = DateFormat('MMMM').format(DateTime(0, dateInMyTimezone.month));
    setState(() {
      time = "${dateInMyTimezone.year},$month,${dateInMyTimezone.day}";
    });
  }

  @override
  void initState() {
    getTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 100.w,
                height: 35.h,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromARGB(200, 255, 255, 255),
                        spreadRadius: 50,
                        blurRadius: 20,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: Image.network(
                  widget.manga_photo,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                width: 100.w,
                height: 36.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Color.fromARGB(160, 255, 255, 255),
                      Colors.white
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(2.h),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.manga_photo,
                        height: 27.5.h,
                        width: 35.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Column(
                      children: [
                        SizedBox(
                            width: 50.w,
                            child: Text(
                              widget.manga_titel,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                            width: 50.w,
                            child: Text(
                              "$time\n${widget.status}",
                              style: TextStyle(color: Color(0xff8d8e89)),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
