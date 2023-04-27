import 'package:flutter/material.dart';
import '../model/model_element.dart';

class ElementItem extends StatelessWidget {
  const ElementItem({Key? key, required this.element}) : super(key: key);
  final ModelElement element;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: Text(element.name),
        ),
      ),
    );
  }
}
