import 'package:bloc/bloc.dart';
import 'package:corona_covid19_api/bloc/covidCoronaModel.dart';
import 'package:corona_covid19_api/bloc/covidCoronaRepo.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CovidCoronaEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class FetchCoronaData extends CovidCoronaEvent {
  final _currenData;

  FetchCoronaData(this._currenData);

  CovidCoronaRepoClass get currentCoronaData => _currenData;

  @override
  // TODO: implement props
  List<Object> get props => [_currenData];
}

class ResetCoronaData extends CovidCoronaEvent {}

class CovidCoronaState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CoronaDataIsLoading extends CovidCoronaState {}

class CoronaDataIsNotSearched extends CovidCoronaState {}

class CoronaDataIsLoaded extends CovidCoronaState {
  final _currentCoronaData;

  CoronaDataIsLoaded(this._currentCoronaData);

  CovidCoromaModelClass get currentCoronaData => _currentCoronaData;

  @override
  // TODO: implement props
  List<Object> get props => [_currentCoronaData];
}

class CoronaDataIsNotLoaded extends CovidCoronaState {}

class CovidCoronaBloc extends Bloc<CovidCoronaEvent, CovidCoronaState> {
  CovidCoronaRepoClass coronaRepo;

  CovidCoronaBloc(this.coronaRepo);

  @override
  // TODO: implement initialState
  CovidCoronaState get initialState => CoronaDataIsNotSearched();

  @override
  Stream<CovidCoronaState> mapEventToState(CovidCoronaEvent event) async* {
    // TODO: implement mapEventToState
    if (event is FetchCoronaData) {
      yield CoronaDataIsLoading();
      try {
        CovidCoromaModelClass getCoronaData =
            await coronaRepo.getCoronaData(event._currenData);
        yield CoronaDataIsLoaded(getCoronaData);
      } catch (_) {
        yield CoronaDataIsNotLoaded();
      }
    } else if (event is ResetCoronaData) {
      yield CoronaDataIsNotSearched();
    }
  }
}
