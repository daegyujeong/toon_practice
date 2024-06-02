class MovieDetailModel {
  final String title, about, genre, rating, thumb;
  static const String BASE_URL = 'https://image.tmdb.org/t/p/w500';

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['belongs_to_collection']?['name'] ??
            json['original_title'] ??
            "Not Available",
        about = json['overview'] ?? "Not Available",
        genre =
            (json['genres'] as List).map((genre) => genre['name']).join(', '),
        rating = (json['vote_average'] != null)
            ? json['vote_average'].toString()
            : 'Not Rated',
        thumb = (json['belongs_to_collection'] != null &&
                json['belongs_to_collection']['poster_path'] != null)
            ? BASE_URL + json['belongs_to_collection']['poster_path']
            : BASE_URL +
                (json['backdrop_path'] ?? ''); // null 체크 및 기본 포스터 경로 설정
}
