import 'dart:convert';
import 'package:http/http.dart' as http;

class Photo {
  final String stringURL;
  Photo(this.stringURL);
  Photo.fromJson(Map<String, dynamic> json)
      : this.stringURL = json['largeImageURL'];
}

class PhotoesRead {
  Future<List<Photo>> getPhotoes() async {
    try {
      var data = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=19193969-87191e5db266905fe8936d565&q=small+animals&image_type=photo&per_page=18'));
      if (data.statusCode != 200) {
        return [];
      }

      dynamic jsonPhotoes = jsonDecode(data.body);
      print(jsonPhotoes);
      if (jsonPhotoes['Response'] == 'False') {
        return [];
      }
      List<Photo> photoes = [];
      for (dynamic photo in jsonPhotoes['hits']) {
        photoes.add(Photo.fromJson(photo));
      }

      return photoes;
    } catch (e) {
      print(e);
      // If encountering an error, return [].
      return [];
    }
  }
}
