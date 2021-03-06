import 'package:flutter/material.dart';

import '../../../../constants.dart';
import '../../../../design_patterns/builder/burger.dart';
import 'burger_information_label.dart';

class BurgerInformationColumn extends StatelessWidget {
  final Burger burger;

  const BurgerInformationColumn({
    required this.burger,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const BurgerInformationLabel('Price'),
        Text(burger.getFormattedPrice()),
        const SizedBox(height: spaceM),
        const BurgerInformationLabel('Ingredients'),
        Text(
          burger.getFormattedIngredients(),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: spaceM),
        const BurgerInformationLabel('Allergens'),
        Text(
          burger.getFormattedAllergens(),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
