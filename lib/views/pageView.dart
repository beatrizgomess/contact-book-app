import 'package:contact_book_app/controller/contactController.dart';
import 'package:contact_book_app/models/contact_model.dart';
import 'package:contact_book_app/views/home_page.dart';
import 'package:contact_book_app/views/list_contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var contactModel = ContactModel();
  XFile? photo;
  int viewAtual = 0;
  var contactController = ContactController();

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    getInfo();
    pageController = PageController(initialPage: viewAtual);
  }

  setViewAtual(view) {
    setState(() {
      viewAtual = view;
    });
  }

  getInfo() async {
    await contactController.getContact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: setViewAtual,
        children: [
          const HomePage(),
          ListContactsPage(
            contactModel: contactModel,
            photo: photo,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewAtual,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_rounded),
            label: 'Cadastrar',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone_sharp), label: 'Contatos')
        ],
        onTap: (view) => pageController.animateToPage(view,
            duration: const Duration(milliseconds: 400), curve: Curves.ease),
      ),
    );
  }
}
