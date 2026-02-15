# Stage 1: Build
FROM eclipse-temurin:21-jdk AS build

RUN apt-get update && apt-get install -y curl unzip && \
    curl -fsSL "https://github.com/sbt/sbt/releases/download/v1.10.7/sbt-1.10.7.tgz" | tar xz -C /opt && \
    ln -s /opt/sbt/bin/sbt /usr/local/bin/sbt && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Cache dependencies by copying build files first
COPY build.sbt .
COPY project/build.properties project/
COPY project/plugins.sbt project/
RUN sbt update

# Copy source and build
COPY . .
RUN sbt dist

# Unzip the distribution
RUN unzip -o target/universal/*.zip -d /opt && \
    mv /opt/keithjarrett-net-* /opt/app

# Stage 2: Runtime
FROM eclipse-temurin:21-jre

WORKDIR /opt/app

COPY --from=build /opt/app /opt/app

RUN chmod +x /opt/app/bin/keithjarrett-net

EXPOSE 9000

ENTRYPOINT /opt/app/bin/keithjarrett-net -Dplay.http.secret.key=$APPLICATION_SECRET
