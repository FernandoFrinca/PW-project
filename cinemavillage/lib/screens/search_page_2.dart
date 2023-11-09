import 'package:cinemavillage/models/movie_model_OMDb.dart';
import 'package:cinemavillage/screens/details_screen_movies_OMDb.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MovieSearch(),
    );
  }
}

class MovieSearch extends StatefulWidget {
  @override
  _MovieSearchState createState() => _MovieSearchState();
}

class _MovieSearchState extends State<MovieSearch> {
  String query = "";
  List<Map<String, dynamic>> suggestions = [];
  Map<String, dynamic>? selectedMovie;

  final debouncer = Debouncer(milliseconds: 500); 

  Future<void> fetchSuggestions(String query) async {
    final apiKey = "67ae677b"; 
    final apiUrl = Uri.parse("http://www.omdbapi.com/?s=$query&apikey=$apiKey");

    final response = await http.get(apiUrl);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Search'] != null) {
        setState(() {
          suggestions = List<Map<String, dynamic>>.from(data['Search']);
        });
      } else {
        suggestions = [];
      }
    }
  }

void onSuggestionTapped(Map<String, dynamic> movie) async {
  final imdbID = movie['imdbID'];
  final apiKey = "67ae677b";
  final apiUrl = Uri.parse("http://www.omdbapi.com/?i=$imdbID&apikey=$apiKey");

  final response = await http.get(apiUrl);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final movieModel = MovieModel.fromJson(data);
    
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieDetailsScreen_OMDb(movieModel),
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              onChanged: (text) {
                debouncer.run(() {
                  fetchSuggestions(text);
                });
              },
              decoration: InputDecoration(labelText: "Enter a movie title"),
            ),
          ),
          if (suggestions.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final title = suggestions[index]['Title'];
                  return ListTile(
                    title: Text(title),
                    onTap: () => onSuggestionTapped(suggestions[index]),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}


class Debouncer {
  final int milliseconds;
  Function? action;

  Debouncer({required this.milliseconds});

  void run(Function action) {
    this.action = action;
    Future.delayed(Duration(milliseconds: milliseconds), () {
      this.action?.call();
      this.action = null;
    });
  }
}