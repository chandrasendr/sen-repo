# 1) Create two variables – one with your name and one with your age
user_name = input('Enter my name: ')
user_age = int(input('Enter my age: '))


# 2) Create a function which prints your data as one string
def my_data():
    """Prints user name (uses global variable!)"""
    print('My name is ' + user_name + ' and my age is ' + str(user_age))


# 3) Create a function which prints ANY data (two arguments) as one string
def any_data(first_data, second_data):
    """Prints two concated strings

    Arguments:
        : param first_data: The first string to be concatinated
        : param second_data: The second string to be concatinated.

    Returns: The decades of the age
    """
    print(first_data + ' ' + second_data)


# 4) Create a function which calculates and returns the number of decades you already lived (e.g. 23 = 2 decades)
def decades_i_lived_already(age):
    """Calculates the integer part of the age received.

    Arguments:
        :param age: The age for which the decades should be calculated
    """
    decades_lived = age // 10
    return decades_lived


my_data()
any_data('Hello', 'world!')
decades = decades_i_lived_already(int(user_age))
print(decades)
