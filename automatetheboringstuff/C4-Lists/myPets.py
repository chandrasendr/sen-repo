myPets = ['Zohpie', 'Pooka', 'Fat-tail']
print('Ener a pet name:')
name = input()
if name not in myPets:
    print('I do no have the pet named ' + name)
else:
    print(name + ' is my pet.')
