import 'package:flutter/widgets.dart';

import 'tools.dart';

class EmptyData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Image(image: AssetImage(Gambar('data_null.png')),),
    );
  }
}
