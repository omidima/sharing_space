part of '../screen/start_screen.dart';

class StartViewModel extends BaseViewModel<_StartScreenState, StartFormState> {
  StartViewModel({required super.view});

  @override
  onSuccess(StartFormState state) {
    var data = state as SubmitSuccess;
    Hive.box(MAIN_BOX).put(HiveData.spaceId, data.space.objectId);
    Hive.box(MAIN_BOX).put(HiveData.username, data.username);
    Hive.box(MAIN_BOX).put(HiveData.spaceInfo, SpaceEntity()
        ..createdAt = data.space.createdAt
        ..group_name = data.space.group_name
        ..objectId = data.space.objectId);
    
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (route) => false);
  }

  @override
  onFailuer(StartFormState state) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('اتاقی وجود ندارد.')));
  }
}
