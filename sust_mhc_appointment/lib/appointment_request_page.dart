
import 'package:flutter/material.dart';

class AppointmentRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Request'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Choose a Date'),
            // Add date picker here
            // Depending on the selected date, show available slots or 'off day'
            // Add logic to navigate to the next page on slot selection
          ],
        ),
      ),
    );
  }
}
