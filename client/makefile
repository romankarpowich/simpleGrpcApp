generate:
	protoc --go_out=internal/pb \
	--go_opt=Mgithub.com/romankrapowich/SimpleGrpcApp/users/api/users/users.proto=internal/pb \
  --go_opt=Mgithub.com/romankrapowich/github.com/SimpleGrpcApp/users/api/groups/groups.proto=internal/pb \
  --go-grpc_out=internal/pb \
   --go-grpc_opt=Mgithub.com/romankrapowich/SimpleGrpcApp/users/api/users/users.proto=internal/pb \
  --go-grpc_opt=Mgithub.com/romankrapowich/SimpleGrpcApp/users/api/groups/groups.proto=internal/pb \
  --proto_path=/Users/rkarpovich/GolandProjects/simpleGrpcApp/users/api/ \
  /Users/rkarpovich/GolandProjects/simpleGrpcApp/users/api/users/users.proto /Users/rkarpovich/GolandProjects/simpleGrpcApp/users/api/groups/groups.proto