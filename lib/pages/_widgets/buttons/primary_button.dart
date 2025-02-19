import 'package:flutter/material.dart';
import 'package:utopia_recruitment_task/config/custom_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.title,
    this.active = true,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final bool active;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 55.0,
        width: double.infinity,
        child: Opacity(
          opacity: active ? 1.0 : .5,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(
                CustomTheme.darkBlue,
              ),
              overlayColor: MaterialStateProperty.all(
                CustomTheme.white.withOpacity(.2),
              ),
              foregroundColor: MaterialStateProperty.all(
                CustomTheme.white,
              ),
            ),
            onPressed: onPressed,
            child: Text(
              title.toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                letterSpacing: 5,
              ),
            ),
          ),
        ),
      );
}
