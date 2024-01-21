import 'package:flutter/material.dart';
import 'package:sust_mhc_appointment/login_page.dart';
import 'package:sust_mhc_appointment/appointment_request_page.dart';
import 'package:sust_mhc_appointment/slots.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUST Mental Health Counseling',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/appointmentRequest': (context) => const AppointmentRequestPage(),
        '/slots': (context) => const SlotsPage(),
      },
    );
  }
}
