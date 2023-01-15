// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.27.1
// 	protoc        v3.21.5
// source: users/users.proto

package users

import (
	groups "github.com/simpleGrpcApp/users/pkg/api/groups"
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	timestamppb "google.golang.org/protobuf/types/known/timestamppb"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

// Тип пользователя
type UserType int32

const (
	// Неизвестный
	UserType_USER_TYPE_UNKNOWN UserType = 0
	// Администратор
	UserType_ADMIN UserType = 1
	// Обычный пользователь
	UserType_USER UserType = 2
)

// Enum value maps for UserType.
var (
	UserType_name = map[int32]string{
		0: "USER_TYPE_UNKNOWN",
		1: "ADMIN",
		2: "USER",
	}
	UserType_value = map[string]int32{
		"USER_TYPE_UNKNOWN": 0,
		"ADMIN":             1,
		"USER":              2,
	}
)

func (x UserType) Enum() *UserType {
	p := new(UserType)
	*p = x
	return p
}

func (x UserType) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (UserType) Descriptor() protoreflect.EnumDescriptor {
	return file_users_users_proto_enumTypes[0].Descriptor()
}

func (UserType) Type() protoreflect.EnumType {
	return &file_users_users_proto_enumTypes[0]
}

func (x UserType) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use UserType.Descriptor instead.
func (UserType) EnumDescriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{0}
}

// Поле для сортировки
type ListRequest_OrderField int32

const (
	// Создание пользователя
	ListRequest_CREATED_AT ListRequest_OrderField = 0
	// Обновление пользователя
	ListRequest_UPDATED_AT ListRequest_OrderField = 1
)

// Enum value maps for ListRequest_OrderField.
var (
	ListRequest_OrderField_name = map[int32]string{
		0: "CREATED_AT",
		1: "UPDATED_AT",
	}
	ListRequest_OrderField_value = map[string]int32{
		"CREATED_AT": 0,
		"UPDATED_AT": 1,
	}
)

func (x ListRequest_OrderField) Enum() *ListRequest_OrderField {
	p := new(ListRequest_OrderField)
	*p = x
	return p
}

func (x ListRequest_OrderField) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (ListRequest_OrderField) Descriptor() protoreflect.EnumDescriptor {
	return file_users_users_proto_enumTypes[1].Descriptor()
}

func (ListRequest_OrderField) Type() protoreflect.EnumType {
	return &file_users_users_proto_enumTypes[1]
}

func (x ListRequest_OrderField) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use ListRequest_OrderField.Descriptor instead.
func (ListRequest_OrderField) EnumDescriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{0, 0}
}

// Направление сортировки
type ListRequest_OrderDirection int32

const (
	// По возрастанию
	ListRequest_ASC ListRequest_OrderDirection = 0
	// По убыванию
	ListRequest_DESC ListRequest_OrderDirection = 1
)

// Enum value maps for ListRequest_OrderDirection.
var (
	ListRequest_OrderDirection_name = map[int32]string{
		0: "ASC",
		1: "DESC",
	}
	ListRequest_OrderDirection_value = map[string]int32{
		"ASC":  0,
		"DESC": 1,
	}
)

func (x ListRequest_OrderDirection) Enum() *ListRequest_OrderDirection {
	p := new(ListRequest_OrderDirection)
	*p = x
	return p
}

func (x ListRequest_OrderDirection) String() string {
	return protoimpl.X.EnumStringOf(x.Descriptor(), protoreflect.EnumNumber(x))
}

func (ListRequest_OrderDirection) Descriptor() protoreflect.EnumDescriptor {
	return file_users_users_proto_enumTypes[2].Descriptor()
}

func (ListRequest_OrderDirection) Type() protoreflect.EnumType {
	return &file_users_users_proto_enumTypes[2]
}

func (x ListRequest_OrderDirection) Number() protoreflect.EnumNumber {
	return protoreflect.EnumNumber(x)
}

// Deprecated: Use ListRequest_OrderDirection.Descriptor instead.
func (ListRequest_OrderDirection) EnumDescriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{0, 1}
}

