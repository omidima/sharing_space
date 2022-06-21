import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_space/data/repository/space_repository.dart';

import '../../data/dto/space_dto.dart';
part '../state/start_state.dart';

class StartController extends Cubit<StartFormState> {
  final SpaceRepository _spaceRepository = SpaceRepository.getInstance;
  String? spaceId;
  String? name;

  StartController() : super(SubmitInit());

  submitSpace() async {
    if (spaceId != null) {
      var result = await _spaceRepository.chcekValidSpace(spaceId!);
      result.when(success: (data) {
        emit(SubmitSuccess(data, name == null ? 'مهمان' : name!));
      }, failure: (failure) {
        emit(SubmitFailure());
      });
    }
  }

  createRoom(
    String? groupName,
  ) async {
    if (name != null) {
      var result = await _spaceRepository.createNewSpaces(groupName!);

      result.when(success: (success) {
        emit(SubmitSuccess(success, name == null ? 'مهمان' : name!));
      }, failure: (failure) {
        emit(SubmitFailure());
      });
    }
  }
}
