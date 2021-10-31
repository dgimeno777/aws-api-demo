from api.src.colors import get_random_color, Color


def test_get_random_color():
    # Define/Do
    random_color = get_random_color()

    # Determine
    assert random_color in Color
