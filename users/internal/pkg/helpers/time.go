package helpers

import (
	"google.golang.org/protobuf/types/known/timestamppb"
	"gopkg.in/guregu/null.v4/zero"
	"time"
)

// TimestamppbPtrFromZeroTime .
func TimestamppbPtrFromZeroTime(t zero.Time) *timestamppb.Timestamp {
	if t.Ptr() == nil {
		return nil
	}
	return timestamppb.New(t.Time)
}

// TimestamppbPtrTime .
func TimestamppbPtrTime(t time.Time) *timestamppb.Timestamp {
	if t.IsZero() {
		return nil
	}
	return timestamppb.New(t)
}
