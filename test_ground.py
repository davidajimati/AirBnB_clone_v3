#!/usr/bin/python3
string = 'User.update("38f22813-2753-4d42-b37c-57a17f1e4f88", "first_name", "John")'

real = []

pre = string.split('.')
real.append(pre[0])

pre2 = pre[1].split('("')
real.append(pre2[0])

start = string.index('("') + 2
end = string.index('")')
data = string[start:end].split(',')
uuid = data[0].strip().strip('"')
words = [word.strip().strip('"') for word in data[1:]]
real.append(uuid)
real += words
print(real)