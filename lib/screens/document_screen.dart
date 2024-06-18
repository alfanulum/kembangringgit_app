import 'package:flutter/material.dart';
import 'package:kembangringgit_app/widgets/button_primary.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({Key? key}) : super(key: key);

  void _onCreateDocumentPressed() {
    Get.toNamed('/document/create');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pengajuan Dokumen'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.toNamed('/home');
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            FutureBuilder<String?>(
              future: _getUserNik(),
              builder:
                  (BuildContext context, AsyncSnapshot<String?> nikSnapshot) {
                if (nikSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (nikSnapshot.hasError ||
                    !nikSnapshot.hasData ||
                    nikSnapshot.data == null) {
                  return const Center(
                      child: Text('Error: Failed to get user_nik'));
                }

                String userNik = nikSnapshot.data!;

                return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('documents')
                      .where('user_nik', isEqualTo: userNik)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }

                    List<DocumentSnapshot> userDocuments = snapshot.data!.docs;

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: userDocuments.length,
                      itemBuilder: (BuildContext context, int index) {
                        var document = userDocuments[index];
                        String title = document['title'];
                        String type = document['type'];
                        String status = document['status'];

                        return Container(
                          width: double.infinity,
                          height: 100,
                          padding: const EdgeInsets.all(20),
                          margin: const EdgeInsets.only(bottom: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                              255, 124, 33, 243)
                                          .withOpacity(.2),
                                      borderRadius:
                                          BorderRadius.circular(10000),
                                    ),
                                    child: const Icon(
                                      Ionicons.document,
                                      color: Color.fromARGB(255, 124, 33, 243),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        type,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(status),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    status,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 15),
            ButtonPrimary(
              text: 'Tambah Pengajuan Dokumen',
              onPressed: _onCreateDocumentPressed,
            ),
          ],
        ),
      ),
    );
  }

  Future<String?> _getUserNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nik');
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
