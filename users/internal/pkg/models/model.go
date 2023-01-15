package models

// ToProtoConverter .
type ToProtoConverter[T comparable] interface {
	ConvertToProto() T
}

// ConvertToSliceOfProto .
func ConvertToSliceOfProto[T ToProtoConverter[P], P comparable](items []T) []P {
	res := make([]P, len(items))
	for i, v := range items {
		res[i] = v.ConvertToProto()
	}
	return res
}
