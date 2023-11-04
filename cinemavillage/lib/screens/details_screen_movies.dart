import 'package:cinemavillage/constants.dart';
import 'package:cinemavillage/models/movie.dart';
import 'package:cinemavillage/reusable_widgets/BackButton.dart';
import 'package:cinemavillage/reusable_widgets/GenreSelector.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinemavillage/screens/Main_page.dart';

class DetailsScreenMovies extends StatelessWidget {
  const DetailsScreenMovies({
    super.key,
    required this.movie,
  });
  final Movie movie;

  // ignore: non_constant_identifier_names, prefer_const_constructors

  @override
  Widget build(BuildContext context) {
    int? UserType = getUserType();
    String title = movie.title;
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
              title: Text(movie.title,
                  style: GoogleFonts.aBeeZee(
                      fontSize: 17, fontWeight: FontWeight.w600)),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  '${Constants.imagePath}${movie.backDropPath}',
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
                        for (int i = 0; i < movie.genreIds.length; i++)
                          Text(getGenreNameById(movie.genreIds[i])),
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
                          '  ${movie.releaseDate}     ',
                          style: GoogleFonts.roboto(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.star,
                        ),
                        Text(
                          '  ${movie.voteAverage.toStringAsFixed(1)}',
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
                    movie.overview,
                    style: GoogleFonts.roboto(
                        fontSize: 17, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
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
