docker build -t robsonrc/multi-client:latest -t robsonrc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t robsonrc/multi-server:latest -t robsonrc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t robsonrc/multi-worker:latest -t robsonrc/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push robsonrc/multi-client:latest
docker push robsonrc/multi-server:latest
docker push robsonrc/multi-worker:latest

docker push robsonrc/multi-client:$SHA
docker push robsonrc/multi-server:$SHA
docker push robsonrc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=robsonrc/multi-server:$SHA
kubectl set image deployments/client-deployment client=robsonrc/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=robsonrc/multi-worker:$SHA
