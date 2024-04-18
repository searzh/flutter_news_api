import 'package:flutter_challenge_hs/2_application/pages/details/favorites_cubit/favorites_cubit.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:test/test.dart';

void main() {
  group('FavoritesCubit', () {
    late Database db;

    setUpAll(() {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    });

    group(
      'Should emit',
      () {
        blocTest(
          'Nothing when no method is called',
          build: () => FavoritesCubit(),
          expect: () => <FavoritesState>[],
        );
      },
    );

    group(
      'Should find',
      () {
        test(
          'Nothing when no favorite has been inserted',
          () async {
            db = await openDatabase(
              inMemoryDatabasePath,
              version: 1,
              onCreate: (db, version) async {
                await db.execute(
                  'CREATE TABLE favorites(id TEXT PRIMARY KEY, isFavorite INT)',
                );
              },
            );

            expect(
              await db.query('favorites'),
              [],
            );

            await db.close();
          },
        );

        test(
          'A record when a favorite has been inserted',
          () async {
            db = await openDatabase(
              inMemoryDatabasePath,
              version: 1,
              onCreate: (db, version) async {
                await db.execute(
                  'CREATE TABLE favorites(id TEXT PRIMARY KEY, isFavorite INT)',
                );
              },
            );

            await db.insert(
              'favorites',
              <String, Object?>{
                'id': '2023-04-18T12:00:00Z',
                'isFavorite': 1,
              },
            );

            expect(
              await db.query('favorites'),
              [
                {
                  'id': '2023-04-18T12:00:00Z',
                  'isFavorite': 1,
                },
              ],
            );

            await db.close();
          },
        );
      },
    );
  });
}
