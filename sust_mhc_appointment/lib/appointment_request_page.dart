import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({Key? key}) : super(key: key);

  @override
  AppointmentRequestPageState createState() => AppointmentRequestPageState();
}

class AppointmentRequestPageState extends State<AppointmentRequestPage> {
  late DateTime selectedDate = DateTime.now();
  final TextEditingController emailController = TextEditingController();
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
      final email = emailController.text;
      final requestedTimeSlot = DateFormat('HH:mm').format(selectedDate);
      final requestDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

      _saveAppointmentRequest(email, requestedTimeSlot, requestDateTime);

      if (selectedDate.weekday == DateTime.friday ||
          selectedDate.weekday == DateTime.saturday) {
        _showClosedPopup();
      } else {
        Navigator.pushNamed(context, '/slots', arguments: selectedDate);
      }
    }
  }

  void _saveAppointmentRequest(String email, String requestedTimeSlot, String requestDateTime) {
    final appointmentRequest = '$email, $requestedTimeSlot, $requestDateTime\n';

    File('appointment_requests.txt').writeAsStringSync(
      appointmentRequest,
      mode: FileMode.append,
    );
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
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Choose a Date'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
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
                  primary: Colors.deepPurple,
                  textStyle: TextStyle(fontSize: 16),
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
