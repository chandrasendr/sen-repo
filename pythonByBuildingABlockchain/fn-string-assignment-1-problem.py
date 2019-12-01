# 1) Write a normal function that accepts another function as an argument. 
# Output the result of that other function in your “normal” function.

# my answer
def other_function(param1, param2):
    print("{0} {1}".format(param1, param2))

def normal_function(param3, param4):
    param3(*param4)

normal_function(other_function,("hello", "world"))

# instructor answer
def transform_data(fn):
    print(fn(10))



# 2) Call your “normal” function by passing a lambda function – which performs any operation of your choice – 
# as an argument.

# my answer
normal_function(lambda a, b: print(a + b), (2 ,3))

# instructor answer
transform_data(lambda data: data / 5)



# 3) Tweak your normal function by allowing an infinite amount of arguments on which your lambda function will be executed. 

# my answer
def modified_normal_function(*args, **keyword_args):
    print(keyword_args)
    for k, argument in keyword_args.items():
        print(k, argument)

# instructor answer
def transform_data2(fn, *args):
    for arg in args:
        print(fn(arg))

transform_data2(lambda data: data / 5, 10, 15, 20, 22, 30)



# 4. Format the output of your “normal” function such that numbers look nice and are centered in a 20 character column.

# instructor answer
def transform_data3(fn, *args):
    for arg in args:
        print('Result: {:^20.2f}'.format(fn(arg)))

transform_data3(lambda data: data / 5, 10, 15, 20, 22, 30)
