import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemavillage/constants.dart';
import 'package:flutter/material.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key, required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.58,
            enlargeCenterPage: true,
            pageSnapping: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration:
                const Duration(seconds: 1)),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: SizedBox(
              height: 300,
              width: 200,
              child: Image.network(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                '${Constants.imagePath}${snapshot.data[itemIndex].posterPath}',
              ),
            ),
          );
        },
      ),
    );
  }
}

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key, required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 200,
                width: 150,
                child: Image.network(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  '${Constants.imagePath}${snapshot.data![index].posterPath}',
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

