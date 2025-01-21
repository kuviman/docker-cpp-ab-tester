# Use a lightweight C++ image
FROM gcc:latest

# Set up the working directory
WORKDIR /app

# Copy test script and test cases into the container
COPY test.sh /app/test.sh
COPY tests /app/tests
RUN chmod +x /app/test.sh

# Ensure the output directory exists
RUN mkdir -p /outcome

# Run the test script on container start
ENTRYPOINT ["/app/test.sh"]
