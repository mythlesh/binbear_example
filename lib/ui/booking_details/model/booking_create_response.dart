class BookingCreateResponse {
  dynamic success;
  BookingCreateData? data;
  dynamic message;

  BookingCreateResponse({this.success, this.data, this.message});

  BookingCreateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? BookingCreateData.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class BookingCreateData {
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic noOfCane;
  dynamic price;
  dynamic basePrice;
  dynamic status;
  dynamic userId;
  dynamic addressId;
  dynamic couponId;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  BookingCreateData(
      {this.categoryId,
        this.subCategoryId,
        this.noOfCane,
        this.price,
        this.basePrice,
        this.status,
        this.userId,
        this.addressId,
        this.couponId,
        this.updatedAt,
        this.createdAt,
        this.id});

  BookingCreateData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    noOfCane = json['no_of_cane'];
    price = json['price'];
    basePrice = json['base_price'];
    status = json['status'];
    userId = json['user_id'];
    addressId = json['address_id'];
    couponId = json['coupon_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['no_of_cane'] = noOfCane;
    data['price'] = price;
    data['base_price'] = basePrice;
    data['status'] = status;
    data['user_id'] = userId;
    data['address_id'] = addressId;
    data['coupon_id'] = couponId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
