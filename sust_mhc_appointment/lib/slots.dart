import 'package:flutter/material.dart';

class SlotsPage extends StatelessWidget {
  const SlotsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDate = ModalRoute.of(context)!.settings.arguments as DateTime?;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Time Slot'),
        backgroundColor: Colors.deepPurple,
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
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: TextStyle(fontSize: 16, color: Colors.white), // Add text color
              ),
              child: const Text('15:00 - 15:30'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: TextStyle(fontSize: 16, color: Colors.white), // Add text color
              ),
              child: const Text('15:30 - 16:00'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: TextStyle(fontSize: 16, color: Colors.white), // Add text color
              ),
              child: const Text('16:00 - 16:30'),
            ),
            ElevatedButton(
              onPressed: () {
                _showConfirmationPopup(context);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
                textStyle: TextStyle(fontSize: 16, color: Colors.white), // Add text color
              ),
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
              child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        );
      },
    );
  }
}
