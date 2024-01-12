#!/usr/bin/python3
"""This module contains the Base class."""


class Base:
    """Class definition of the Base.
    This class will be the base of all other classes in the project.

    Attributes:
        id (int): Id the object.

    """

    __nb_objects = 0

    def __init__(self, id=None):
        """Constructor of the Base class

        Note:
            Type of id is not checked, it is assumed to be an integer.

        """
        if id is not None:
            self.id = id
        else:
            Base.__nb_objects += 1
            self.id = Base.__nb_objects

    @staticmethod
    def to_json_string(list_dictionaries):
        """Converts Python list of dictionaries to JSON String

        Args:
            list_dictionaries (list): List of  dictionaries

        Returns:
            If the list is empty or None, it returns '[]', otherwise it
            returns the JSON string representation of `list_dictionaries`.

        """
        import json

        if list_dictionaries is None or len(list_dictionaries) == 0:
            return "[]"
        return json.dumps(list_dictionaries)

    @staticmethod
    def from_json_string(json_string):
        """Converts JSON string to Python list.

        Args:
            json_string: JSON String Representation of list of dictionaries.

        Returns:
            List of dictionaries

        """
        import json

        if json_string is None or len(json_string) == 0:
            return []
        return json.loads(json_string)

    @classmethod
    def save_to_file(cls, list_objs):
        """Save the JSON string representation of a list of objects to a file

        Args:
            list_objs (list): List of objects that inherit from Base.

        """
        file_name = cls.__name__ + ".json"
        if type(list_objs) is list:  # noqa: E721
            list_dictionaries = [obj.to_dictionary() for obj in list_objs]
        else:
            list_dictionaries = []
        with open(file_name, "w", encoding="utf-8") as file:
            json_string = cls.to_json_string(list_dictionaries)
            file.write(json_string + "\n")

    @classmethod
    def load_from_file(cls):
        """Load instances from a JSON file"""
        file_name = cls.__name__ + ".json"
        try:
            with open(file_name, "r", encoding="utf-8") as file:
                list_dicts = cls.from_json_string(file.read().rstrip("\n"))
        except FileNotFoundError:
            list_dicts = []
        return [cls.create(**d) for d in list_dicts]

    @classmethod
    def create(cls, **dictionary):
        """Returns an instance with all attributes already set."""
        if cls.__name__ == "Rectangle":
            obj = cls(1, 1)
        else:
            obj = cls(1)
        obj.update(**dictionary)
        return obj

    @classmethod
    def save_to_file_csv(cls, list_objs):
        """Save the JSON string representation of a list of objects to a file.
           In CSV format.

        Args:
            list_objs (list): List of objects that inherit from Base.

        """
        file_name = cls.__name__ + ".csv"
        if type(list_objs) is list:  # noqa: E721
            list_dictionaries = [obj.to_dictionary() for obj in list_objs]
        else:
            list_dictionaries = []
        with open(file_name, "w", encoding="utf-8") as file:
            for d in list_dictionaries:
                id = d["id"]
                x = d["x"]
                y = d["y"]
                if cls.__name__ == "Rectangle":
                    width = d["width"]
                    height = d["height"]
                    csv_fmt = f"{id},{width},{height},{x},{y}\n"
                else:
                    size = d["size"]
                    csv_fmt = f"{id},{size},{x},{y}\n"
                file.write(csv_fmt)

    @classmethod
    def load_from_file_csv(cls):
        """Load instances from a CSV file"""
        file_name = cls.__name__ + ".csv"
        try:
            with open(file_name, "r", encoding="utf-8") as file:
                file_lines = file.readlines()
        except FileNotFoundError:
            file_lines = []
        list_dictionaries = []
        for line in file_lines:
            obj_values = line.split(",")
            if cls.__name__ == "Rectangle":
                obj_keys = ["id", "width", "height", "x", "y"]
            else:
                obj_keys = ["id", "size", "x", "y"]
            obj_dict = {
                obj_keys[i]: int(obj_values[i]) for i in range(len(obj_keys))
            }
            list_dictionaries.append(obj_dict)
        return [cls.create(**d) for d in list_dictionaries]

    @staticmethod
    def draw(list_rectangles, list_squares):
        """Draws the Rectangles and Squares on Turtle GUI"""
        import turtle

        # Set the shape of the turtle
        papi = turtle.Turtle()
        papi.shape("turtle")

        # Adjust screen and title
        screen = turtle.Screen()
        screen.title("Alx - Rectangles and Squares")

        # Adjust colors
        turtle.colormode(255)
        papi.color(161, 52, 52)
        screen.bgcolor(19, 19, 19)

        # Adjust initial position for Rectangles
        papi.penup()
        papi.setposition(-200, 200)
        papi.pendown()

        # Draw Rectangles
        papi.write("Rectangles: \n", font=("Arial", 20, "bold"))
        max_height = 0
        for rec in list_rectangles:
            width = getattr(rec, "width")
            height = getattr(rec, "height")
            for i in range(2):
                papi.forward(width)
                papi.right(90)
                papi.forward(height)
                papi.right(90)
            if height > max_height:
                max_height = height
            papi.penup()
            papi.forward(width + 20)
            papi.pendown()

        # Adjust initial position for Squares
        papi.penup()
        papi.goto(-200, 200 - max_height - 100)
        papi.setheading(0)
        papi.pendown()

        # Draw Squares
        papi.write("Squares: \n", font=("Arial", 20, "bold"))

        for sqr in list_squares:
            size = getattr(sqr, "size")
            for i in range(4):
                papi.forward(size)
                papi.right(90)
            papi.penup()
            papi.forward(size + 20)
            papi.pendown()

        turtle.done()


if __name__ == "__main__":
    x = "This is an amazing editor"
    y = (x + "\n") * 3
    print(y)
