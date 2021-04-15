import 'package:flutter/material.dart';
import 'package:http_request/service/http_service.dart';
import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String imgPath = 'https://image.tmdb.org/t/p/w500/';
  int moviesCount;
  List movies;
  HttpService service;


  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Popular Movies"),
        ),
        body: GridView.builder(
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, //jumlah grid
            childAspectRatio: 2, //jarak bawah
            crossAxisSpacing: 5.0,
            
          ),
          itemBuilder: (context, int position) {
            return GridTile(
              child: InkResponse(
                enableFeedback: true,
                child: ListTile(
                leading: Image.network(
                        imgPath + movies[position].posterPath,
                        fit: BoxFit.cover,),
                title: Text(movies[position].title),
                subtitle: Text(
                  'Rating = ' + movies[position].voteAverage.toString(),
                ),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                      Navigator.push(context, route);
                },
              ),
              )
            );
          },
        )
      );
  }
}
