import 'package:flutter/material.dart';
import 'package:movie_app/common/constants/size_constants.dart';
import 'package:movie_app/common/constants/translation_constants.dart';
import 'package:movie_app/common/extensions/size_extensions.dart';
import 'package:movie_app/common/extensions/string_extensions.dart';
import 'package:movie_app/domain/entities/app_error.dart';
import 'package:movie_app/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:movie_app/presentation/widgets/button.dart';
import 'package:wiredash/wiredash.dart';

class CarouselLoadErrorWidget extends StatelessWidget {

  final AppErrorType errorType;
  final MovieCarouselBloc bloc;

  const CarouselLoadErrorWidget({
    Key key,
    @required this.errorType,
    @required this.bloc
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_32.w),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorType == AppErrorType.api
              ? TranslationConstants.somethingWentWrong.translate(context)
              : TranslationConstants.checkNetwork.translate(context),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          ButtonBar(
            children: [
              Button(
                text: TranslationConstants.retry,
                onPressed: () => bloc.add(CarouselLoadEvent())
              ),
              Button(
                text: TranslationConstants.feedback,
                onPressed: () => Wiredash.of(context).show()
              )
            ],
          )
        ],
      ),
    );
  }
}