import 'package:cinemavillage/constants.dart';
import 'package:cinemavillage/models/movie.dart';
import 'package:cinemavillage/reusable_widgets/BackButton.dart';
import 'package:cinemavillage/reusable_widgets/GenreSelector.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinemavillage/screens/Main_page.dart';

class DetailsScreenMovies extends StatefulWidget {
  final Movie movies;
  const DetailsScreenMovies({Key? key, required this.movies}) : super(key: key);
  @override
  State<DetailsScreenMovies> createState() => _DetailsScreenMovie();
}

class _DetailsScreenMovie extends State<DetailsScreenMovies> {
  Movie? movie;
  List coms = [];
  String? mName;
  Map? rating;
  double _rating = 0;
  List<String> comments = [];
  int _isAdmin = 0;
  TextEditingController _textEditingController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? username;
  String? _uID;

  Future<void> _createDoc() async {
    String docId = widget.movies.title;
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection("movies").doc(docId).get();

    if (!docSnapshot.exists) {
      await FirebaseFirestore.instance.collection("movies").doc(docId).set({
        'movieName': widget.movies.title,
        'userComent': coms,
      });
    } else {}
  }

  Future _getDataFromDatabaseUser() async {
    print(widget.movies.title);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          username = snapshot.data()!["username"];
          _isAdmin = snapshot.data()!["isAdmin"];
          _uID = snapshot.data()!["uID"];
        });
      }
    });
    await FirebaseFirestore.instance
        .collection("movies")
        .doc(widget.movies.title)
        .get()
        .then((snapshot) async {
      if (snapshot.exists) {
        setState(() {
          coms = snapshot.data()!["userComent"];
          mName = snapshot.data()!["movieName"];
          var ratings = snapshot.data()!["ratings"];
          if (ratings != null && ratings[_uID] != null) {
            _rating = ratings[_uID].toDouble();
          } else {
            _rating = 0;
          }
        });
      }
    });
    comments = await coms.map((element) => element.toString()).toList();
  }

  @override
  void initState() {
    super.initState();
    _createDoc();
    _getDataFromDatabaseUser();
  }

  @override
  Widget build(BuildContext context) {
    movie = widget.movies;
    int? UserType = getUserType();
    String title = movie!.title;
    favoriteButton favButton;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackButton1(),
            backgroundColor: Color.fromARGB(255, 26, 26, 26),
            expandedHeight: 300,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie!.title,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 17, fontWeight: FontWeight.w600)),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${movie!.backDropPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (int i = 0; i < movie!.genreIds.length; i++)
                          Text(getGenreNameById(movie!.genreIds[i])),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                        ),
                        Text(
                          '  ${movie!.releaseDate}     ',
                          style: GoogleFonts.roboto(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.star,
                        ),
                        Text(
                          '  ${movie!.voteAverage.toStringAsFixed(1)}',
                          style: GoogleFonts.roboto(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (userType == 1)
                          favoriteButton(
                            name: title,
                          ),
                      ],
                    ),
                  ),
                  if (userType == 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          initialRating: _rating,
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) async {
                            setState(() {
                              _rating = rating;
                            });
                            // Save the rating to the 'movies' collection in Firebase
                            await FirebaseFirestore.instance
                                .collection('movies')
                                .doc(mName)
                                .set(
                              {
                                'ratings': {
                                  _uID: _rating,
                                },
                              },
                              SetOptions(merge: true),
                            );
                          },
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Overview',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    movie!.overview,
                    style: GoogleFonts.roboto(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        "Comments:",
                        style: GoogleFonts.openSans(
                            fontSize: 25, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  if (userType == 1)
                  Column(children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            hintText: 'Type here...',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (userType != 0) {
                            String inputText = _textEditingController.text;
                            if (inputText != "") {
                              setState(() {
                                comments.add("${username!}\n\n$inputText");
                              });
                              FirebaseFirestore.instance
                                  .collection("movies")
                                  .doc(title)
                                  .update({
                                'userComent': comments,
                              });
                            }
                            _textEditingController.clear();
                          } else {
                            _textEditingController.clear();
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ],),
                  CommentsList(
                    comments: comments,
                    onDelete: (index) {
                      String commentToDelete = comments[index];
                      setState(() {
                        comments.removeAt(index);
                      });
                      FirebaseFirestore.instance
                          .collection("movies")
                          .doc(title)
                          .update({
                        'userComent': FieldValue.arrayRemove([commentToDelete]),
                      });
                    },
                    isAdmin: _isAdmin,
                    userType: userType!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
