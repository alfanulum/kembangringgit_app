import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kembangringgit_app/widgets/input_form.dart';
import 'package:kembangringgit_app/widgets/select_form.dart';
import 'package:kembangringgit_app/widgets/button_primary.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentCreateScreen extends StatelessWidget {
  final TextEditingController typeController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  String userNik = '';

  DocumentCreateScreen({Key? key}) : super(key: key);

  void _onSubmitPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String type = typeController.text.trim();
    String title = titleController.text.trim();
    String status = 'Pending';
    String userNik = prefs.getString('nik') ?? "";

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('documents').add({
        'type': type,
        'title': title,
        'status': status,
        'user_nik': userNik,
        'timestamp': FieldValue.serverTimestamp(),
      });

      Get.snackbar('Berhasil', 'Pengajuan dokumen berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/document');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create document',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Pengajuan Dokumen')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SelectForm(
              items: const [
                'Surat Pengantar',
                'Surat Izin',
                'Surat Rekomendasi'
              ],
              onChanged: (String? newValue) {
                // Handle the change in selection
                print('Selected: $newValue');
              },
              value: 'Surat Pengantar',
              text: 'Jenis',
              textEditingController: typeController,
            ),
            const SizedBox(height: 15),
            InputForm(
              controller: titleController,
              text: 'Tujuan',
              obscure: false,
              type: TextInputType.text,
            ),
            const SizedBox(height: 25),
            ButtonPrimary(
              text: 'Buat Pengajuan Dokumen',
              onPressed: _onSubmitPressed,
            )
          ],
        ),
      ),
    );
  }
}
