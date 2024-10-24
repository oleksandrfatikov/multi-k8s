docker build -t portasanych/multi-client -t portasanych/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t portasanych/multi-server -t portasanych/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t portasanych/multi-worker -t portasanych/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push portasanych/multi-client
docker push portasanych/multi-client:$SHA
docker push portasanych/multi-server
docker push portasanych/multi-server:$SHA
docker push portasanych/multi-worker
docker push portasanych/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment -n udemy-course server=portasanych/multi-server:$SHA
kubectl set image deployments/client-deployment -n udemy-course client=portasanych/multi-client:$SHA
kubectl set image deployments/worker-deployment -n udemy-course worker=portasanych/multi-worker:$SHA
