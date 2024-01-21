import 'package:flutter/material.dart';
import 'package:sust_mhc_appointment/login_page.dart';
import 'package:sust_mhc_appointment/appointment_request_page.dart';
import 'package:sust_mhc_appointment/slots.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SUST Mental Health Counseling',
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        buttonTheme: const ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepPurple,
            onPrimary: Colors.white, // Text color for ElevatedButton
          ),
        ), colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple).copyWith(secondary: Colors.deepPurpleAccent),
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
