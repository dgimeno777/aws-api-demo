import json
from api.src.colors import get_random_color


def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps(get_random_color().value)
    }
