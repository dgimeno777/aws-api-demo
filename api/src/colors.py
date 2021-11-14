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


def is_color_valid(color: str) -> bool:
    """
    Whether or not the given color is valid
    :param color: the color as a string
    :return: whether or not the color is valid
    """
    return color in Color
