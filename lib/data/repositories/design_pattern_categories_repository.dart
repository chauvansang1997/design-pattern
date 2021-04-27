import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../../constants.dart';
import '../models/design_pattern_category.dart';

class DesignPatternCategoriesRepository {
  Future<List<DesignPatternCategory>> get() async {
    final menuJson = await rootBundle.loadString(designPatternsJsonPath);
    final designPatternCategoryJsonList = json.decode(menuJson) as List;
    final mainMenuSections = designPatternCategoryJsonList
        .map((categoryJson) => DesignPatternCategory.fromJson(
            categoryJson as Map<String, dynamic>))
        .toList();

    return mainMenuSections;
  }
}
