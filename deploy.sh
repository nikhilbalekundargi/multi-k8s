docker build -t nikhilgb/multi-client:latest -t nikhilgb/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikhilgb/multi-server:latest -t nikhilgb/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikhilgb/multi-worker:latest -t nikhilgb/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nikhilgb/multi-client:latest
docker push nikhilgb/multi-server:latest
docker push nikhilgb/multi-worker:latest
docker push nikhilgb/multi-client:$SHA
docker push nikhilgb/multi-server:$SHA
docker push nikhilgb/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikhilgb/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikhilgb/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikhilgb/multi-worker:$SHA