// Сущность запроса на получение списка пользователей
type ListRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Фильтр запроса
	Filter *ListRequest_Filter `protobuf:"bytes,1,opt,name=filter,proto3" json:"filter,omitempty"`
	// Лимит записей
	Limit uint64 `protobuf:"varint,2,opt,name=limit,proto3" json:"limit,omitempty"`
	// Сдвиг записей
	Offset uint64 `protobuf:"varint,3,opt,name=offset,proto3" json:"offset,omitempty"`
	// Поле для сортировки
	OrderFiled ListRequest_OrderField `protobuf:"varint,4,opt,name=order_filed,json=orderFiled,proto3,enum=users.ListRequest_OrderField" json:"order_filed,omitempty"`
	// Направление для сортировки
	OrderDirection ListRequest_OrderDirection `protobuf:"varint,5,opt,name=order_direction,json=orderDirection,proto3,enum=users.ListRequest_OrderDirection" json:"order_direction,omitempty"`
}

func (x *ListRequest) Reset() {
	*x = ListRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListRequest) ProtoMessage() {}

func (x *ListRequest) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListRequest.ProtoReflect.Descriptor instead.
func (*ListRequest) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{0}
}

func (x *ListRequest) GetFilter() *ListRequest_Filter {
	if x != nil {
		return x.Filter
	}
	return nil
}

func (x *ListRequest) GetLimit() uint64 {
	if x != nil {
		return x.Limit
	}
	return 0
}

func (x *ListRequest) GetOffset() uint64 {
	if x != nil {
		return x.Offset
	}
	return 0
}

func (x *ListRequest) GetOrderFiled() ListRequest_OrderField {
	if x != nil {
		return x.OrderFiled
	}
	return ListRequest_CREATED_AT
}

func (x *ListRequest) GetOrderDirection() ListRequest_OrderDirection {
	if x != nil {
		return x.OrderDirection
	}
	return ListRequest_ASC
}

// Сущность ответа на получение списка пользователей
type ListResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Список пользователей
	Items []*User `protobuf:"bytes,1,rep,name=items,proto3" json:"items,omitempty"`
	// Количество пользователей (по заданному фильтру)
	Total uint64 `protobuf:"varint,2,opt,name=total,proto3" json:"total,omitempty"`
}

func (x *ListResponse) Reset() {
	*x = ListResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListResponse) ProtoMessage() {}

func (x *ListResponse) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListResponse.ProtoReflect.Descriptor instead.
func (*ListResponse) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{1}
}

func (x *ListResponse) GetItems() []*User {
	if x != nil {
		return x.Items
	}
	return nil
}

func (x *ListResponse) GetTotal() uint64 {
	if x != nil {
		return x.Total
	}
	return 0
}

// Сущность запроса на создание пользователя
type CreateRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Имя пользователя
	Name *string `protobuf:"bytes,1,opt,name=name,proto3,oneof" json:"name,omitempty"`
	// Идентификатор группы пользователя
	GroupId *string `protobuf:"bytes,2,opt,name=group_id,json=groupId,proto3,oneof" json:"group_id,omitempty"`
	// Тип пользователя
	Type *UserType `protobuf:"varint,3,opt,name=type,proto3,enum=users.UserType,oneof" json:"type,omitempty"`
}

func (x *CreateRequest) Reset() {
	*x = CreateRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[2]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *CreateRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*CreateRequest) ProtoMessage() {}

func (x *CreateRequest) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[2]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use CreateRequest.ProtoReflect.Descriptor instead.
func (*CreateRequest) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{2}
}

func (x *CreateRequest) GetName() string {
	if x != nil && x.Name != nil {
		return *x.Name
	}
	return ""
}

func (x *CreateRequest) GetGroupId() string {
	if x != nil && x.GroupId != nil {
		return *x.GroupId
	}
	return ""
}

func (x *CreateRequest) GetType() UserType {
	if x != nil && x.Type != nil {
		return *x.Type
	}
	return UserType_USER_TYPE_UNKNOWN
}

