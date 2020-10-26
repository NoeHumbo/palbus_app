// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connectivity_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConnectivityStore on _ConnectivityStore, Store {
  final _$connectionStateAtom =
      Atom(name: '_ConnectivityStore.connectionState');

  @override
  bool get connectionState {
    _$connectionStateAtom.reportRead();
    return super.connectionState;
  }

  @override
  set connectionState(bool value) {
    _$connectionStateAtom.reportWrite(value, super.connectionState, () {
      super.connectionState = value;
    });
  }

  final _$checkConnectionAsyncAction =
      AsyncAction('_ConnectivityStore.checkConnection');

  @override
  Future<dynamic> checkConnection() {
    return _$checkConnectionAsyncAction.run(() => super.checkConnection());
  }

  @override
  String toString() {
    return '''
connectionState: ${connectionState}
    ''';
  }
}
