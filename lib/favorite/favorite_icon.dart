import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unloack/favorite/favorite_functions.dart';

ValueNotifier<List<String>> allFavoriteIds = ValueNotifier<List<String>>([]);

class IconFavorite extends StatelessWidget {
  const IconFavorite(
      {Key? key,
      required this.destinationId,
      this.size = 30,
      this.color = Colors.red})
      : super(key: key);

  final String destinationId;
  final double size;
  final Color color;

  void favoriteChanger(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context, listen: false);
    if (favoriteModel.favorites.contains(destinationId)) {
      favoriteModel.removeFavorite(destinationId);
    } else {
      favoriteModel.addFavorite(destinationId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteModel = Provider.of<FavoriteModel>(context);

    return InkWell(
      onTap: () => favoriteChanger(context),
      child: favoriteModel.favorites.contains(destinationId)
          ? Icon(
              Icons.favorite,
              size: size,
              color: color,
            )
          : Icon(
              Icons.favorite_border,
              size: size,
              color: Colors.white,
            ),
    );
  }
}
