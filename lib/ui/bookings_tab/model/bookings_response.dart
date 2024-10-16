class MyBookingsResponse {
  dynamic success;
  List<MyBookingsData>? data;
  dynamic message;

  MyBookingsResponse({this.success, this.data, this.message});

  MyBookingsResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <MyBookingsData>[];
      json['data'].forEach((v) {
        data!.add(MyBookingsData.fromJson(v));
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

class MyBookingsData {
  dynamic id;
  dynamic assignedProvider;
  dynamic assignedDriver;
  dynamic userId;
  dynamic roomId;
  dynamic categoryId;
  dynamic subCategoryId;
  dynamic noOfCane;
  dynamic price;
  dynamic status;
  dynamic serviceStatus;
  dynamic createdAt;
  dynamic updatedAt;
  PickupAddress? pickupAddress;
  dynamic distance;
  dynamic time;
  SubCategoryData? subCategoryData;
  CategoryData? categoryData;
  BinbearData? binbearData;
  ServiceProviderData? serviceProviderData;
  UserData? userData;

  MyBookingsData(
      {this.id,
      this.assignedProvider,
      this.assignedDriver,
      this.userId,
        this.roomId,
      this.categoryId,
      this.subCategoryId,
      this.noOfCane,
      this.price,
      this.status,
      this.serviceStatus,
      this.createdAt,
      this.updatedAt,
      this.pickupAddress,
      this.distance,
      this.time,
      this.subCategoryData,
      this.categoryData,
      this.binbearData,
      this.serviceProviderData,
      this.userData});

  MyBookingsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    assignedProvider = json['assigned_provider'];
    assignedDriver = json['assigned_driver'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    noOfCane = json['no_of_cane'];
    price = json['price'];
    status = json['status'];
    serviceStatus = json['service_status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pickupAddress = json['pickup_address'] != null
        ? PickupAddress.fromJson(json['pickup_address'])
        : null;
    distance = json['distance'];
    time = json['time'];
    subCategoryData = json['sub_category_data'] != null
        ? SubCategoryData.fromJson(json['sub_category_data'])
        : null;
    categoryData = json['category_data'] != null
        ? CategoryData.fromJson(json['category_data'])
        : null;
    binbearData = json['binbear_data'] != null
        ? BinbearData.fromJson(json['binbear_data'])
        : null;
    serviceProviderData = json['service_provider_data'] != null
        ? ServiceProviderData.fromJson(json['service_provider_data'])
        : null;
    userData = json['user_data'] != null
        ? UserData.fromJson(json['user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['assigned_provider'] = assignedProvider;
    data['assigned_driver'] = assignedDriver;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['no_of_cane'] = noOfCane;
    data['price'] = price;
    data['status'] = status;
    data['service_status'] = serviceStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pickupAddress != null) {
      data['pickup_address'] = pickupAddress!.toJson();
    }
    data['distance'] = distance;
    data['time'] = time;
    if (subCategoryData != null) {
      data['sub_category_data'] = subCategoryData!.toJson();
    }
    if (categoryData != null) {
      data['category_data'] = categoryData!.toJson();
    }
    if (binbearData != null) {
      data['binbear_data'] = binbearData!.toJson();
    }
    if (serviceProviderData != null) {
      data['service_provider_data'] = serviceProviderData!.toJson();
    }
    if (userData != null) {
      data['user_data'] = userData!.toJson();
    }
    return data;
  }
}

class PickupAddress {
  dynamic id;
  dynamic userId;
  dynamic flatNo;
  dynamic apartment;
  dynamic description;
  dynamic lat;
  dynamic lng;
  dynamic homeType;
  dynamic fullAddress;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  PickupAddress(
      {this.id,
      this.userId,
      this.flatNo,
      this.apartment,
      this.description,
      this.lat,
      this.lng,
      this.fullAddress,
      this.homeType,
      this.status,
      this.createdAt,
      this.updatedAt});

  PickupAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    flatNo = json['flat_no'];
    apartment = json['apartment'];
    description = json['description'];
    lat = json['lat'];
    lng = json['lng'];
    fullAddress = json["full_address"];
    homeType = json['home_type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['flat_no'] = flatNo;
    data['apartment'] = apartment;
    data['description'] = description;
    data['lat'] = lat;

        data["full_address"]= fullAddress;
    data['lng'] = lng;
    data['home_type'] = homeType;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SubCategoryData {
  dynamic id;
  dynamic categoryId;
  dynamic title;
  dynamic price;
  dynamic description;
  dynamic image;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  SubCategoryData(
      {this.id,
      this.categoryId,
      this.title,
      this.price,
      this.description,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  SubCategoryData.fromJson(Map<String, dynamic> json) {
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

class CategoryData {
  dynamic id;
  dynamic title;
  dynamic description;
  dynamic price;
  dynamic image;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

  CategoryData(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  CategoryData.fromJson(Map<String, dynamic> json) {
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

class BinbearData {
  dynamic id;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  dynamic stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic isOnline;
  dynamic countryCode;
  dynamic otp;
  dynamic token;
  dynamic profile;
  dynamic bio;
  dynamic roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic idProof;
  dynamic isVerify;
  dynamic adminApproval;
  dynamic status;
  dynamic binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic isSendNotification;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic deviceToken;
  dynamic createdAt;
  dynamic updatedAt;

  BinbearData(
      {this.id,
      this.name,
      this.middleName,
      this.lastName,
      this.email,
      this.mobile,
      this.stripeAccountId,
      this.dob,
      this.gender,
      this.isOnline,
      this.countryCode,
      this.otp,
      this.token,
      this.profile,
      this.bio,
      this.roleId,
      this.serviceProviderId,
      this.businessName,
      this.idProof,
      this.isVerify,
      this.adminApproval,
      this.status,
      this.binbearStatus,
      this.binbearCurrentBooking,
      this.isSendNotification,
      this.emailVerifiedAt,
      this.phoneVerifiedAt,
      this.deviceToken,
      this.createdAt,
      this.updatedAt});

  BinbearData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    stripeAccountId = json['stripe_account_id'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    serviceProviderId = json['service_provider_id'];
    businessName = json['business_name'];
    idProof = json['id_proof'];
    isVerify = json['is_verify'];
    adminApproval = json['admin_approval'];
    status = json['status'];
    binbearStatus = json['binbear_status'];
    binbearCurrentBooking = json['binbear_current_booking'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['stripe_account_id'] = stripeAccountId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['is_online'] = isOnline;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['token'] = token;
    data['profile'] = profile;
    data['bio'] = bio;
    data['role_id'] = roleId;
    data['service_provider_id'] = serviceProviderId;
    data['business_name'] = businessName;
    data['id_proof'] = idProof;
    data['is_verify'] = isVerify;
    data['admin_approval'] = adminApproval;
    data['status'] = status;
    data['binbear_status'] = binbearStatus;
    data['binbear_current_booking'] = binbearCurrentBooking;
    data['is_send_notification'] = isSendNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ServiceProviderData {
  dynamic id;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  dynamic stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic isOnline;
  dynamic countryCode;
  dynamic otp;
  dynamic token;
  dynamic profile;
  dynamic bio;
  dynamic roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic idProof;
  dynamic isVerify;
  dynamic adminApproval;
  dynamic status;
  dynamic binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic isSendNotification;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic deviceToken;
  dynamic createdAt;
  dynamic updatedAt;

  ServiceProviderData(
      {this.id,
        this.name,
        this.middleName,
        this.lastName,
        this.email,
        this.mobile,
        this.stripeAccountId,
        this.dob,
        this.gender,
        this.isOnline,
        this.countryCode,
        this.otp,
        this.token,
        this.profile,
        this.bio,
        this.roleId,
        this.serviceProviderId,
        this.businessName,
        this.idProof,
        this.isVerify,
        this.adminApproval,
        this.status,
        this.binbearStatus,
        this.binbearCurrentBooking,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  ServiceProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    stripeAccountId = json['stripe_account_id'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    serviceProviderId = json['service_provider_id'];
    businessName = json['business_name'];
    idProof = json['id_proof'];
    isVerify = json['is_verify'];
    adminApproval = json['admin_approval'];
    status = json['status'];
    binbearStatus = json['binbear_status'];
    binbearCurrentBooking = json['binbear_current_booking'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['stripe_account_id'] = stripeAccountId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['is_online'] = isOnline;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['token'] = token;
    data['profile'] = profile;
    data['bio'] = bio;
    data['role_id'] = roleId;
    data['service_provider_id'] = serviceProviderId;
    data['business_name'] = businessName;
    data['id_proof'] = idProof;
    data['is_verify'] = isVerify;
    data['admin_approval'] = adminApproval;
    data['status'] = status;
    data['binbear_status'] = binbearStatus;
    data['binbear_current_booking'] = binbearCurrentBooking;
    data['is_send_notification'] = isSendNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserData {
  dynamic id;
  dynamic name;
  dynamic middleName;
  dynamic lastName;
  dynamic email;
  dynamic mobile;
  dynamic stripeAccountId;
  dynamic dob;
  dynamic gender;
  dynamic isOnline;
  dynamic countryCode;
  dynamic otp;
  dynamic token;
  dynamic profile;
  dynamic bio;
  dynamic roleId;
  dynamic serviceProviderId;
  dynamic businessName;
  dynamic idProof;
  dynamic isVerify;
  dynamic adminApproval;
  dynamic status;
  dynamic binbearStatus;
  dynamic binbearCurrentBooking;
  dynamic isSendNotification;
  dynamic emailVerifiedAt;
  dynamic phoneVerifiedAt;
  dynamic deviceToken;
  dynamic createdAt;
  dynamic updatedAt;

  UserData(
      {this.id,
        this.name,
        this.middleName,
        this.lastName,
        this.email,
        this.mobile,
        this.stripeAccountId,
        this.dob,
        this.gender,
        this.isOnline,
        this.countryCode,
        this.otp,
        this.token,
        this.profile,
        this.bio,
        this.roleId,
        this.serviceProviderId,
        this.businessName,
        this.idProof,
        this.isVerify,
        this.adminApproval,
        this.status,
        this.binbearStatus,
        this.binbearCurrentBooking,
        this.isSendNotification,
        this.emailVerifiedAt,
        this.phoneVerifiedAt,
        this.deviceToken,
        this.createdAt,
        this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    stripeAccountId = json['stripe_account_id'];
    dob = json['dob'];
    gender = json['gender'];
    isOnline = json['is_online'];
    countryCode = json['country_code'];
    otp = json['otp'];
    token = json['token'];
    profile = json['profile'];
    bio = json['bio'];
    roleId = json['role_id'];
    serviceProviderId = json['service_provider_id'];
    businessName = json['business_name'];
    idProof = json['id_proof'];
    isVerify = json['is_verify'];
    adminApproval = json['admin_approval'];
    status = json['status'];
    binbearStatus = json['binbear_status'];
    binbearCurrentBooking = json['binbear_current_booking'];
    isSendNotification = json['is_send_notification'];
    emailVerifiedAt = json['email_verified_at'];
    phoneVerifiedAt = json['phone_verified_at'];
    deviceToken = json['device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['stripe_account_id'] = stripeAccountId;
    data['dob'] = dob;
    data['gender'] = gender;
    data['is_online'] = isOnline;
    data['country_code'] = countryCode;
    data['otp'] = otp;
    data['token'] = token;
    data['profile'] = profile;
    data['bio'] = bio;
    data['role_id'] = roleId;
    data['service_provider_id'] = serviceProviderId;
    data['business_name'] = businessName;
    data['id_proof'] = idProof;
    data['is_verify'] = isVerify;
    data['admin_approval'] = adminApproval;
    data['status'] = status;
    data['binbear_status'] = binbearStatus;
    data['binbear_current_booking'] = binbearCurrentBooking;
    data['is_send_notification'] = isSendNotification;
    data['email_verified_at'] = emailVerifiedAt;
    data['phone_verified_at'] = phoneVerifiedAt;
    data['device_token'] = deviceToken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}