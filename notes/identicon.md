# Identicon Example Project
Let's take advantage of what we've learned so far and make another application.

...

TODO: UPDATE THIS WITH INFO FROM THE COMMENTS IN THE CODE. ALSO, CREATE A NEW NOTE FOR STRUCTS AND PATTERN MATCHIN ON STRUCTS. CONSIDER NUMBERING NOTES TO INDICATE ORDER OF PERSUSAL
...

Why would we use a Struct over a Map?

Structs enfore that the only properties that can exist in our Struct are those defined in our file describing it. Recall: you can stuff anything into Maps typically.

You may be tempted to add methods for operatin on your Struct inside the struct code. Nope- - remeber this is functional programming. We are simply adding fields to the data structure.

We COULD use a Map for this project, but, by convention, if we know the properties we're going to be using, we use a Struct.