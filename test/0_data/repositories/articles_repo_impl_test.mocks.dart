// Mocks generated by Mockito 5.4.4 from annotations
// in flutter_challenge_hs/test/0_data/repositories/articles_repo_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:flutter_challenge_hs/0_data/datasources/articles_remote_datasource.dart'
    as _i4;
import 'package:flutter_challenge_hs/0_data/models/articles_model.dart' as _i3;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeClient_0 extends _i1.SmartFake implements _i2.Client {
  _FakeClient_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeArticlesModel_1 extends _i1.SmartFake implements _i3.ArticlesModel {
  _FakeArticlesModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ArticlesRemoteDatasourceImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockArticlesRemoteDatasourceImpl extends _i1.Mock
    implements _i4.ArticlesRemoteDatasourceImpl {
  @override
  _i2.Client get client => (super.noSuchMethod(
        Invocation.getter(#client),
        returnValue: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
        returnValueForMissingStub: _FakeClient_0(
          this,
          Invocation.getter(#client),
        ),
      ) as _i2.Client);

  @override
  _i5.Future<_i3.ArticlesModel> getArticlesFromApi({required String? source}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getArticlesFromApi,
          [],
          {#source: source},
        ),
        returnValue: _i5.Future<_i3.ArticlesModel>.value(_FakeArticlesModel_1(
          this,
          Invocation.method(
            #getArticlesFromApi,
            [],
            {#source: source},
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.ArticlesModel>.value(_FakeArticlesModel_1(
          this,
          Invocation.method(
            #getArticlesFromApi,
            [],
            {#source: source},
          ),
        )),
      ) as _i5.Future<_i3.ArticlesModel>);
}
