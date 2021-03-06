import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../constants.dart';
import '../models/categoria.dart';
import 'package:http/http.dart' as http;

class CategoriaProvider with ChangeNotifier {
  CategoriaProvider() {
    getCategoria();
    //getCursos();
    //getEmployeeList();
  }

  List<CategoriaModel> _categoria = [];

  List<CategoriaModel> get todos {
    return [..._categoria];
  }

  LocalStorage storage = LocalStorage('usertoken');

  void addCategoria(CategoriaModel categoria) async {
    var token = storage.getItem('token');
    final response = await http.post(
        Uri.parse("http://${apiUrl}/api/categoria/"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token'
        },
        body: json.encode(categoria));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      /*categoria.id = json.decode(response.body)['id'];
      print(categoria.id);
      _categoria.add(categoria);*/
      getCategoria();
      notifyListeners();
    }
  }

  void updateCategoria(CategoriaModel categoria, int id) async {
    var token = storage.getItem('token');
    final response = await http.put(
        Uri.parse("http://${apiUrl}/api/categoria/${id}/"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'token $token'
        },
        body: json.encode(categoria));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Entra");
      categoria.id = id;
      print(id);
      var ante = _categoria.singleWhere((categori) => categori.id == id);
      print(_categoria.indexOf(ante));
      _categoria[_categoria.indexOf(ante)] = categoria;
      notifyListeners();
    }
  }

  void deleteTodo(CategoriaModel categoria) async {
    var token = storage.getItem('token');
    final response = await http.delete(
      Uri.parse('http://${apiUrl}/api/categoria/${categoria.id}/'),
      headers: {'Authorization': 'token $token'},
    );
    print(response.statusCode);
    print(categoria.id);
    if (response.statusCode == 204) {
      _categoria.remove(categoria);
      notifyListeners();
    }
  }

  Future<bool> getCategoria() async {
    _categoria = [];
    var token = storage.getItem('token');
    final url =
        Uri.parse('http://${apiUrl}/api/categoria/?search=&ordering=nombre');
    final response = await http.get(
      url,
      headers: {'Authorization': 'token $token'},
    );
    if (response.statusCode == 200) {
      String body = const Utf8Decoder().convert(response.bodyBytes);
      var data = json.decode(body) as List;
      print(data);
      _categoria = data
          .map<CategoriaModel>((json) => CategoriaModel.fromJson(json))
          .toList();
      notifyListeners();
      return true;
    }
    return false;
  }

  searchCategoria(String? query, String? ordering) async {
    var token = storage.getItem('token');
    final url = Uri.parse(
        'http://${apiUrl}/api/categoria/?search=$query&ordering=$ordering');
    final response = await http.get(
      url,
      headers: {'Authorization': 'token $token'},
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      print(data);
      _categoria = data
          .map<CategoriaModel>((json) => CategoriaModel.fromJson(json))
          .toList();
      notifyListeners();
    }
  }
}
