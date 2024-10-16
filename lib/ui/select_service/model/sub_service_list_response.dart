class SubServiceListResponse {
  dynamic success;
  List<SubServiceListData>? data;
  dynamic message;

  SubServiceListResponse({this.success, this.data, this.message});

  SubServiceListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SubServiceListData>[];
      json['data'].forEach((v) {
        data!.add(SubServiceListData.fromJson(v));
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

class SubServiceListData {
  dynamic id;
  dynamic categoryId;
  dynamic title;
  dynamic price;
  dynamic description;
  dynamic image;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  SubServiceListData(
      {this.id,
        this.categoryId,
        this.title,
        this.price,
        this.description,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  SubServiceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_id'] = categoryId;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}