class ContactModel {
  String? _objectId;
  String? _name;
  String? _phone;
  String? _email;
  String? _photo;

  ContactModel(
      {String? objectId,
      String? name,
      String? phone,
      String? email,
      String? photo}) {
    if (objectId != null) {
      this._objectId = _objectId;
    }
    if (photo != null) {
      this._photo = photo;
    }
    if (name != null) {
      this._name = name;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (email != null) {
      this._email = email;
    }
  }
  String? get objectId => _objectId;
  set objectId(String? objectId) => _objectId = objectId;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get photo => _photo;
  set photo(String? photo) => _photo = photo;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get email => _email;
  set email(String? email) => _email = email;

  ContactModel.fromJson(Map<String, dynamic> json) {
    _objectId = json["objectId"];
    _name = json['name'];
    _phone = json['phone'];
    _email = json['email'];
    _photo = json['photo'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['objectId'] = this._objectId;
    data['name'] = this._name;
    data['phone'] = this._phone;
    data['email'] = this._email;
    data['photo'] = this._photo;
    return data;
  }
}
