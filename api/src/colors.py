from enum import Enum
from random import randrange


class Color(Enum):
    RED = "RED"
    WHITE = "WHITE"
    BLUE = "BLUE"
    GREEN = "GREEN"


def get_random_color() -> Color:
    print(randrange(10))
