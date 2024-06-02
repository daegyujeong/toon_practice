import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toon_practice/models/movie_detail_model.dart';
import 'package:toon_practice/models/movie_model.dart';
import 'package:toon_practice/models/webtoon_detail_model.dart';
import 'package:toon_practice/models/webtoon_model.dart';
import 'package:toon_practice/models/webtoon_episode_model.dart';

class ApiService {
  static const String baseUrl =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";
  static const String baseUrl2 = "https://movies-api.nomadcoders.workers.dev";
  static const String popular = "popular";
  static const String nowPlaying = "now-playing";
  static const String upcoming = "coming-soon";

  static Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
      final List<dynamic> webtoons = jsonDecode(response
          .body); // list 로 된 dynamic 타입의 json 데이터를 받아오기 위해 List<dynamic>으로 받아옴
      for (var webtoon in webtoons) {
        final instance = WebtoonModel.fromJson(webtoon);
        webtoonInstances.add(instance);
      }
      return webtoonInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getPopularMovie() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl2/$popular');
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body)['results'];
// list 로 된 dynamic 타입의 json 데이터를 받아오기 위해 List<dynamic>으로 받아옴
      for (var webtoon in webtoons) {
        // print(webtoon['original_title']);
        final instance = MovieModel.fromJson(webtoon);
        // print(instance);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl2/$nowPlaying');
    print("NowPlayingMovies $url");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getUpcomingMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$baseUrl2/$upcoming');
    // print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> movies = jsonDecode(response.body)['results'];
      for (var movie in movies) {
        final instance = MovieModel.fromJson(movie);
        movieInstances.add(instance);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(String id) async {
    final url = Uri.parse("$baseUrl2/movie?id=$id");
    final response = await http.get(url);
    print(url);
    if (response.statusCode == 200) {
      print(jsonDecode(response.body)['overview']);

      final movie = MovieDetailModel.fromJson(jsonDecode(response.body));
      print("movie: $movie OK");
      return movie;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisodeModel>> getLatestEpisodesById(
      String id) async {
    List<WebtoonEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
