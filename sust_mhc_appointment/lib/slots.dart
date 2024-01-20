import 'package:flutter/material.dart';

class SlotsPage extends StatelessWidget {
  final DateTime selectedDate;

  SlotsPage(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Time Slot'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Available Time Slots for ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the selection of 15:00-15:30
              },
              child: const Text('15:00 - 15:30'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the selection of 15:30-16:00
              },
              child: const Text('15:30 - 16:00'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the selection of 16:00-16:30
              },
              child: const Text('16:00 - 16:30'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle the selection of 16:30-17:00
              },
              child: const Text('16:30 - 17:00'),
            ),
          ],
        ),
      ),
    );
  }
}
