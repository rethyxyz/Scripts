#!/usr/bin/python3

def main():
    counter = 0

    while (True):
        words = input("Insert title (press Return to quit): ")
        if (not words):
            quit()
        words = words.split(" ")

        # separator
        print("")

        for x in words:
            counter += 1

            word = x.lower()

            if (counter <= 1):
                print(word.capitalize(), end=" ")
            elif ((word == "a") or (word == "an") or (word == "the") or (word == "in") or (word == "on") or (word == "by") or (word == "with") or (word == "of") or (word == "and") or (word == "but") or(word == "or")):
                print(word.lower(), end=" ")
            else:
                print(word.capitalize(), end=" ")

        print("\n")


main()
