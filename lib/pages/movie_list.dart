import 'package:flutter/material.dart';
import 'package:tugas9/service/http_service.dart';
import 'package:tugas9/pages/movie_detail.dart';

class MovieList extends StatefulWidget{
  @override
  _MovieListState createState() => _MovieListState();
}
 
class _MovieListState extends State<MovieList>{
  int moviesCount;
  List movies;
  HttpService service;
  String imgPath = 'https://image.tmdb.org/t/p/w500/'; //untuk menambah gambar

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState(){
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
      body: GridView.builder( //menampilkan gambar dalam bentuk grid
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        padding: const EdgeInsets.all(20),

        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 20.0,
        ),
        itemBuilder: (context, int position){
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network( //menampilkan gambar pada halaman utama
                imgPath + movies[position].posterPath,
                fit: BoxFit.cover,
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetail(movies[position])
                );
                Navigator.push(context, route);
              },
            ),
          );
        },
      )
    );
  }
}