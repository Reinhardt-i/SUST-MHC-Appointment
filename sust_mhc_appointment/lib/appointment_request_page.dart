// appointment_request_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'slots.dart'; // Import the SlotsPage

class AppointmentRequestPage extends StatefulWidget {
  const AppointmentRequestPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AppointmentRequestPageState createState() => _AppointmentRequestPageState();
}

class _AppointmentRequestPageState extends State<AppointmentRequestPage> {
  late DateTime selectedDate = DateTime.now();

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
        // Add logic here to handle the selected date
      });
    }
  }

  void _confirmAppointment() {
    if (selectedDate != null) {
      if (selectedDate.weekday == DateTime.friday ||
          selectedDate.weekday == DateTime.saturday) {
        // Show popup for closed days
        _showClosedPopup();
      } else {
        // Navigate to the SlotsPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SlotsPage(selectedDate),
          ),
        );
      }
    } else {
      // Handle error, show a message, or prevent navigation
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
              child: const Text('OK'),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Choose a Date'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Select Date'),
            ),
            if (selectedDate != null)
              const SizedBox(height: 16),
              Text(
                'Selected Date: ${DateFormat('dd/MM/yyyy').format(selectedDate)}',
                style: const TextStyle(fontSize: 18),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _confirmAppointment,
              child: const Text('Confirm Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
