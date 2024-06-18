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

class EventCreateScreen extends StatefulWidget {
  EventCreateScreen({Key? key}) : super(key: key);

  @override
  _EventCreateScreenState createState() => _EventCreateScreenState();
}

class _EventCreateScreenState extends State<EventCreateScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  String userNik = '';
  String? filePath;
  Uint8List? fileBytes;

  void _onSubmitPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String title = titleController.text.trim();
    String description = descriptionController.text.trim();
    String status = 'Pending';
    String userNik = prefs.getString('nik') ?? "";
    String startDate = startDateController.text.trim();
    String endDate = endDateController.text.trim();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      Map<String, dynamic> eventData = {
        'title': title,
        'description': description,
        'status': status,
        'user_nik': userNik,
        'start_date': startDate,
        'end_date': endDate,
        'timestamp': FieldValue.serverTimestamp(),
      };

      if (fileBytes != null) {
        String fileName = filePath!.split('/').last;
        Reference storageRef =
            FirebaseStorage.instance.ref().child('events/$fileName');
        UploadTask uploadTask = storageRef.putData(fileBytes!);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        eventData['file_url'] = downloadUrl;
      }

      await firestore.collection('events').add(eventData);

      Get.snackbar('Berhasil', 'Kegiatan berhasil dibuat',
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed('/event');
    } catch (e) {
      Get.snackbar('Error', 'Failed to create event',
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
      appBar: AppBar(title: const Text('Buat Kegiatan')),
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
            InputForm(
              controller: startDateController,
              text: 'Tanggal Mulai (dd/mm/yyyy)',
              obscure: false,
              type: TextInputType.datetime,
            ),
            const SizedBox(height: 25),
            InputForm(
              controller: endDateController,
              text: 'Tanggal Selesai (dd/mm/yyyy)',
              obscure: false,
              type: TextInputType.datetime,
            ),
            const SizedBox(height: 25),
            ButtonPrimary(
              text: 'Buat Kegiatan',
              onPressed: _onSubmitPressed,
            ),
          ],
        ),
      ),
    );
  }
}
