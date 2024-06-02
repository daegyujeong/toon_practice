import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toon_practice/models/webtoon_model.dart';

class ApiService {
  final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  final String today = "today";

  Future<List<WebtoonModel>> getTodaysToons() async {
    List<WebtoonModel> webtoonInstances = [];
    final url = Uri.parse('$baseUrl/$today');
    print(url);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      final List<dynamic> webtoons = jsonDecode(response
          .body); // list 로 된 dynamic 타입의 json 데이터를 받아오기 위해 List<dynamic>으로 받아옴
      for (var webtoon in webtoons) {
        final toon = WebtoonModel.fromJson(webtoon);
        print(toon);
        webtoonInstances.add(WebtoonModel.fromJson(webtoon));
      }
      return webtoonInstances;
    }
    throw Error();
  }
}
