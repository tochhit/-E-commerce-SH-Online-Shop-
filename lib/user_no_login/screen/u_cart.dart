import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';

class UCartScreen extends StatelessWidget {
  const UCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall)),
    );
  }
}


