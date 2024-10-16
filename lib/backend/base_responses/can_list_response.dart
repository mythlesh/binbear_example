class CanListResponse {
  dynamic success;
  List<CanListData>? data;
  dynamic message;

  CanListResponse({this.success, this.data, this.message});

  CanListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CanListData>[];
      json['data'].forEach((v) {
        data!.add(CanListData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    return data;
  }
}

class CanListData {
  dynamic id;
  dynamic title;
  dynamic value;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  CanListData(
      {this.id,
        this.title,
        this.value,
        this.status,
        this.createdAt,
        this.updatedAt});

  CanListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['value'] = value;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}