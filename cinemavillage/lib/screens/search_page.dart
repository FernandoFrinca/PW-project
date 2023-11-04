import 'package:cinemavillage/models/movie.dart';
import 'package:cinemavillage/models/movie_model_2.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Search_Screen extends StatefulWidget {
  const Search_Screen({super.key});
  @override
  State<Search_Screen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<Search_Screen> {
  static List<MovieModel> main_movie_list = [
    MovieModel(
        "Jocurile foamei: Balada șerpilor și a păsărilor cântătoare (2023)",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Fantastic Beasts: The Secrets of Dumbledore",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Flavors of Youth",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Unidentified",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "The Boy Who Harnessed the Wind",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "The Dark Knight Rises",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Words Bubble Up Like Soda Pop",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Fifty Shades Freed",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Kingsglaive: Final Fantasy XV",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
    MovieModel(
        "Murder Mystery 2",
        1999,
        "https://static.posters.cz/image/1300/postere/stranger-things-summer-of-85-i76122.jpg",
        9.5),
  ];

  List<MovieModel> display_list = List.from(main_movie_list);

  void updateList(String value) {
    //functia asta va filtra lista noastra
    setState(() {
      display_list = main_movie_list
          .where((element) =>
              element.movie_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 25, 25, 25),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Search for a Movie",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 133, 132, 126),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "ex: The Dark Knight",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color.fromARGB(255, 255, 254, 254))),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                        "No result found",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          display_list[index].movie_title!,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${display_list[index].movie_release_year!}',
                          style: TextStyle(color: Colors.white70),
                        ),
                        trailing: Text(
                          "${display_list[index].rating}",
                          style: TextStyle(color: Colors.amber),
                        ),
                        leading: Image.network(
                            display_list[index].movie_poster_url!),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
