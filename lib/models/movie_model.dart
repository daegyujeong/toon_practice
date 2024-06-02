class MovieModel {
  final String title, thumb, id;
  static const String BASE_URL = 'https://image.tmdb.org/t/p/w500';
// API로 받아온 데이터를 WebtoonModel로 변환하기 위한 코드
  MovieModel.fromJson(Map<String, dynamic> json) // constructor for WebtoonModel
      : title = json['original_title'],
        thumb = BASE_URL + json['backdrop_path'],
        id = json['id'].toString();
}
