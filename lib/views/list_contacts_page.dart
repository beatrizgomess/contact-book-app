import 'dart:io';

import 'package:contact_book_app/controller/contactController.dart';
import 'package:contact_book_app/models/contact_model.dart';
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
  var contactController = ContactController();
  @override
  void initState() {
    getinfo();
    super.initState();
  }

  getinfo() {
    contactController.getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ContactModel>>(
          future: contactController.getContact(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Text("Nenhum Contato");
            else {
              List<ContactModel>? list = snapshot.data;
              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Container(
                          width: 400,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.amber,
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.all(18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        child: Image.file(
                                          File(widget.photo!.path),
                                        ),
                                      ),
                                      Text(list[index].name ?? ""),
                                      Text(list[index].phone ?? ""),
                                    ],
                                  ),
                                  Text(list[index].email ?? ""),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            contactController.deleteContact(
                                                widget.contactModel.objectId!);
                                          },
                                          icon: Icon(Icons.delete))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
