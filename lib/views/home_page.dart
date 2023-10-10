import 'dart:io';

import 'package:contact_book_app/components/text_form_field_component.dart';
import 'package:contact_book_app/controller/contactController.dart';
import 'package:contact_book_app/models/contact_model.dart';
import 'package:contact_book_app/service/image_service.dart';
import 'package:contact_book_app/views/list_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart';
import 'package:gallery_saver/gallery_saver.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  XFile? photo;
  var contactModel = ContactModel();
  var contactController = ContactController();
  var imageService = ImageService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Meus Contatos")),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: [
                            ListTile(
                                title: Text("Câmera"),
                                leading: Icon(Icons.camera),
                                onTap: () async {
                                  imageService.takeImage(photo);
                                  setState(() {});
                                }),
                            ListTile(
                              title: Text("Galeria"),
                              leading: Icon(Icons.photo),
                              onTap: () async {
                                final ImagePicker imagePicker = ImagePicker();
                                photo = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {});
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Selecione uma Imagem"),
                ),
                photo != null
                    ? Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Container(
                            height: 200,
                            width: 150,
                            child: Image.file(File(photo!.path)),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(height: 60),
                TextFormFieldComponent(
                  keyboardType: TextInputType.name,
                  label: "Nome",
                  controller: nameController,
                  icon: Icon(Icons.person),
                ),
                SizedBox(height: 20),
                TextFormFieldComponent(
                  keyboardType: TextInputType.phone,
                  label: "Número de telefone",
                  controller: numeroController,
                  icon: Icon(Icons.phone_android),
                ),
                SizedBox(height: 20),
                TextFormFieldComponent(
                  keyboardType: TextInputType.emailAddress,
                  label: "Email",
                  controller: emailController,
                  icon: Icon(Icons.email),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      contactModel.email = emailController.text.toUpperCase();
                      contactModel.name = nameController.text.toUpperCase();
                      contactModel.phone = numeroController.text;
                      contactModel.photo = photo!.path;
                      contactController.createContact(contactModel);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListContactsPage(
                            contactModel: contactModel,
                            photo: photo,
                          ),
                        ),
                      );
                    },
                    child: const Text("Salvar")),
                const SizedBox(height: 50),
                ElevatedButton.icon(
                    onPressed: () async {
                      await contactController.getContact();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListContactsPage(
                                    contactModel: contactModel,
                                    photo: photo,
                                  )));
                      setState(() {});
                    },
                    icon: const Icon(Icons.contacts),
                    label: const Text("Meus contatos"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
