import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:toon_practice/screens/detail_screen.dart';

Future<Image> fetchImage(String url) async {
  final response = await http.get(
    Uri.parse(url),
  );

  if (response.statusCode == 200) {
    return Image.network(url);
  } else {
    // return Image.network(url);
    throw Exception('Failed to load image');
  }
}

class Webtoon extends StatelessWidget {
  final String title, thumb, id, listkind;

  const Webtoon({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
    required this.listkind,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              thumb: thumb,
              id: id,
              listkind: listkind,
            ),
            fullscreenDialog: true,
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: '$id-$listkind',
            child: FutureBuilder(
              future: fetchImage(thumb),
              builder: (context, AsyncSnapshot<Image> imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (imageSnapshot.hasError) {
                  return Text('Error: ${imageSnapshot.error}');
                } else {
                  return Container(
                    width: 250,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 15,
                          offset: const Offset(10, 10),
                          color: Colors.black.withOpacity(0.3),
                        )
                      ],
                    ),
                    child: imageSnapshot.data!,
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
