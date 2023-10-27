import 'package:cinemavillage/api/api.dart';
import 'package:cinemavillage/models/movie.dart';
import 'package:cinemavillage/reusable_widgets/reusable_widgets_Main_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({super.key});

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {

  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;

  void initState(){
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRadefMovies();
    upcomingMovies = Api().getUpcomingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Top_bar(screenHeight, screenWidth),
      backgroundColor: Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Image.asset(
          'assets/images/Cinema_village_N1.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Trending Movies',
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
            ),
            const SizedBox(height: 15),

            SizedBox(
              child: FutureBuilder(
                future:  trendingMovies,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return TrendingSlider(snapshot: snapshot,);
                  }else{
                    return const Center(child:  CircularProgressIndicator());
                  }
                },
              ),
            ),
            
            const SizedBox(height: 15,),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Top rated movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
              ),),),
            SizedBox(height: 15,),
            
            SizedBox(
              child: FutureBuilder(
                future:  topRatedMovies,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return MoviesSlider(snapshot: snapshot,);
                  }else{
                    return const Center(child:  CircularProgressIndicator());
                  }
                },
              ),
            ),
            
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Upcoming movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 20,
              ),),),
            SizedBox(height: 15,),
            
            SizedBox(
              child: FutureBuilder(
                future:  upcomingMovies,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),
                    );
                  }else if(snapshot.hasData){
                    return MoviesSlider(snapshot: snapshot,);
                  }else{
                    return const Center(child:  CircularProgressIndicator());
                  }
                },
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

