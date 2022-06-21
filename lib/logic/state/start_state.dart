part of '../cubit/start_controller.dart';

abstract class StartFormState {}

class SubmitInit extends StartFormState {}

class SubmitSuccess extends StartFormState {
  SpaceDto space;
  String username;
  SubmitSuccess(this.space, this.username);
}

class SubmitFailure extends StartFormState {}
