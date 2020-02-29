docker build -t jonathanfeller/multi-client:latest -t jonathanfeller/multi-client-:$SHA -f ./client/Dockerfile ./client
docker build -t jonathanfeller/multi-server:latest -t jonathanfeller/multi-server-:$SHA -f ./server/Dockerfile ./server
docker build -t jonathanfeller/multi-worker:latest -t jonathanfeller/multi-worker-:$SHA -f ./worker/Dockerfile ./worker

docker push jonathanfeller/multi-client:latest
docker push jonathanfeller/multi-server:latest
docker push jonathanfeller/multi-worker:latest

docker push jonathanfeller/multi-client:$SHA
docker push jonathanfeller/multi-server:$SHA
docker push jonathanfeller/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=jonathanfeller/multi-client:$SHA
kubectl set image deployments/server-deployment server=jonathanfeller/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=jonathanfeller/multi-worker:$SHA