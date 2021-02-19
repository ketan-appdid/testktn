import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:permission/permission.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String url = 'https://www.themealdb.com/api/json/v1/1/random.php';
  Response response;
  Stream _stream;
  StreamController _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;
    getRecipes();
  }

  getRecipes() async {
    _streamController.add("waiting");
    response = await get(url);
    _streamController.add(jsonDecode(response.body));
  }
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Random Recipe Generator',
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return getRecipes();
        },
        child: Container(
          // color: Colors.yellowAccent,
          child: StreamBuilder(
            stream: _stream,
            builder: (BuildContext ctx, AsyncSnapshot snapshot) {
              if (snapshot.data == "waiting") {
                return Center(
                  child: Text('Loading a new recipe..efeffevf.'),
                );
              }
              String videoId = YoutubePlayer.convertUrlToId(snapshot.data['meals'][0]['strYoutube']);
              print(videoId);
              YoutubePlayerController _controller = YoutubePlayerController(
                  initialVideoId: videoId,
                  flags: YoutubePlayerFlags(
                    autoPlay: false,
                    mute: false,
                  )
              );
              return Center(
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int index) {
                    String videoId;
                    return Center(
                      child: ListBody(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin:
                                EdgeInsets.only(top: 8, right: 10, left: 10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/loading.gif',
                                image: snapshot.data['meals'][0]
                                    ['strMealThumb'],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data['meals'][0]['strMeal'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Container(
                                      child: Text(
                                        "( " +
                                            snapshot.data['meals'][0]
                                                ['strCategory'] +
                                            " )",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    snapshot.data['meals'][0]['strCategory'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Origin: ${snapshot.data['meals'][0]['strArea']}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Container(
                              margin: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text(
                                          'Ingredients:',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure1'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure1'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient1'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient1'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient1'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure1'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure2'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure2'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient2'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient2'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient2'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure2'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure3'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure3'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient3'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient3'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient3'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure3'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure4'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure4'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient4'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient4'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient4'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure4'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure5'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure5'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient5'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient5'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient5'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure5'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure6'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure6'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient6'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient6'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient6'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure6'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure7'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure7'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient7'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient7'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient7'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure7'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure8'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure8'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient8'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient8'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient8'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure8'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure9'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure9'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient9'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient9'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient9'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure9'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure10'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure10'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient10'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient10'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient10'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure10'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure11'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure11'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient11'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient11'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient11'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure11'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure12'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure12'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient12'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient12'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient12'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure12'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure13'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure13'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient13'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient13'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient13'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure13'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure14'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure14'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient14'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient14'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient14'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure14'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure15'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure15'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient15'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient15'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient15'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure15'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure16'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure16'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient16'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient16'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient16'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure16'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure17'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure17'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient17'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient17'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient17'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure17'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure18'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure18'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient18'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient18'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient18'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure18'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure19'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure19'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient19'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient19'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient19'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure19'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                      ((snapshot.data['meals'][0]
                                                          ['strMeasure20'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strMeasure20'] !=
                                                      '') &&
                                              (snapshot.data['meals'][0]
                                                          ['strIngredient20'] !=
                                                      null &&
                                                  snapshot.data['meals'][0]
                                                          ['strIngredient20'] !=
                                                      ''))
                                          ? Text(
                                              snapshot.data['meals'][0]
                                                      ['strIngredient20'] +
                                                  " (" +
                                                  snapshot.data['meals'][0]
                                                      ['strMeasure20'] +
                                                  ")",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  letterSpacing: 0.5),
                                            )
                                          : Container(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Instructions:',
                                          style: TextStyle(
                                            fontSize: 18,
                                            // fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              snapshot.data['meals'][0]
                                                  ['strInstructions'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: YoutubePlayer(
                                controller: _controller,
                                showVideoProgressIndicator: true,
                                progressColors: ProgressBarColors(
                                  playedColor: Colors.amber,
                                  handleColor: Colors.amberAccent,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
