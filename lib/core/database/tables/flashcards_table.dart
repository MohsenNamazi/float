import 'package:drift/drift.dart';

import 'decks_table.dart';

@DataClassName('FlashcardRow')
class Flashcards extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get deckId => integer().references(Decks, #id)();
  TextColumn get word => text().withLength(min: 1, max: 500)();
  TextColumn get translation => text().withLength(min: 1, max: 500)();
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get due => dateTime().withDefault(currentDateAndTime)();
  RealColumn get stability =>
      real().withDefault(const Constant(0.0))();
  RealColumn get difficulty =>
      real().withDefault(const Constant(5.0))();
  IntColumn get reps => integer().withDefault(const Constant(0))();
  IntColumn get lapses => integer().withDefault(const Constant(0))();
  // FsrsCardState enum index: 0=newCard, 1=learning, 2=review, 3=relearning
  IntColumn get state => integer().withDefault(const Constant(0))();
}
