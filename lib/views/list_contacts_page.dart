import 'dart:io';

import 'package:contact_book_app/components/text_form_field_component.dart';
import 'package:contact_book_app/controller/contactController.dart';
import 'package:contact_book_app/models/contact_model.dart';
import 'package:contact_book_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ListContactsPage extends StatefulWidget {
  ListContactsPage(
      {super.key, required this.contactModel, required this.photo});
  var contactModel = ContactModel();
  XFile? photo;
  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var contactController = ContactController();
  var contacst = [];
  @override
  void initState() {
    getinfo();
    super.initState();
  }

  getinfo() async {
    await contactController.getContact();
    contacst.add(contactController.getContact());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de contatos"),
      ),
      body: FutureBuilder<List<ContactModel>>(
        future: contactController.getContact(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
                child: Column(
              children: [
                const Text("Nenhum Contato"),
                const Text("Para adiconar, clique no botão abaixo"),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Text("Adicionar Contato"),
                )
              ],
            ));
          else {
            List<ContactModel>? list = snapshot.data;
            return ListView.builder(
              itemCount: list!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    width: 400,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amber,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: Image.file(
                                    File(list[index].photo!),
                                  ),
                                ),
                                Text(list[index].name ?? ""),
                                Text(list[index].phone ?? ""),
                              ],
                            ),
                            Text(list[index].email ?? ""),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      await contactController
                                          .updateContact(list[index]);
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child:
                                                  const SingleChildScrollView(
                                                child: Column(
                                                  children: [],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () async {
                                      await contactController
                                          .deleteContact(list[index].objectId!);
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.delete))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