// Сущность ответа на создание пользователя
type CreateResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Созданный пользователь
	User *User `protobuf:"bytes,1,opt,name=user,proto3" json:"user,omitempty"`
}

func (x *CreateResponse) Reset() {
	*x = CreateResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[3]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *CreateResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*CreateResponse) ProtoMessage() {}

func (x *CreateResponse) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[3]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use CreateResponse.ProtoReflect.Descriptor instead.
func (*CreateResponse) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{3}
}

func (x *CreateResponse) GetUser() *User {
	if x != nil {
		return x.User
	}
	return nil
}

// Сущность пользователя
type User struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Идентификатор пользователя
	Id string `protobuf:"bytes,1,opt,name=id,proto3" json:"id,omitempty"`
	// Наименование пользователя
	Name *string `protobuf:"bytes,2,opt,name=name,proto3,oneof" json:"name,omitempty"`
	// Идентификатор группы
	GroupId *string `protobuf:"bytes,3,opt,name=group_id,json=groupId,proto3,oneof" json:"group_id,omitempty"`
	// Группа
	Group *groups.Group `protobuf:"bytes,4,opt,name=group,proto3" json:"group,omitempty"`
	// Тип пользователя
	Type UserType `protobuf:"varint,5,opt,name=type,proto3,enum=users.UserType" json:"type,omitempty"`
	// Дата создания пользователя
	CreatedAt *timestamppb.Timestamp `protobuf:"bytes,6,opt,name=created_at,json=createdAt,proto3" json:"created_at,omitempty"`
	// Дата обновления пользователя
	UpdatedAt *timestamppb.Timestamp `protobuf:"bytes,7,opt,name=updated_at,json=updatedAt,proto3" json:"updated_at,omitempty"`
	// Дата удаления пользователя
	DeletedAt *timestamppb.Timestamp `protobuf:"bytes,8,opt,name=deleted_at,json=deletedAt,proto3" json:"deleted_at,omitempty"`
}

func (x *User) Reset() {
	*x = User{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[4]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *User) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*User) ProtoMessage() {}

func (x *User) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[4]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use User.ProtoReflect.Descriptor instead.
func (*User) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{4}
}

func (x *User) GetId() string {
	if x != nil {
		return x.Id
	}
	return ""
}

func (x *User) GetName() string {
	if x != nil && x.Name != nil {
		return *x.Name
	}
	return ""
}

func (x *User) GetGroupId() string {
	if x != nil && x.GroupId != nil {
		return *x.GroupId
	}
	return ""
}

func (x *User) GetGroup() *groups.Group {
	if x != nil {
		return x.Group
	}
	return nil
}

func (x *User) GetType() UserType {
	if x != nil {
		return x.Type
	}
	return UserType_USER_TYPE_UNKNOWN
}

func (x *User) GetCreatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.CreatedAt
	}
	return nil
}

func (x *User) GetUpdatedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.UpdatedAt
	}
	return nil
}

func (x *User) GetDeletedAt() *timestamppb.Timestamp {
	if x != nil {
		return x.DeletedAt
	}
	return nil
}

// Сущность фильтра к запросу
type ListRequest_Filter struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// Список идентификаторов пользователей
	IdIn []string `protobuf:"bytes,1,rep,name=id_in,json=idIn,proto3" json:"id_in,omitempty"`
	// Список идентификаторов групп
	GroupIn []string `protobuf:"bytes,2,rep,name=group_in,json=groupIn,proto3" json:"group_in,omitempty"`
	// Список типов пользователей
	UserTypeIn []UserType `protobuf:"varint,3,rep,packed,name=user_type_in,json=userTypeIn,proto3,enum=users.UserType" json:"user_type_in,omitempty"`
	// Сходство по имени
	NameLike *string `protobuf:"bytes,4,opt,name=name_like,json=nameLike,proto3,oneof" json:"name_like,omitempty"`
}

