import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/color.dart';

class TimePicker extends StatefulWidget {
  final ValueSetter<TimeOfDay> onTimeSelected;

  TimePicker({required this.onTimeSelected});

  @override
  _TimePickerState createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay selectedTime;

  @override
  void initState() {
    super.initState();
    selectedTime = TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${selectedTime.hour}:${selectedTime.minute}",
            style: GoogleFonts.openSans(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: violet,
              minimumSize: Size(400, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              "Choose Time",
              style: GoogleFonts.openSans(
                color: white,
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            onPressed: () async {
              final TimeOfDay? timeOfDay = await showTimePicker(
                context: context,
                initialTime: selectedTime,
                initialEntryMode: TimePickerEntryMode.dial,
              );
              if (timeOfDay != null) {
                setState(() {
                  selectedTime = timeOfDay;
                });
                widget.onTimeSelected(timeOfDay);
              }
            },
          )
        ],
      ),
    );
  }
}
