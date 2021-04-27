import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/design_patterns/flyweight/shapes/circle.dart';

import '../../../design_patterns/flyweight/ipositioned_shape.dart';
import '../../../design_patterns/flyweight/shape_factory.dart';
import '../../../design_patterns/flyweight/shape_flyweight_factory.dart';
import '../../../design_patterns/flyweight/shape_type.dart';
import 'positioned_shape_wrapper.dart';

class FlyweightExample extends StatefulWidget {
  @override
  _FlyweightExampleState createState() => _FlyweightExampleState();
}

class _FlyweightExampleState extends State<FlyweightExample> {
  static const int shapesCount = 1000;

  final shapeFactory = const ShapeFactory();

  late final ShapeFlyweightFactory _shapeFlyweightFactory;
  late List<IPositionedShape> _shapesList;

  int _shapeInstancesCount = 0;

  @override
  void initState() {
    super.initState();

    _shapeFlyweightFactory = ShapeFlyweightFactory(
      shapeFactory: shapeFactory,
    );

    _buildShapesList();
  }

  void _buildShapesList() {
    var customShapeCount = 0;
    _shapesList = <IPositionedShape>[];

    for (var i = 0; i < shapesCount; i++) {
      final shapeType = _getRandomShapeType();
      final shape = _shapeFlyweightFactory.getShape(shapeType);

      _shapesList.add(shape);
    }

    for (var i = 0; i < 10; i++) {
      final shape = Circle(
        color: Colors.yellow.withOpacity(0.2),
        diameter: 100.0,
      );
      customShapeCount++;
      _shapesList.add(shape);
    }

    setState(() {
      _shapeInstancesCount =
          _shapeFlyweightFactory.getShapeInstancesCount() + customShapeCount;
    });
  }

  ShapeType _getRandomShapeType() {
    const values = ShapeType.values;

    return values[Random().nextInt(values.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        for (var shape in _shapesList)
          PositionedShapeWrapper(
            shape: shape,
          ),
        Center(
          child: Text(
            'Shape instances count: $_shapeInstancesCount',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
