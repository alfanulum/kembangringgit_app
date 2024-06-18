import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kembangringgit_app/widgets/button_primary.dart';
import 'package:kembangringgit_app/widgets/input_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController _NIKController = TextEditingController();
  final TextEditingController _PasswordController = TextEditingController();

  void _onLoginPressed(BuildContext context) async {
    String nik = _NIKController.text.trim();
    String password = _PasswordController.text.trim();

    try {
      QuerySnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      bool userFound = false;
      for (var doc in userSnapshot.docs) {
        Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
        String? storedNik = userData['nik'];
        String? storedPassword = userData['password'];
        String? storedName = userData['name'];

        if (storedNik == nik && storedPassword == password) {
          userFound = true;

          // Save user data to local storage
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('nik', storedNik ?? '');
          await prefs.setString('password', storedPassword ?? '');
          await prefs.setString('name', storedName ?? '');

          Get.toNamed('/home');
          break;
        }
      }

      if (!userFound) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('NIK atau password salah')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/logo_app_blue.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Masuk sebagai warga',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 30),
                InputForm(
                  controller: _NIKController,
                  text: 'NIK',
                  obscure: false,
                  type: TextInputType.number,
                ),
                SizedBox(height: 15),
                InputForm(
                  controller: _PasswordController,
                  text: 'Password',
                  obscure: true,
                  type: TextInputType.visiblePassword,
                ),
                SizedBox(height: 25),
                ButtonPrimary(
                  text: 'Masuk',
                  onPressed: () => _onLoginPressed(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
