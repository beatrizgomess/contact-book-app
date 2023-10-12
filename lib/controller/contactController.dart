import 'dart:convert';
import 'package:contact_book_app/constants/contants.dart';
import 'package:contact_book_app/models/contact_model.dart';
import 'package:contact_book_app/repositories/contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ContactController implements ContactRepository {
  @override
  var viaCepModel = ContactModel();

  @override
  Future<List<ContactModel>> getContact() async {
    try {
      var response = await http.get(Uri.parse(Constants.urlBack4app),
          headers: Constants.headers);
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var body = response.body;
        var json = jsonDecode(body);
        print(response.statusCode);

        return (json['results'] as List)
            .map((e) => ContactModel.fromJson(e))
            .toList();
      } else {
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao obter contatos: $e');
    }
  }

  @override
  Future<void> createContact(ContactModel contactModel) async {
    try {
      var responde = await http.post(
        Uri.parse(Constants.urlBack4app),
        headers: Constants.headers,
        body: jsonEncode(contactModel.toJson()),
      );
      if (responde.statusCode == 200) {
        print(responde.body);
      }
    } catch (e) {
      throw Exception('Erro ao salvar CEP: $e');
    }
  }

  @override
  Future<void> deleteContact(String id) async {
    try {
      var response = await http.delete(
          Uri.parse(Constants.urlBack4app + '/${id}'),
          headers: Constants.headers);
    } catch (e) {
      throw Exception('Erro ao deletar CEP: $e');
    }
  }

  @override
  Future<ContactModel> updateContact(ContactModel contactModel) async {
    try {
      var response = await http.put(
        Uri.parse('${Constants.urlBack4app}/${contactModel.objectId}'),
        headers: Constants.headers,
        body: jsonEncode(contactModel.toJson()),
      );

      if (response.statusCode == 200) {
        var body = response.body;
        var json = jsonDecode(body);
        return ContactModel.fromJson(json);
      } else {
        // Lida com um erro HTTP não esperado (por exemplo, 404, 500)
        throw Exception('Erro na solicitação HTTP: ${response.statusCode}');
      }
    } catch (e) {
      // Lida com exceções gerais, como erro de conexão
      throw Exception('Erro ao atualizar contato: $e');
    }
  }
}
