import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app1/classes/photo.dart';
import 'package:my_app1/cubit/photoes_cubit.dart';

class Gallery extends StatefulWidget {
  Gallery({Key key}) : super(key: key);

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  final PhotoesCubit photoCubit =
      PhotoesCubit(PhotoSQLDecorator(PhotoesRead()));
  int cycle = 0;
  List<String> photoes = [];

  List<Widget> _tiles = <Widget>[];

  List<StaggeredTile> _staggeredTiles = <StaggeredTile>[];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => photoCubit,
      child: BlocBuilder(
          cubit: photoCubit,
          builder: (BuildContext context, state) {
            if (state is PhotoesInitial) {
              photoCubit.load();
              final spinkit = SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              );
              return Center(child: spinkit);
            }
            if (state is PhotoesLoading) {
              final spinkit = SpinKitRotatingCircle(
                color: Colors.blue,
                size: 50.0,
              );
              return Center(child: spinkit);
            }
            if (state is PhotoesLoaded) {
              photoes = state.photoes;
              print('here' + photoes.length.toString());
              return buildLoaded(photoes);
            }
            return Container();
          }),
    );
    //Container(
    //  child: Scaffold(
    //    floatingActionButton: FloatingActionButton(
    //      child: Icon(Icons.add_to_photos),
    //      onPressed: () async {
    //        File image = await ImagePicker.pickImage(
    //            source: ImageSource.gallery, imageQuality: 50);
//
    //        setState(() {
    //          _tiles.add(
    //            _ImageTile(image),
    //          );
    //          cycle == 0
    //              ? _staggeredTiles.add(StaggeredTile.count(3, 3))
    //              : cycle == 1
    //                  ? _staggeredTiles.add(StaggeredTile.count(2, 2))
    //                  : cycle == 2
    //                      ? _staggeredTiles.add(StaggeredTile.count(2, 2))
    //                      : cycle == 3
    //                          ? _staggeredTiles
    //                              .add(StaggeredTile.count(1, 1))
    //                          : cycle == 4
    //                              ? _staggeredTiles
    //                                  .add(StaggeredTile.count(1, 1))
    //                              : cycle == 5
    //                                  ? _staggeredTiles
    //                                      .add(StaggeredTile.count(1, 1))
    //                                  : print("new");
    //          cycle == 5 ? cycle = 0 : cycle += 1;
    //          print(cycle);
    //        });
    //      },
    //    ),
    //    body: Container(
    //      child: _tiles.isEmpty
    //          ? Center(
    //              child: Icon(
    //                Icons.photo_album,
    //              ),
    //            )
    //          : StaggeredGridView.count(
    //              crossAxisCount: 5,
    //              staggeredTiles: _staggeredTiles,
    //              mainAxisSpacing: 5,
    //              crossAxisSpacing: 5,
    //              children: _tiles,
    //            ),
    //    ),
    //  ),
    //),
  }
}

Widget buildLoaded(List<String> photoes) {
  List<StaggeredTile> _preLoadStaggeredTiles = <StaggeredTile>[];
  List<Widget> _preLoadTiles = [];
  int incycle = 0;
  for (String photo in photoes) {
    _preLoadTiles.add(_URLImageTile(photo));
    incycle == 0
        ? _preLoadStaggeredTiles.add(StaggeredTile.count(3, 3))
        : incycle == 1
            ? _preLoadStaggeredTiles.add(StaggeredTile.count(2, 2))
            : incycle == 2
                ? _preLoadStaggeredTiles.add(StaggeredTile.count(2, 2))
                : incycle == 3
                    ? _preLoadStaggeredTiles.add(StaggeredTile.count(1, 1))
                    : incycle == 4
                        ? _preLoadStaggeredTiles.add(StaggeredTile.count(1, 1))
                        : incycle == 5
                            ? _preLoadStaggeredTiles
                                .add(StaggeredTile.count(1, 1))
                            : print("new");
    incycle == 5 ? incycle = 0 : incycle += 1;
  }
  print(_preLoadTiles.length);
  return Scaffold(
    body: Container(
      child: StaggeredGridView.count(
        crossAxisCount: 5,
        staggeredTiles: _preLoadStaggeredTiles,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: _preLoadTiles,
      ),
    ),
  );
}

class _preLoadstaggeredTiles {}

class _ImageTile extends StatelessWidget {
  const _ImageTile(this.image);

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

class _URLImageTile extends StatelessWidget {
  const _URLImageTile(this.image);
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: Image.network(
          image,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
