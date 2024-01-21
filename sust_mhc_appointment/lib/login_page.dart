// ignore_for_file: use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // ignore: use_key_in_widget_constructors
  LoginPage({Key? key});

  Future<bool> _validateLogin(String email, String password) async {
    try {
      final csvData = await rootBundle.loadString('authentication/authorized_students.csv');
      if (kDebugMode) {
        print('CSV Data before conversion: $csvData');
      }

      final rows = const CsvToListConverter(eol: '\n', fieldDelimiter: ',').convert(csvData);
      if (kDebugMode) {
        print('Rows: $rows');
        print('Rows length before loop: ${rows.length}');
      }

      if (rows.length <= 1) {
        if (kDebugMode) {
          print('No data in CSV or invalid CSV format');
        }
        return false;
      }

      for (int i = 1; i < rows.length; i++) {
        var row = rows[i];
        if (kDebugMode) {
          print('Row: $row');
        }

        if (row.length >= 2) {
          var csvEmail = row[0].trim();
          var csvPassword = row[1].trim();

          if (kDebugMode) {
            print('CSV Email: $csvEmail, CSV Password: $csvPassword');
          }

          if (csvEmail == email.trim() && csvPassword == password.trim()) {
            if (kDebugMode) {
              print('Valid login for email: $email');
            }
            return true;
          }
        } else {
          if (kDebugMode) {
            print('Invalid CSV row format: $row');
          }
        }
      }

      if (kDebugMode) {
        print('No valid login found for email: $email, password: $password');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error loading or parsing CSV: $e');
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login for Appointment'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    final email = emailController.text;
                    final password = passwordController.text;

                    if (kDebugMode) {
                      print('Before validation');
                    }
                    bool isValidLogin = await _validateLogin(email, password);
                    if (kDebugMode) {
                      print('After validation');
                    }

                    if (isValidLogin) {
                      Navigator.pushNamed(context, '/appointmentRequest');
                    } else {
                      _showInvalidLoginPopup(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInvalidLoginPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Login', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('Please check your email and password and try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK', style: TextStyle(color: Colors.deepPurple)),
            ),
          ],
        );
      },
    );
  }
}
