# 使用 Maven 构建镜像
FROM maven:3.8.6-openjdk-17 AS build

# 设置工作目录
WORKDIR /app

# 复制 pom.xml 和依赖
COPY pom.xml .
COPY src ./src

# 使用 Maven 安装依赖并编译项目
RUN mvn clean package -DskipTests

# 使用 JAR 文件创建运行镜像
FROM openjdk:17-jdk-slim

# 将构建好的 JAR 文件复制到新镜像中
COPY --from=build /app/target/gitlab-tinybee-1.0-SNAPSHOT.jar /app/gitlab-tinybee.jar

# 设置默认命令
CMD ["java", "-jar", "/app/gitlab-tinybee.jar"]
