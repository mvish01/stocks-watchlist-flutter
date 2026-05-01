abstract class WatchlistEvent {}

class LoadWatchlists extends WatchlistEvent {}

class ChangeTab extends WatchlistEvent {
  final int index;
  ChangeTab(this.index);
}

class ToggleEdit extends WatchlistEvent {}

class ReorderStocks extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderStocks(this.oldIndex, this.newIndex);
}

class DeleteStock extends WatchlistEvent {
  final String id;
  DeleteStock(this.id);
}