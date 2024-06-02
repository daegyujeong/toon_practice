class WebtoonModel {
  final String title, thumb, id;
// API로 받아온 데이터를 WebtoonModel로 변환하기 위한 코드
  WebtoonModel.fromJson(
      Map<String, dynamic> json) // constructor for WebtoonModel
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
