import 'package:flutter/material.dart';
import 'package:sust_mhc_appointment/login_page.dart';
import 'package:sust_mhc_appointment/appointment_request_page.dart';
import 'package:sust_mhc_appointment/slots.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/appointmentRequest': (context) => AppointmentRequestPage(),
        '/slots': (context) => const SlotsPage(),
      },
    );
  }
}
