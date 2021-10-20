# docker-tensorflow-serving-s3

Tensorflow Serving image that automatically pulls the model from S3. Usage example:

```
docker run -t --rm -p 8501:8501 \
    -e AWS_ACCESS_KEY_ID="key" \
    -e AWS_SECRET_ACCESS_KEY="secret" \
    -e S3_ENDPOINT="https://s3.filebase.com" \
    -e S3_URI="s3://bucket/project/models/model-name" \
    -e MODEL_NAME="model-name" \
    tensorflow-serving-s3:0.1.0
```