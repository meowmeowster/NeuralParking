import 'dart:async';
import 'dart:convert';
import 'dart:wasm';
import 'dart:convert';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:http/http.dart' as http;

var data = null;
var dataTest = null;
final http.Client httpClient = new http.Client();
var long = 55.751244;
var lat = 37.618423;

class MyApp extends StatelessWidget {
  String description = '';
  Double latitude = null;
  Double longitude = null;
  @override
  Widget build(BuildContext context) {
    dataTest = _fetchPosts();
    print('helllooo');
    print(dataTest);
    return Scaffold(
      appBar: MyCustomAppBar(
        height: 150,
      ),
      body: Stack(children: [
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
        MapOsm(),
      ]),
    );
  }
}

class MapOsm extends StatefulWidget {
  @override
  _MapOsmState createState() => _MapOsmState();
}

class _MapOsmState extends State<MapOsm> {
  var _long = 55.751244;
  var _lat = 37.618423;

  void _updateCoords() {
    setState(() {
      _lat += 1;
      _long += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(long, lat),
        zoom: 13.0,
      ),
      layers: [
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(long, lat),
              builder: (ctx) => Container(
                child: Icon(Icons.add_location_sharp),
              ),
            ),
          ],
        ),
      ],
      children: <Widget>[
        TileLayerWidget(
            options: TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'])),
      ],
    );
  }
}

class Sample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: MyCustomAppBar(
          height: 150,
        ),
        body: Center(
          child: FlutterLogo(
            size: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;

  const MyCustomAppBar({
    Key key,
    @required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Color(0xFF0084F8),
          child: AppBar(
            backgroundColor: Color(0xFF0084F8),
            title: Container(
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  labelText: "",
                  contentPadding: EdgeInsets.all(0),
                ),
              ),
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    lat += 1;
                    long += 1;
                    _MapOsmState().setState(() {});
                  }),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class Post extends Equatable {
  final int id;
  final String title;
  final String body;

  Post({this.id, this.title, this.body}) : super([id, title, body]);

  @override
  String toString() => 'Post { id: $id }';
}

Future<List<dynamic>> _fetchPosts() async {
  final response =
      await httpClient.get('https://jsonplaceholder.typicode.com/posts');

  final data = jsonDecode(response.body);
  //dataTest = data;
  print("Response body: ${data}");

  return data;
}

// Future<String> getData() async {
//   var response = await http.get(
//     Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
//   );
//   data = response.body;
//   print(response.headers);
//   return data;
// }

// void setState(Null Function() param) {}

class User {
  final int id;
  final String userId;
  final String title;

  User({this.id, this.userId, this.title});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], userId: json['userId'], title: json['title']);
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PopupController _popupController = PopupController();

  List<Marker> markers;
  int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  @override
  void initState() {
    pointIndex = 0;
    markers = [
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: points[pointIndex],
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3498, -6.2603),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(53.3488, -6.2613),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(48.8566, 2.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
      Marker(
        anchorPos: AnchorPos.align(AnchorAlign.center),
        height: 30,
        width: 30,
        point: LatLng(49.8566, 3.3522),
        builder: (ctx) => Icon(Icons.pin_drop),
      ),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          pointIndex++;
          if (pointIndex >= points.length) {
            pointIndex = 0;
          }
          setState(() {
            markers[0] = Marker(
              point: points[pointIndex],
              anchorPos: AnchorPos.align(AnchorAlign.center),
              height: 30,
              width: 30,
              builder: (ctx) => Icon(Icons.pin_drop),
            );

            // one of this
            markers = List.from(markers);
            // markers = [...markers];
            // markers = []..addAll(markers);
          });
        },
      ),
      body: FlutterMap(
        options: MapOptions(
          center: points[0],
          zoom: 5,
          plugins: [
            MarkerClusterPlugin(),
          ],
          onTap: (_) => _popupController
              .hidePopup(), // Hide popup when the map is tapped.
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            disableClusteringAtZoom: 6,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            popupOptions: PopupOptions(
                popupSnap: PopupSnap.top,
                popupController: _popupController,
                popupBuilder: (_, marker) => Container(
                      width: 200,
                      height: 100,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () => debugPrint("Popup tap!"),
                        child: Text(
                          "Container popup for marker at ${marker.point}",
                        ),
                      ),
                    )),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }
}
