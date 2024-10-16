class ServiceListResponse {
  bool? success;
  List<ServiceListData>? data;
  String? message;

  ServiceListResponse({this.success, this.data, this.message});

  ServiceListResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ServiceListData>[];
      json['data'].forEach((v) {
        data!.add(ServiceListData.fromJson(v));
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

class ServiceListData {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic image;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  ServiceListData(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.image,
        this.status,
        this.createdAt,
        this.updatedAt});

  ServiceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}