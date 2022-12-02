abstract class ViewEvent {}

class ChangeView extends ViewEvent {
  final String view;

  ChangeView({required this.view});
}

class LogoutUserView extends ViewEvent {}
