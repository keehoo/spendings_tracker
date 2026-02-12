# spendings_tracker

Spending Tracker Application - Track your spendings for better bugdet management

## Architecture
### I tried to follow Clean Architecture by Uncle Bob, especially in terms of testability and separation of concerns. Lib (presentation layer), data (data layer) and domain (domain layer) are in seperate modules. 

## Tradeoffs:
### 
    1. I usually compine domain models with their mappes using extensions methods. This time I went for seperate class for mappers. Not sure whether it brings much value, but definetely brings more work
    2. I try to avoid using local data bases on mobile due to arising problems with schema updates etc. But when I do I think I would go for standard sqlite SQL syntac instead of Hive (used hive cause it's just so much faster to write)
    3. Haven't found a good way of doing nice and smooth dependency inversion with flutter, this here is what I consider to be best so far.
    4. Time constraints... I used shared dependencies in lib (presentation layer)
    5. Unit tests I haven't had time for, I only attached one or two, and even that I used AI to write them
    6. Cubits use MVI with copy with (because of time contrains and because they are small)
    7. Some logic should be moved do Cubit, instead it's still in view
    
## What would I improve
### I would definetely improve:
    1. UI 
    2. Error handling & Empty states handling
    3. Some logic is still in view, while it should be in cubits
    4. More Unit tests, add lcov to test the coverage
    5. Automation tests adding
    6. Improve naming 

## Esitmated time spent:
### less than 4 hours total 




