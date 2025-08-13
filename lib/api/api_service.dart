import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchProducts () async{
  final response = await http.get(Uri.parse('https://dummyjson.com/products'));

  if(response.statusCode == 200){
    final data = json.decode(response.body);
    return data['products'];
  }else{
    throw Exception("failed to load products");
  }
}