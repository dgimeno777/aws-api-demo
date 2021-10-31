import random
from enum import Enum


class Color(Enum):
    """ Represents a color """
    RED = "RED"
    WHITE = "WHITE"
    BLUE = "BLUE"
    GREEN = "GREEN"


def get_random_color() -> Color:
    """
    Gets a random Color enum member
    :return: a random Color enum member
    """
    return random.choice(list(Color))
