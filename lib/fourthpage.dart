import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  int cycle = 0;
  List<Widget> _tiles = <Widget>[];
  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_to_photos),
          onPressed: () async {
            File image = await ImagePicker.pickImage(
                source: ImageSource.gallery, imageQuality: 50);

            setState(() {
              _tiles.add(
                _Example01Tile(image),
              );
              cycle == 0
                  ? _staggeredTiles.add(StaggeredTile.count(3, 3))
                  : cycle == 1
                      ? _staggeredTiles.add(StaggeredTile.count(2, 2))
                      : cycle == 2
                          ? _staggeredTiles.add(StaggeredTile.count(2, 2))
                          : cycle == 3
                              ? _staggeredTiles.add(StaggeredTile.count(1, 1))
                              : cycle == 4
                                  ? _staggeredTiles
                                      .add(StaggeredTile.count(1, 1))
                                  : cycle == 5
                                      ? _staggeredTiles
                                          .add(StaggeredTile.count(1, 1))
                                      : print("new");
              cycle == 5 ? cycle = 0 : cycle += 1;
              print(cycle);
            });
          },
        ),
        body: Container(
          child: _tiles.isEmpty
              ? Center(
                  child: Icon(
                    Icons.photo_album,
                  ),
                )
              : StaggeredGridView.count(
                  crossAxisCount: 5,
                  staggeredTiles: _staggeredTiles,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  children: _tiles,
                ),
        ),
      ),
    );
  }
}

class _Example01Tile extends StatelessWidget {
  const _Example01Tile(this.image);

  final File image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          onTap: () {},
          child: Image.file(
            image,
            fit: BoxFit.cover,
          )),
    );
  }
}
