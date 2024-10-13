from turtle import *
def draw_square(d):
    for i in range(4):
        forward(d)
        left(90)

def draw_polygon(d,n):
    for i in range(n):
        forward(d)
        left(360/n)

def draw_flower(d,n,p):
    for i in range(p):
        draw_polygon(d,n)
        left(360/p)

#done()


#done()

#q2
def check_age():
    attempts = 0
    while True:
        age = int(input("Enter your age: "))
        attempts += 1
        if 1 <= age <= 100:
            print("Your age is", age)
            print("Number of attempts =", attempts)
            break

#check_age()


#q3

def find_winners(f,m,n):
    counter = 0
    for i in range(0,n+1,f):
        if str(m) in str(i):
            counter += 1
    return counter

def find_winners(f,m,n):
    counter = 0
    for i in range(1,n+1):
        if i % f == 0 and str(m) in str(i):
            counter += 1
    return counter






