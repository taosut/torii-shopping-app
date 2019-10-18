import 'dart:async';

import 'package:torii_shopping/src/banners/domain/banner.dart';
import 'package:torii_shopping/src/banners/domain/usecases/get_banners.dart';
import 'package:torii_shopping/src/common/presentation/blocs/bloc_base.dart';

class BannersBloc implements BlocBase{
  GetBannersUseCase _getBannersUseCase;

  final _bannersController = StreamController<Map<String, List<Banner>>>();
  Stream<Map<String, List<Banner>>> get banners => _bannersController.stream;

  BannersBloc(this._getBannersUseCase){
    init();
  }

  init() async {
    _getBannersUseCase.execute()
    .then((banners) => _bannersController.sink.add(banners))
    .catchError((error) => _bannersController.sink.addError(error));
  }

  @override
  void dispose() {
    _bannersController.close();
  }

}