func (x *ListRequest_Filter) Reset() {
	*x = ListRequest_Filter{}
	if protoimpl.UnsafeEnabled {
		mi := &file_users_users_proto_msgTypes[5]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *ListRequest_Filter) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*ListRequest_Filter) ProtoMessage() {}

func (x *ListRequest_Filter) ProtoReflect() protoreflect.Message {
	mi := &file_users_users_proto_msgTypes[5]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use ListRequest_Filter.ProtoReflect.Descriptor instead.
func (*ListRequest_Filter) Descriptor() ([]byte, []int) {
	return file_users_users_proto_rawDescGZIP(), []int{0, 0}
}

func (x *ListRequest_Filter) GetIdIn() []string {
	if x != nil {
		return x.IdIn
	}
	return nil
}

func (x *ListRequest_Filter) GetGroupIn() []string {
	if x != nil {
		return x.GroupIn
	}
	return nil
}

func (x *ListRequest_Filter) GetUserTypeIn() []UserType {
	if x != nil {
		return x.UserTypeIn
	}
	return nil
}

func (x *ListRequest_Filter) GetNameLike() string {
	if x != nil && x.NameLike != nil {
		return *x.NameLike
	}
	return ""
}

var File_users_users_proto protoreflect.FileDescriptor

var file_users_users_proto_rawDesc = []byte{
	0x0a, 0x11, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2f, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x12, 0x05, 0x75, 0x73, 0x65, 0x72, 0x73, 0x1a, 0x1f, 0x67, 0x6f, 0x6f, 0x67,
	0x6c, 0x65, 0x2f, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2f, 0x74, 0x69, 0x6d, 0x65,
	0x73, 0x74, 0x61, 0x6d, 0x70, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x1a, 0x13, 0x67, 0x72, 0x6f,
	0x75, 0x70, 0x73, 0x2f, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x73, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f,
	0x22, 0xeb, 0x03, 0x0a, 0x0b, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x12, 0x31, 0x0a, 0x06, 0x66, 0x69, 0x6c, 0x74, 0x65, 0x72, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b,
	0x32, 0x19, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71,
	0x75, 0x65, 0x73, 0x74, 0x2e, 0x46, 0x69, 0x6c, 0x74, 0x65, 0x72, 0x52, 0x06, 0x66, 0x69, 0x6c,
	0x74, 0x65, 0x72, 0x12, 0x14, 0x0a, 0x05, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x18, 0x02, 0x20, 0x01,
	0x28, 0x04, 0x52, 0x05, 0x6c, 0x69, 0x6d, 0x69, 0x74, 0x12, 0x16, 0x0a, 0x06, 0x6f, 0x66, 0x66,
	0x73, 0x65, 0x74, 0x18, 0x03, 0x20, 0x01, 0x28, 0x04, 0x52, 0x06, 0x6f, 0x66, 0x66, 0x73, 0x65,
	0x74, 0x12, 0x3e, 0x0a, 0x0b, 0x6f, 0x72, 0x64, 0x65, 0x72, 0x5f, 0x66, 0x69, 0x6c, 0x65, 0x64,
	0x18, 0x04, 0x20, 0x01, 0x28, 0x0e, 0x32, 0x1d, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x4c,
	0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x2e, 0x4f, 0x72, 0x64, 0x65, 0x72,
	0x46, 0x69, 0x65, 0x6c, 0x64, 0x52, 0x0a, 0x6f, 0x72, 0x64, 0x65, 0x72, 0x46, 0x69, 0x6c, 0x65,
	0x64, 0x12, 0x4a, 0x0a, 0x0f, 0x6f, 0x72, 0x64, 0x65, 0x72, 0x5f, 0x64, 0x69, 0x72, 0x65, 0x63,
	0x74, 0x69, 0x6f, 0x6e, 0x18, 0x05, 0x20, 0x01, 0x28, 0x0e, 0x32, 0x21, 0x2e, 0x75, 0x73, 0x65,
	0x72, 0x73, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x2e, 0x4f,
	0x72, 0x64, 0x65, 0x72, 0x44, 0x69, 0x72, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x52, 0x0e, 0x6f,
	0x72, 0x64, 0x65, 0x72, 0x44, 0x69, 0x72, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x1a, 0x9b, 0x01,
	0x0a, 0x06, 0x46, 0x69, 0x6c, 0x74, 0x65, 0x72, 0x12, 0x13, 0x0a, 0x05, 0x69, 0x64, 0x5f, 0x69,
	0x6e, 0x18, 0x01, 0x20, 0x03, 0x28, 0x09, 0x52, 0x04, 0x69, 0x64, 0x49, 0x6e, 0x12, 0x19, 0x0a,
	0x08, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f, 0x69, 0x6e, 0x18, 0x02, 0x20, 0x03, 0x28, 0x09, 0x52,
	0x07, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x49, 0x6e, 0x12, 0x31, 0x0a, 0x0c, 0x75, 0x73, 0x65, 0x72,
	0x5f, 0x74, 0x79, 0x70, 0x65, 0x5f, 0x69, 0x6e, 0x18, 0x03, 0x20, 0x03, 0x28, 0x0e, 0x32, 0x0f,
	0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x55, 0x73, 0x65, 0x72, 0x54, 0x79, 0x70, 0x65, 0x52,
	0x0a, 0x75, 0x73, 0x65, 0x72, 0x54, 0x79, 0x70, 0x65, 0x49, 0x6e, 0x12, 0x20, 0x0a, 0x09, 0x6e,
	0x61, 0x6d, 0x65, 0x5f, 0x6c, 0x69, 0x6b, 0x65, 0x18, 0x04, 0x20, 0x01, 0x28, 0x09, 0x48, 0x00,
	0x52, 0x08, 0x6e, 0x61, 0x6d, 0x65, 0x4c, 0x69, 0x6b, 0x65, 0x88, 0x01, 0x01, 0x42, 0x0c, 0x0a,
	0x0a, 0x5f, 0x6e, 0x61, 0x6d, 0x65, 0x5f, 0x6c, 0x69, 0x6b, 0x65, 0x22, 0x2c, 0x0a, 0x0a, 0x4f,
	0x72, 0x64, 0x65, 0x72, 0x46, 0x69, 0x65, 0x6c, 0x64, 0x12, 0x0e, 0x0a, 0x0a, 0x43, 0x52, 0x45,
	0x41, 0x54, 0x45, 0x44, 0x5f, 0x41, 0x54, 0x10, 0x00, 0x12, 0x0e, 0x0a, 0x0a, 0x55, 0x50, 0x44,
	0x41, 0x54, 0x45, 0x44, 0x5f, 0x41, 0x54, 0x10, 0x01, 0x22, 0x23, 0x0a, 0x0e, 0x4f, 0x72, 0x64,
	0x65, 0x72, 0x44, 0x69, 0x72, 0x65, 0x63, 0x74, 0x69, 0x6f, 0x6e, 0x12, 0x07, 0x0a, 0x03, 0x41,
	0x53, 0x43, 0x10, 0x00, 0x12, 0x08, 0x0a, 0x04, 0x44, 0x45, 0x53, 0x43, 0x10, 0x01, 0x22, 0x47,
	0x0a, 0x0c, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x21,
	0x0a, 0x05, 0x69, 0x74, 0x65, 0x6d, 0x73, 0x18, 0x01, 0x20, 0x03, 0x28, 0x0b, 0x32, 0x0b, 0x2e,
	0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x55, 0x73, 0x65, 0x72, 0x52, 0x05, 0x69, 0x74, 0x65, 0x6d,
	0x73, 0x12, 0x14, 0x0a, 0x05, 0x74, 0x6f, 0x74, 0x61, 0x6c, 0x18, 0x02, 0x20, 0x01, 0x28, 0x04,
	0x52, 0x05, 0x74, 0x6f, 0x74, 0x61, 0x6c, 0x22, 0x91, 0x01, 0x0a, 0x0d, 0x43, 0x72, 0x65, 0x61,
	0x74, 0x65, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x12, 0x17, 0x0a, 0x04, 0x6e, 0x61, 0x6d,
	0x65, 0x18, 0x01, 0x20, 0x01, 0x28, 0x09, 0x48, 0x00, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x88,
	0x01, 0x01, 0x12, 0x1e, 0x0a, 0x08, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f, 0x69, 0x64, 0x18, 0x02,
	0x20, 0x01, 0x28, 0x09, 0x48, 0x01, 0x52, 0x07, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x49, 0x64, 0x88,
	0x01, 0x01, 0x12, 0x28, 0x0a, 0x04, 0x74, 0x79, 0x70, 0x65, 0x18, 0x03, 0x20, 0x01, 0x28, 0x0e,
	0x32, 0x0f, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x55, 0x73, 0x65, 0x72, 0x54, 0x79, 0x70,
	0x65, 0x48, 0x02, 0x52, 0x04, 0x74, 0x79, 0x70, 0x65, 0x88, 0x01, 0x01, 0x42, 0x07, 0x0a, 0x05,
	0x5f, 0x6e, 0x61, 0x6d, 0x65, 0x42, 0x0b, 0x0a, 0x09, 0x5f, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f,
	0x69, 0x64, 0x42, 0x07, 0x0a, 0x05, 0x5f, 0x74, 0x79, 0x70, 0x65, 0x22, 0x31, 0x0a, 0x0e, 0x43,
	0x72, 0x65, 0x61, 0x74, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x1f, 0x0a,
	0x04, 0x75, 0x73, 0x65, 0x72, 0x18, 0x01, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x0b, 0x2e, 0x75, 0x73,
	0x65, 0x72, 0x73, 0x2e, 0x55, 0x73, 0x65, 0x72, 0x52, 0x04, 0x75, 0x73, 0x65, 0x72, 0x22, 0xe0,
	0x02, 0x0a, 0x04, 0x55, 0x73, 0x65, 0x72, 0x12, 0x0e, 0x0a, 0x02, 0x69, 0x64, 0x18, 0x01, 0x20,
	0x01, 0x28, 0x09, 0x52, 0x02, 0x69, 0x64, 0x12, 0x17, 0x0a, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x18,
	0x02, 0x20, 0x01, 0x28, 0x09, 0x48, 0x00, 0x52, 0x04, 0x6e, 0x61, 0x6d, 0x65, 0x88, 0x01, 0x01,
	0x12, 0x1e, 0x0a, 0x08, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f, 0x69, 0x64, 0x18, 0x03, 0x20, 0x01,
	0x28, 0x09, 0x48, 0x01, 0x52, 0x07, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x49, 0x64, 0x88, 0x01, 0x01,
	0x12, 0x23, 0x0a, 0x05, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x18, 0x04, 0x20, 0x01, 0x28, 0x0b, 0x32,
	0x0d, 0x2e, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x73, 0x2e, 0x47, 0x72, 0x6f, 0x75, 0x70, 0x52, 0x05,
	0x67, 0x72, 0x6f, 0x75, 0x70, 0x12, 0x23, 0x0a, 0x04, 0x74, 0x79, 0x70, 0x65, 0x18, 0x05, 0x20,
	0x01, 0x28, 0x0e, 0x32, 0x0f, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x55, 0x73, 0x65, 0x72,
	0x54, 0x79, 0x70, 0x65, 0x52, 0x04, 0x74, 0x79, 0x70, 0x65, 0x12, 0x39, 0x0a, 0x0a, 0x63, 0x72,
	0x65, 0x61, 0x74, 0x65, 0x64, 0x5f, 0x61, 0x74, 0x18, 0x06, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a,
	0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66,
	0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x09, 0x63, 0x72, 0x65, 0x61,
	0x74, 0x65, 0x64, 0x41, 0x74, 0x12, 0x39, 0x0a, 0x0a, 0x75, 0x70, 0x64, 0x61, 0x74, 0x65, 0x64,
	0x5f, 0x61, 0x74, 0x18, 0x07, 0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67,
	0x6c, 0x65, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65,
	0x73, 0x74, 0x61, 0x6d, 0x70, 0x52, 0x09, 0x75, 0x70, 0x64, 0x61, 0x74, 0x65, 0x64, 0x41, 0x74,
	0x12, 0x39, 0x0a, 0x0a, 0x64, 0x65, 0x6c, 0x65, 0x74, 0x65, 0x64, 0x5f, 0x61, 0x74, 0x18, 0x08,
	0x20, 0x01, 0x28, 0x0b, 0x32, 0x1a, 0x2e, 0x67, 0x6f, 0x6f, 0x67, 0x6c, 0x65, 0x2e, 0x70, 0x72,
	0x6f, 0x74, 0x6f, 0x62, 0x75, 0x66, 0x2e, 0x54, 0x69, 0x6d, 0x65, 0x73, 0x74, 0x61, 0x6d, 0x70,
	0x52, 0x09, 0x64, 0x65, 0x6c, 0x65, 0x74, 0x65, 0x64, 0x41, 0x74, 0x42, 0x07, 0x0a, 0x05, 0x5f,
	0x6e, 0x61, 0x6d, 0x65, 0x42, 0x0b, 0x0a, 0x09, 0x5f, 0x67, 0x72, 0x6f, 0x75, 0x70, 0x5f, 0x69,
	0x64, 0x2a, 0x36, 0x0a, 0x08, 0x55, 0x73, 0x65, 0x72, 0x54, 0x79, 0x70, 0x65, 0x12, 0x15, 0x0a,
	0x11, 0x55, 0x53, 0x45, 0x52, 0x5f, 0x54, 0x59, 0x50, 0x45, 0x5f, 0x55, 0x4e, 0x4b, 0x4e, 0x4f,
	0x57, 0x4e, 0x10, 0x00, 0x12, 0x09, 0x0a, 0x05, 0x41, 0x44, 0x4d, 0x49, 0x4e, 0x10, 0x01, 0x12,
	0x08, 0x0a, 0x04, 0x55, 0x53, 0x45, 0x52, 0x10, 0x02, 0x32, 0x73, 0x0a, 0x05, 0x55, 0x73, 0x65,
	0x72, 0x73, 0x12, 0x31, 0x0a, 0x04, 0x4c, 0x69, 0x73, 0x74, 0x12, 0x12, 0x2e, 0x75, 0x73, 0x65,
	0x72, 0x73, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x13,
	0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x4c, 0x69, 0x73, 0x74, 0x52, 0x65, 0x73, 0x70, 0x6f,
	0x6e, 0x73, 0x65, 0x22, 0x00, 0x12, 0x37, 0x0a, 0x06, 0x43, 0x72, 0x65, 0x61, 0x74, 0x65, 0x12,
	0x14, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x43, 0x72, 0x65, 0x61, 0x74, 0x65, 0x52, 0x65,
	0x71, 0x75, 0x65, 0x73, 0x74, 0x1a, 0x15, 0x2e, 0x75, 0x73, 0x65, 0x72, 0x73, 0x2e, 0x43, 0x72,
	0x65, 0x61, 0x74, 0x65, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x22, 0x00, 0x42, 0x34,
	0x5a, 0x32, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x73, 0x69, 0x6d,
	0x70, 0x6c, 0x65, 0x47, 0x72, 0x70, 0x63, 0x41, 0x70, 0x70, 0x2f, 0x75, 0x73, 0x65, 0x72, 0x73,
	0x2f, 0x70, 0x6b, 0x67, 0x2f, 0x61, 0x70, 0x69, 0x2f, 0x75, 0x73, 0x65, 0x72, 0x73, 0x3b, 0x75,
	0x73, 0x65, 0x72, 0x73, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_users_users_proto_rawDescOnce sync.Once
	file_users_users_proto_rawDescData = file_users_users_proto_rawDesc
)

func file_users_users_proto_rawDescGZIP() []byte {
	file_users_users_proto_rawDescOnce.Do(func() {
		file_users_users_proto_rawDescData = protoimpl.X.CompressGZIP(file_users_users_proto_rawDescData)
	})
	return file_users_users_proto_rawDescData
}

var file_users_users_proto_enumTypes = make([]protoimpl.EnumInfo, 3)
var file_users_users_proto_msgTypes = make([]protoimpl.MessageInfo, 6)
var file_users_users_proto_goTypes = []interface{}{
	(UserType)(0),                   // 0: users.UserType
	(ListRequest_OrderField)(0),     // 1: users.ListRequest.OrderField
	(ListRequest_OrderDirection)(0), // 2: users.ListRequest.OrderDirection
	(*ListRequest)(nil),             // 3: users.ListRequest
	(*ListResponse)(nil),            // 4: users.ListResponse
	(*CreateRequest)(nil),           // 5: users.CreateRequest
	(*CreateResponse)(nil),          // 6: users.CreateResponse
	(*User)(nil),                    // 7: users.User
	(*ListRequest_Filter)(nil),      // 8: users.ListRequest.Filter
	(*groups.Group)(nil),            // 9: groups.Group
	(*timestamppb.Timestamp)(nil),   // 10: google.protobuf.Timestamp
}
var file_users_users_proto_depIdxs = []int32{
	8,  // 0: users.ListRequest.filter:type_name -> users.ListRequest.Filter
	1,  // 1: users.ListRequest.order_filed:type_name -> users.ListRequest.OrderField
	2,  // 2: users.ListRequest.order_direction:type_name -> users.ListRequest.OrderDirection
	7,  // 3: users.ListResponse.items:type_name -> users.User
	0,  // 4: users.CreateRequest.type:type_name -> users.UserType
	7,  // 5: users.CreateResponse.user:type_name -> users.User
	9,  // 6: users.User.group:type_name -> groups.Group
	0,  // 7: users.User.type:type_name -> users.UserType
	10, // 8: users.User.created_at:type_name -> google.protobuf.Timestamp
	10, // 9: users.User.updated_at:type_name -> google.protobuf.Timestamp
	10, // 10: users.User.deleted_at:type_name -> google.protobuf.Timestamp
	0,  // 11: users.ListRequest.Filter.user_type_in:type_name -> users.UserType
	3,  // 12: users.Users.List:input_type -> users.ListRequest
	5,  // 13: users.Users.Create:input_type -> users.CreateRequest
	4,  // 14: users.Users.List:output_type -> users.ListResponse
	6,  // 15: users.Users.Create:output_type -> users.CreateResponse
	14, // [14:16] is the sub-list for method output_type
	12, // [12:14] is the sub-list for method input_type
	12, // [12:12] is the sub-list for extension type_name
	12, // [12:12] is the sub-list for extension extendee
	0,  // [0:12] is the sub-list for field type_name
}

func init() { file_users_users_proto_init() }
func file_users_users_proto_init() {
	if File_users_users_proto != nil {
		return
	}
	if !protoimpl.UnsafeEnabled {
		file_users_users_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_users_users_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_users_users_proto_msgTypes[2].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*CreateRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_users_users_proto_msgTypes[3].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*CreateResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_users_users_proto_msgTypes[4].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*User); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_users_users_proto_msgTypes[5].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*ListRequest_Filter); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	file_users_users_proto_msgTypes[2].OneofWrappers = []interface{}{}
	file_users_users_proto_msgTypes[4].OneofWrappers = []interface{}{}
	file_users_users_proto_msgTypes[5].OneofWrappers = []interface{}{}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_users_users_proto_rawDesc,
			NumEnums:      3,
			NumMessages:   6,
			NumExtensions: 0,
			NumServices:   1,
		},
		GoTypes:           file_users_users_proto_goTypes,
		DependencyIndexes: file_users_users_proto_depIdxs,
		EnumInfos:         file_users_users_proto_enumTypes,
		MessageInfos:      file_users_users_proto_msgTypes,
	}.Build()
	File_users_users_proto = out.File
	file_users_users_proto_rawDesc = nil
	file_users_users_proto_goTypes = nil
	file_users_users_proto_depIdxs = nil
}
