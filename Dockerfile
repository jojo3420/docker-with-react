# 도커를 이용한 운영서버 운형
# 두개의 사이클로 분리하여 빌더 단계,
# 빌드된 소스를 nginx 운영서버 복사하여 베포 해보는 실습


# 운영서버에 배포하기윈한 빌드 단계
FROM node:alpine as builder

WORKDIR '/usr/src/app'

COPY package.json ./

RUN npm install

COPY ./ ./

RUN npm run build


# 운영 서버에 배포단계
FROM nginx

# builder 단계에서 빌딩한 소스(build) 를 nginx 배포디렉터리오 이동!
COPY --from=builder /usr/src/app/build /usr/share/nginx/html

# 이미지 생성
# $ docker build -t jjjhhhvvv/docker-react-app:latest ./

# 컨테이너 생성 및 실행
# $ docker run -p 3000:80 jjjhhhvvv/docker-react-app:latest