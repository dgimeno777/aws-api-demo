#!/bin/sh
if [ -z "${AWS_LAMBDA_RUNTIME_API}" ]; then
  exec /usr/local/bin/aws-lambda-rie /home/docker/.venv/bin/python -m awslambdaric $@
else
  exec /home/docker/.venv/bin/python -m awslambdaric $@
fi
