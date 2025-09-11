## ARCHITECTURE

This project uses a simplified version of CLEAN ARCHITECTURE.
By simplified i mean the naming conventions. This makes it easy for me and
any other developer thats family with CLEAN ARCHITECTURE or not to be able
to navigate the code base with ease.

### DEPENDENCY INJECTION

I have been a big fan of get_it for a while now. Because it allows me do alot
of things very simply.
For instance

- With the repository pattern it goes very well with service locator in the case
  where i need to swap out a different implementation for local storage say SharedPreferences
  it would be easy to conditionally register another instance of it from the service locator
  without having to change anything from the base implementation.

  Same with api service, it would be easy to swap in http service without the ui every handling
  any complexities

- With the repository pattern code is testable. Base classes can be mocked and tests can be easuly written
  for them. Which makes the code much more reliable.

## KEY TRADE OFFS

### Local storage

In a much larger system, Hive -- although fast and rebhoust, might not be the best solution
as it has been discontinued. It would be better to go with a schema based local db like Isar.
Although i have not used it yet, i believe it would work better for a larger scale project. I also think its
a very interesting package and would've wanted to use it in this project given more time.

### IMPROVEMENTS

### Data serialization

Its almost never advisable to write json serializable code by hand. There a very good alternatives
out there that make it much easier and more robust. My personal preference is json_serializable. Its
annotating feature makes it easy to manipulate what the outcome of the data you expect will be like.

#### Tests

This code is built to be very testable and with more time i would've loved to add tests.
