import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/presentation/blocs/loading/loading_cubit.dart';
import 'package:movie_app/presentation/journeys/loading/loading_circle.dart';
import 'package:movie_app/presentation/themes/app_color.dart';

class LoadingScreen extends StatelessWidget {
  final Widget screen;
  const LoadingScreen({Key key, @required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, bool>(
      builder: (context, showLoading) {
        return Stack(
          fit: StackFit.expand,
          children: [
            screen,
            if (showLoading)
              Container(
                decoration:
                    BoxDecoration(color: AppColor.vulcan.withOpacity(0.8)),
                child: Center(
                  child: LoadingCircle(
                    size: Sizes.dimen_200.w,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
