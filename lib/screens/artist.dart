import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:practico_api/screens/album_list.dart';
import 'package:practico_api/screens/song_list.dart';
import 'dart:convert' as convert;

import 'package:practico_api/widgets/artist_card.dart';

class Artist extends StatefulWidget {
  const Artist({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ArtistState();
  }
}

class _ArtistState extends State<Artist> {
  var artistResponse = {};

  Future<void> fetchArtist() async {
    final response =
        await http.get(Uri.parse('https://api.deezer.com/artist/12246'));

    if (response.statusCode == 200) {
      final data = convert.jsonDecode(response.body);
      artistResponse = data;

      setState(() {
        artistResponse;
      });
    } else {
      throw Exception('Failed to load artist.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchArtist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Swift Music',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: artistResponse.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ArtistCard(
                  name: artistResponse['name'],
                  imageUrl: artistResponse['picture_xl'],
                  fans: artistResponse['nb_fan'],
                  releases: artistResponse['nb_album'],
                ),
                const SizedBox(
                  height: 20,
                ),
                goToAlbums(),
                goToSongs(),
              ],
            ),
    );
  }

  SizedBox goToSongs() {
    return SizedBox(
      width: 300,
      child: Card(
        color: Colors.indigo.shade700.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Go To Top Songs',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SongList()),
                    );
                  },
                  child: const Icon(Icons.play_arrow_outlined)),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox goToAlbums() {
    return SizedBox(
      width: 300,
      child: Card(
        color: Colors.indigo.shade700.withOpacity(0.8),
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                'Go To Albums',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 16,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AlbumList()),
                    );
                  },
                  child: const Icon(Icons.play_arrow_outlined)),
            ],
          ),
        ),
      ),
    );
  }
}
