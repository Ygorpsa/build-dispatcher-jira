FROM gcr.io/monitoria-groovetech/gobuild:1.0.0.4f8730f as build

ARG MAIN_REPO_NAME=""

WORKDIR /go/src/github.com/GrooveCommunity/

RUN git clone https://github.com/GrooveCommunity/${MAIN_REPO_NAME}.git 

WORKDIR /go/src/github.com/GrooveCommunity/${MAIN_REPO_NAME}/cmd

RUN go build -o /etc/bin/dispatcher-jira

FROM gcr.io/monitoria-groovetech/run-application:1.0.0.5a32ad0 

ARG APP_PORT=""
ENV APP_PORT=${APP_PORT}

EXPOSE ${APP_PORT}

COPY --from=build /etc/bin/dispatcher-jira /app/dispatcher-jira

ENTRYPOINT ["/app/dispatcher-jira"]