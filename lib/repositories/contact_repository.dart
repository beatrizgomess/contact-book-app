import 'package:contact_book_app/models/contact_model.dart';

abstract class ContactRepository {
  Future<List<ContactModel>> getContact();
  Future<void> createContact(ContactModel contactModel);
  Future<void> deleteContact(String id);
  Future<ContactModel> updateContact(ContactModel contactModel);
}
