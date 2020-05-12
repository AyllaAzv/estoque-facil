// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoModel on ProdutoModelBase, Store {
  final _$produtosAtom = Atom(name: 'ProdutoModelBase.produtos');

  @override
  List<Produto> get produtos {
    _$produtosAtom.context.enforceReadPolicy(_$produtosAtom);
    _$produtosAtom.reportObserved();
    return super.produtos;
  }

  @override
  set produtos(List<Produto> value) {
    _$produtosAtom.context.conditionallyRunInAction(() {
      super.produtos = value;
      _$produtosAtom.reportChanged();
    }, _$produtosAtom, name: '${_$produtosAtom.name}_set');
  }

  final _$errorAtom = Atom(name: 'ProdutoModelBase.error');

  @override
  Exception get error {
    _$errorAtom.context.enforceReadPolicy(_$errorAtom);
    _$errorAtom.reportObserved();
    return super.error;
  }

  @override
  set error(Exception value) {
    _$errorAtom.context.conditionallyRunInAction(() {
      super.error = value;
      _$errorAtom.reportChanged();
    }, _$errorAtom, name: '${_$errorAtom.name}_set');
  }

  final _$getProdutosAsyncAction = AsyncAction('getProdutos');

  @override
  Future getProdutos() {
    return _$getProdutosAsyncAction.run(() => super.getProdutos());
  }

  final _$getProdutosDisponivelAsyncAction =
      AsyncAction('getProdutosDisponivel');

  @override
  Future getProdutosDisponivel() {
    return _$getProdutosDisponivelAsyncAction
        .run(() => super.getProdutosDisponivel());
  }

  final _$getProdutosSemEstoqueAsyncAction =
      AsyncAction('getProdutosSemEstoque');

  @override
  Future getProdutosSemEstoque() {
    return _$getProdutosSemEstoqueAsyncAction
        .run(() => super.getProdutosSemEstoque());
  }

  @override
  String toString() {
    final string =
        'produtos: ${produtos.toString()},error: ${error.toString()}';
    return '{$string}';
  }
}
