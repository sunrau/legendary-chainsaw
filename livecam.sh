#!/bin/bash

# Kill any process using /dev/video0
fuser -k /dev/video0

# Directory to serve
DIR=./webcam_stream
mkdir -p "$DIR"

# Create the index.html with 2-second auto-refresh
cat > "$DIR/index.html" <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Webcam Live</title>
  <meta http-equiv="refresh" content="2">
  <style>
    body {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      height: 100vh;
      margin: 0;
      font-family: sans-serif;
      background-color: #f0f0f0;
    }
    img {
      max-width: 100%;
      height: auto;
      border: 2px solid #ccc;
      border-radius: 8px;
    }
    h1 {
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <h1>Live Webcam (updates every 2 seconds)</h1>
  <img src="webcam.jpg" alt="webcam" />
</body>
</html>
EOF


# Run fswebcam in background to update webcam.jpg every 2 seconds
(
  while true; do
    fswebcam -r 640x480 --no-banner "$DIR/webcam.jpg"
    sleep 2
  done
) &

# Serve the directory on port 9090 (using Python3 HTTP server)
cd "$DIR"
echo "Starting HTTP server at http://localhost:9090"
python3 -m http.server 9090
