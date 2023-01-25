import 'package:feed_hub/Utils/colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key, this.onPressed, this.buttonText})
      : super(key: key);
  final void Function()? onPressed;
  final String? buttonText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            buttonText!,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: AppColors.whiteColor,
                ),
          ),
        ),
      ),
    );
  }
}
