import 'package:flutter/material.dart';

class SlotsPage extends StatelessWidget {
  const SlotsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDate = ModalRoute.of(context)!.settings.arguments as DateTime?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Time Slot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Available Time Slots for ${selectedDate?.day}/${selectedDate?.month}/${selectedDate?.year}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              child: const Text('15:00 - 15:30'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              child: const Text('15:30 - 16:00'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              child: const Text('16:00 - 16:30'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              child: const Text('16:30 - 17:00'),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Appointment Requested!'),
          content: const Text('You will be notified through email if your request is approved'),
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
}
