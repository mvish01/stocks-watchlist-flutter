import '../model/stock.dart';

class WatchlistState {
  final int selectedTab;
  final Map<int, List<Stock>> watchlists;
  final bool isEditing;

  const WatchlistState({
    required this.selectedTab,
    required this.watchlists,
    required this.isEditing,
  });

  WatchlistState copyWith({
    int? selectedTab,
    Map<int, List<Stock>>? watchlists,
    bool? isEditing,
  }) {
    return WatchlistState(
      selectedTab: selectedTab ?? this.selectedTab,
      watchlists: watchlists ?? this.watchlists,
      isEditing: isEditing ?? this.isEditing,
    );
  }
}