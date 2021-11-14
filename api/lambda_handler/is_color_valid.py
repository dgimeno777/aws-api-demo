import json
from api.src.colors import is_color_valid


def lambda_handler(event, context):
    print(event)
    return {
        "statusCode": 200,
        "body": json.dumps("hit")
    }
