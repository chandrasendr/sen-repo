# 1) Create a list of “person” dictionaries with a name, age and list of hobbies for each person. 
# Fill in any data you want.
persons = [
    {
    'name': 'Max',
    'age': 19,
    'hobbies': ['f1', 'tt', 'fitness']
    },
    {
    'name': 'Chandra',
    'age': 26,
    'hobbies': ['startup', 'reading', 'learning']
    },
    {
    'name': 'Alex',
    'age': 24,
    'hobbies': ['chess', 'football']
    }
]


# 2) Use a list comprehension to convert this list of persons into a list of names (of the persons).
persons_name = [name['name'] for name in persons]
print(persons_name)


# 3) Use a list comprehension to check whether all persons are older than 20.
persons_age_grater_twenty = all([age['age'] > 20 for age in persons])
print(persons_age_grater_twenty)


# 4) Copy the person list such that you can safely edit the name of the first person 
# (without changing the original list).
# My solution
persons_copy = [name['name'] for name in persons]
print('My solution: ')
print(persons_copy)

# Instructor's solution
copied_persons = [person.copy() for person in persons]
copied_persons[0]['name'] = 'Maximilian'
print("Instrutor's solution")
print(copied_persons)
print(persons)


# 5) Unpack the persons of the original list into different variables and output these variables.
# My solution
names = []
for k, v in [(k, v) for x in persons for (k, v) in x.items()]:
    if k == 'name':
        names.append(v)

print(names)

# Instructor's solution
p1, p2, p3 = persons
print(p1)
print(p2)
print(p3)