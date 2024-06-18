import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kembangringgit_app/widgets/input_form.dart';
import 'package:kembangringgit_app/widgets/button_primary.dart';

class ReportScreenScreen extends StatefulWidget {
  ReportScreenScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenScreenState createState() => _ReportScreenScreenState();
}

class _ReportScreenScreenState extends State<ReportScreenScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  String userNik = '';
  String? filePath;
  Uint8List? fileBytes;

  void _onSubmitPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String status = 'Pending';
    String userNik = prefs.getString('nik') ?? "";

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      Map<String, dynamic> reportData = {
        'title': title,
        'description': description,
        'status': status,
        'user_nik': userNik,
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (fileBytes != null) {
        String fileName = filePath!.split('/').last;
        Reference storageRef =
            FirebaseStorage.instance.ref().child('reports/$fileName');
        UploadTask uploadTask = storageRef.putData(fileBytes!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        reportData['file_url'] = downloadUrl;
      }

      await firestore.collection('reports').add(reportData);

      Get.snackbar('Berhasil', 'Laporan berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/report');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create report',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        filePath = result.files.single.name;
        fileBytes = result.files.single.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buat Laporan')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            ButtonPrimary(
              onPressed: _pickFile,
              text: filePath == null ? 'Unggah Lampiran' : 'Ubah Lampiran',
            ),
            if (filePath != null) Text(filePath!),
            const SizedBox(height: 25),
            InputForm(
              controller: titleController,
              text: 'Judul',
              obscure: false,
              type: TextInputType.text,
            ),
            const SizedBox(height: 25),
            InputForm(
              controller: descriptionController,
              text: 'Deskripsi',
              obscure: false,
              type: TextInputType.text,
            ),
            const SizedBox(height: 25),
            ButtonPrimary(
              text: 'Buat Laporan',
              onPressed: _onSubmitPressed,
            ),
          ],
        ),
      ),
    );
  }
}
