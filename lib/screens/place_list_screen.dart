import 'package:flutter/material.dart';
import 'package:location_app/Providers/place.dart';
import 'package:location_app/models/places.dart';
import 'package:location_app/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlaceListScreen extends StatelessWidget {
  const PlaceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Great Places"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => AddPlaceScreen(),
              ),
            ),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false)
            .fetchAllPlacesAndSet(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<PlaceProvider>(
                child: Center(
                    child: Text(
                        "No places Added yet!! Click + above to add some!")),
                builder: (BuildContext ctx, greatPlaces, ch) =>
                    greatPlaces.places.length == 0
                        ? ch!
                        : ListView.builder(
                            itemCount: greatPlaces.places.length,
                            itemBuilder: (ctx, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: FileImage(
                                    greatPlaces.places[index].image,
                                  ),
                                ),
                                title: Text(greatPlaces.places[index].title),
                                onTap: () {
                                  //Go to detail screen
                                },
                              );
                            },
                          ),
              ),
      ),
    );
  }
}
