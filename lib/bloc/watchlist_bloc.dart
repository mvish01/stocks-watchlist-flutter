import 'package:bloc/bloc.dart';
import 'package:stocks_watchlist_app/bloc/watchlist_event.dart';
import 'package:stocks_watchlist_app/bloc/watchlist_state.dart';

import '../model/stock.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  WatchlistBloc()
      : super(const WatchlistState(
    selectedTab: 0,
    watchlists: {},
    isEditing: false,
  )) {
    on<LoadWatchlists>(_onLoad);
    on<ChangeTab>(_onTabChange);
    on<ToggleEdit>(_onToggleEdit);
    on<ReorderStocks>(_onReorder);
    on<DeleteStock>(_onDelete);
  }

  void _onLoad(LoadWatchlists event, Emitter emit) {
    final data = {
      0: [
        Stock(
          id: '1',
          name: 'RELIANCE',
          exchange: 'NSE | EQ',
          price: 1374.10,
          change: -4.40,
          percent: -0.32,
        ),
        Stock(
          id: '2',
          name: 'HDFCBANK',
          exchange: 'NSE | EQ',
          price: 966.95,
          change: 0.95,
          percent: 0.10,
        ),
        Stock(
          id: '3',
          name: 'ASIANPAINT',
          exchange: 'NSE | EQ',
          price: 2537.40,
          change: 6.60,
          percent: 0.26,
        ),
        Stock(
          id: '4',
          name: 'NIFTY IT',
          exchange: 'IDX',
          price: 35187.55,
          change: 87.11,
          percent: 2.56,
        ),   Stock(
          id: '5',
          name: 'RELIANCE SEP 1880 CE',
          exchange: 'NSE | Monthly',
          price: 0.00,
          change: 0.00,
          percent: 0.00,
        ),   Stock(
          id: '6',
          name: 'RELIANCE 1370 PE',
          exchange: 'NSE | Monthly',
          price: 19.20,
          change: 1.00,
          percent: 5.49,
        ),
        Stock(
          id: '8',
          name: 'MRF',
          exchange: 'NSE | EQ',
          price: 147625.00,
          change: 550.0,
          percent: 0.37,
        ),
      ],
      1: [
        Stock(
          id: '7',
          name: 'RELIANCE',
          exchange: 'NSE | EQ',
          price: 1374.10,
          change: -4.40,
          percent: -0.32,
        ),
        Stock(
          id: '8',
          name: 'MRF',
          exchange: 'NSE | EQ',
          price: 147625.00,
          change: 550.0,
          percent: 0.37,
        ),
        Stock(
          id: '9',
          name: 'INFOSYS',
          exchange: 'NSE | EQ',
          price: 2537.40,
          change: 6.60,
          percent: 0.26,
        ),
      ],
      2: [
        Stock(
          id: '10',
          name: 'BANK NIFTY',
          exchange: 'NSE | EQ',
          price: 1374.10,
          change: -4.40,
          percent: -0.32,
        ),
        Stock(
          id: '11',
          name: 'HDFCBANK',
          exchange: 'NSE | EQ',
          price: 966.95,
          change: 0.95,
          percent: 0.10,
        ),
        Stock(
          id: '12',
          name: 'SBI',
          exchange: 'NSE | EQ',
          price: 2537.40,
          change: 6.60,
          percent: 0.26,
        ),
      ],
    };

    emit(state.copyWith(watchlists: data));
  }

  void _onTabChange(ChangeTab event, Emitter emit) {
    emit(state.copyWith(selectedTab: event.index));
  }

  void _onToggleEdit(ToggleEdit event, Emitter emit) {
    emit(state.copyWith(isEditing: !state.isEditing));
  }

  void _onReorder(ReorderStocks event, Emitter emit) {
    final list =
    List<Stock>.from(state.watchlists[state.selectedTab]!);

    int newIndex = event.newIndex;
    if (event.oldIndex < newIndex) newIndex--;

    final item = list.removeAt(event.oldIndex);
    list.insert(newIndex, item);

    final updated = Map<int, List<Stock>>.from(state.watchlists);
    updated[state.selectedTab] = list;

    emit(state.copyWith(watchlists: updated));
  }

  void _onDelete(DeleteStock event, Emitter emit) {
    final list = state.watchlists[state.selectedTab]!
        .where((e) => e.id != event.id)
        .toList();

    final updated = Map<int, List<Stock>>.from(state.watchlists);
    updated[state.selectedTab] = list;

    emit(state.copyWith(watchlists: updated));
  }
}