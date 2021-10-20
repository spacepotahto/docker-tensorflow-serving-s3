FROM tensorflow/serving

# Install AWS CLI
RUN apt-get update && apt-get install -y curl unzip
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
&& unzip awscliv2.zip \
&& ./aws/install

# Create entrypoint script in order to use env vars
# Downloads model from S3 to appropriate location 
# and invokes the original parent image's entrypoint script
RUN echo '#!/bin/bash \n\n\
aws --endpoint ${S3_ENDPOINT} s3 cp ${S3_URI} ${MODEL_BASE_PATH}/${MODEL_NAME} --recursive \n\
exec /usr/bin/tf_serving_entrypoint.sh \
"$@"' > /usr/bin/entrypoint.sh \
&& chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]