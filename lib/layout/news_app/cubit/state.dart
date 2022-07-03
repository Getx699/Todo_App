abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewBottomNavState extends NewsState {}

class NewsBusinessSuccessState extends NewsState {}

class NewsBusinessErrorState extends NewsState {
  final String error;

  NewsBusinessErrorState(this.error);
}

class NewsLoadingState extends NewsState {}


class NewsSportsSuccessState extends NewsState {}

class NewsSportsErrorState extends NewsState {
  final String error;

  NewsSportsErrorState(this.error);


}

class NewsSportsLoadingState extends NewsState {}

class NewsScienceSuccessState extends NewsState {}

class NewsScienceErrorState extends NewsState {
  final String error;

  NewsScienceErrorState(this.error);
}

class NewsScienceLoadingState extends NewsState {}
class NewsSearchSuccessState extends NewsState {}

class NewsSearchErrorState extends NewsState {
  final String error;

  NewsSearchErrorState(this.error);
}

class NewsSearchLoadingState extends NewsState {}