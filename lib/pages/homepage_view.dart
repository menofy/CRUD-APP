import 'package:crud_app/core/routes/routes_name.dart';
import 'package:crud_app/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                text: 'Get All posts',
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.getAll);
                },
              ),
              AppButton(
                text: 'add post',
                onPressed: () {
                  Navigator.pushNamed(context, RoutesName.create);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
