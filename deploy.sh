docker build -t sangw0804/multi-client:latest -t sangw0804/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sangw0804/multi-server:latest -t sangw0804/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sangw0804/multi-worker:latest -t sangw0804/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sangw0804/multi-client:latest
docker push sangw0804/multi-server:latest
docker push sangw0804/multi-worker:latest

docker push sangw0804/multi-client:$SHA
docker push sangw0804/multi-server:$SHA
docker push sangw0804/multi-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployments/server-deployment server=sangw0804/multi-server:$SHA
kubectl set image deployments/client-deployment client=sangw0804/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sangw0804/multi-worker:$SHA