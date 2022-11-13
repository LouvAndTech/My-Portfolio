## Build
FROM golang:1.19.3-alpine3.16 AS build

WORKDIR /

# Build the backend
# Copy the dependencies list
COPY ./My-Portfolio-back/go.mod ./
COPY ./My-Portfolio-back/go.sum ./
# Install dependencies
RUN go mod download
#Copy the backend code
COPY ./My-Portfolio-back/*.go ./
# Build the backend
RUN CGO_ENABLED=0 go build -o ./backend-exe


##Deploy
FROM gcr.io/distroless/base-debian10

#create a directory for the app
WORKDIR /

# Copy the backend binary
COPY --from=build /backend-exe ./
# Copy the frontend Code
COPY ./My-Portfolio-front/dist/portfolio ./pb_public/
# Expose the port
EXPOSE 8090

# Execute the backend
CMD [ "./backend-exe", "serve", "--http", "0.0.0.0:8090" ]