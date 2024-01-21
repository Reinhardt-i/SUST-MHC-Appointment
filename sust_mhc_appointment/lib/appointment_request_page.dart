import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:csv/csv.dart';

class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  AppointmentRequestPageState createState() => AppointmentRequestPageState();
}

class AppointmentRequestPageState extends State<AppointmentRequestPage> {
  late DateTime selectedDate = DateTime.now();
  final TextEditingController phoneNumController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _confirmAppointment() {
    if (_formKey.currentState?.validate() ?? false) {
      final phoneNum = phoneNumController.text;
      final requestedTimeSlot = DateFormat('HH:mm').format(selectedDate);
      final requestDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      _saveAppointmentRequest(phoneNum, requestedTimeSlot, requestDateTime);

      if (selectedDate.weekday == DateTime.friday ||
          selectedDate.weekday == DateTime.saturday) {
        _showClosedPopup();
      } else {
        Navigator.pushNamed(context, '/slots', arguments: selectedDate);
      }
    }
  }

void _saveAppointmentRequest(String phoneNum, String requestedTimeSlot, String requestDateTime) {
  try {
    final List<List<dynamic>> data = [
      ['Phone', 'Requested Time Slot', 'Request DateTime'],
      [phoneNum, requestedTimeSlot, requestDateTime],
    ];

    final csvFileContent = const ListToCsvConverter().convert(data);

    final file = File('appointment_requests.csv');
    if (!file.existsSync()) {
      // If the file doesn't exist, create it and add the header
      file.writeAsStringSync(csvFileContent);
    } else {
      // If the file already exists, append the new data
      file.writeAsStringSync('$csvFileContent\n', mode: FileMode.append);
    }

    if (kDebugMode) {
      print('Data appended to CSV file successfully');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error appending data to CSV file: $e');
    }
  }
}

  void _showClosedPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sorry, Closed!'),
          content: const Text('We are closed on Fridays and Saturdays.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Request'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phoneNumController,
                decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Choose a Date'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                child: const Text('Select Date', style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 16),
              Text(
                'Selected Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _confirmAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Confirm'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
