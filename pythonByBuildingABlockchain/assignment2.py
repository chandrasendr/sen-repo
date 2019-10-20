# 1) Create a list of names and use a for loop to output the length of each name (len()).
names_list = ["Laura", "Marcel", "Sebastian", "Marius", "Jon", "Max"]
print(names_list)
print(len(names_list))

print('-' * 30) 

# 2) Add an if check inside the loop to only output names longer than 5 characters.
for name in names_list:
    if len(name) > 5:
        print(name)
        print(len(names_list))

print('-' * 30) 

# 3) Add another if check to see whether a name includes a “n” or “N” character.
for name in names_list:
    if len(name) > 5 and ('n' in name or 'N' in name):
        print(name)
        print(len(names_list))

print('-' * 30) 

# 4) Use a while loop to empty the list of names (via pop())
while len(names_list) >= 1:
    print(names_list.pop())

print(names_list)
