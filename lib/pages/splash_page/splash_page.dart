import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utopia_recruitment_task/blocs/app_bloc/app_bloc.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';
import 'package:utopia_recruitment_task/pages/auth_page/auth_page.dart';
import 'package:utopia_recruitment_task/pages/home_page/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocListener<AppBloc, AppState>(
        listener: (_, state) async {
          if (state.status == AppStatus.authenticated) {
            await Future<void>.delayed(CustomTheme.splashDuration).then(
              (_) => Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              ),
            );
          } else if (state.status == AppStatus.unauthenticated) {
            await Future<void>.delayed(CustomTheme.splashDuration).then(
              (_) => Navigator.pushReplacement(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AuthPage(),
                ),
              ),
            );
          }
        },
        child: Scaffold(
          body: Container(
            padding: CustomTheme.pagePadding,
            decoration: BoxDecoration(
              gradient: CustomTheme.pageGradient,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: CustomTheme.bigSpacing * 2),
                  Text(
                    'WELCOME',
                    style: TextStyle(
                      color: CustomTheme.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 20.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
