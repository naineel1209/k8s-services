FROM golang:1.18 AS build

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

#COPY and build the application
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Final lightweight image
FROM scratch

# Set working directory
WORKDIR /app

# Copy built binary and static files
COPY --from=build /app/main .
COPY public/index.html public/index.html
COPY public/script.js public/script.js
COPY public/style.css public/style.css

# Expose port and specify the command to run
EXPOSE 3000
CMD ["./main"]