class WordModel {
  String _word;
  String _wordCategory;

  WordModel(this._word, this._wordCategory);

  String get wordCategory => _wordCategory;

  set wordCategory(String value) {
    _wordCategory = value;
  }

  String get word => _word;

  set word(String value) {
    _word = value;
  }
}
