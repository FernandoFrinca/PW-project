import 'package:cinemavillage/models/movie_model_OMDb.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widget.dart';
import 'package:cinemavillage/screens/Main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cinemavillage/reusable_widgets/BackButton.dart';

class MovieDetailsScreen_OMDb extends StatelessWidget {
  final MovieModel movieDetails;

  MovieDetailsScreen_OMDb(this.movieDetails);

  @override
  Widget build(BuildContext context) {
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
              title: Text(movieDetails.title ?? 'No title',
                  style: GoogleFonts.aBeeZee(
                      fontSize: 17, fontWeight: FontWeight.w600)),
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
                child: Image.network(
                  movieDetails.poster,
                  filterQuality: FilterQuality.high,
                  alignment: Alignment.topCenter,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                movieDetails.year ?? 'N/A',
                                style: GoogleFonts.roboto(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            movieDetails.genre,
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ]),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0;
                          i < movieDetails.ratings.length && i < 3;
                          i++)
                        Column(children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 3 - 10,
                              child: Text(
                                movieDetails.ratings[i]['Value'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                          Container(
                              width: MediaQuery.of(context).size.width / 3 - 10,
                              child: Text(
                                movieDetails.ratings[i]['Source'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w200,
                                ),
                              )),
                        ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text('Overview',
                        style: GoogleFonts.openSans(
                            fontSize: 25, fontWeight: FontWeight.w800)),
                    const SizedBox(
                      height: 15,
                    ),
                    if (userType == 1)
                      favoriteButton(
                        name: movieDetails.title,
                      ),
                      
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    movieDetails.plot ?? 'No plot',
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
