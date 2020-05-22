import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:great_places/screens/places_detail_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
              },
            )
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: Provider.of<GreatPlaces>(context, listen: false)
                .fetchAndSetPlaces(),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Consumer<GreatPlaces>(
                        child: Center(
                          child: Text('No places yet'),
                        ),
                        builder: (ctx, greatPlaces, ch) =>
                            greatPlaces.items.length <= 0
                                ? ch
                                : ListView.builder(
                                    itemCount: greatPlaces.items.length,
                                    itemBuilder: (ctx, i) => ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          greatPlaces.items[i].image,
                                        ),
                                      ),
                                      title: Text(greatPlaces.items[i].title),
                                      subtitle: Text(greatPlaces.items[i].location.address),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            PlaceDetailScreen.routeName,
                                          arguments: greatPlaces.items[i].id,
                                        );
                                      },
                                    ),
                                  ),
                      ),
          ),
        ));
  }
}
