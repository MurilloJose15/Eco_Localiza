import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class GoogleAutoComplete extends StatefulWidget {
  const GoogleAutoComplete({super.key});

  @override
  State<GoogleAutoComplete> createState() => _GoogleAutoCompleteState();
}

class _GoogleAutoCompleteState extends State<GoogleAutoComplete> {
  final TextEditingController _addressController = TextEditingController();
  double _LatController = 0;
  double _LngController = 0;

  // AUTOCOMPLETE GOOGLE
  var uuid = Uuid();
  String _sessionToken = '122344';
  List<dynamic> _placesList = [];

  @override
  void initState() {
    super.initState();

    _addressController.addListener(() {
      OnChange();
    });
  }

  void OnChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    if (_addressController.text.length > 3) {
      getSuggestion(_addressController.text);
    }
  }

  void getSuggestion(String input) async {
    String kPLACES_API_KEY = "MY_API";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input"_ariquemes"&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken&components=country:br&language=pt';

    var response = await http.get(Uri.parse(request));

    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString())['predictions'];
      });
    }
    if (input.length < 3) {
      setState(() {
        _placesList = [''];
      });
    } else {
      throw Exception('Falha ao carregar os dados');
    }
    debugPrint('$response');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google maps Place api'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(hintText: 'Buscar endereço por nome'),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _placesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () async {
                        List<Location> locations = await locationFromAddress(_placesList[index]['description']);

                        _addressController.text = _placesList[index]['description'];
                        _LatController = locations.last.latitude;
                        _LngController = locations.last.longitude;

                        print(_addressController.text);
                        print(_LatController);
                        print(_LngController);
                      },
                      title: Text(_placesList[index]['description']),
                    );
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'address': _addressController.text,
                  'lat': _LatController,
                  'lng': _LngController,
                });
              },
              child: Text('Confirmar'),
            ),
          ],
        ),
      ),
    );
  }
}
