from api.src.colors import get_random_color


def get_random_color_handler(event, context):
    return get_random_color()
