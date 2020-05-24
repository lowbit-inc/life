# Lowbit Planner - Bash Edition (miniplan)

## How to Use (with examples)

**Color:**

```bash
export COLOR=false  # disable color
./plan              # without color

export COLOR=true   # enable color
./plan              # with color
```

**Symlink:**

```bash
./plan --link # creates a symlink

plan          # calling without full path
```

**Database:**

```bash
plan task add Task 1  # database is initiated to create task
```

**Task:**

```bash
plan task add Task 2              # creates task
plan task add "Buy some t-shirts" # another task

plan task list                    # list of tasks

plan task delete Task 1           # deletes task

plan task complete Task 2         # completes task
```

**Debug:**

```bash
export DEBUG=true                 # enable debug log messages

plan task add Organize documents  # debug messages visible
```

**Inbox:**

```bash
task inbox add Drink water with lemon # New inbox item

task add Birthday of a friend         # Quick way to add to inbox
```

**Interactive modes:**

```bash

# Adding some items to the inbox
plan add Study Pixel Art
plan add Practice on Duolingo
plan add Update LinkedIn
plan add Online webinar
plan add Review budget
plan add Watch Hi-Score Girl
plan add Write a book

plan review   # Revision mode => Process inbox items

plan work     # Work mode     => Focus in what to do

plan decide   # Decision mode => Define priorities

```

**Habits:**

```bash
plan habit list                     # List and checklist of habits

plan habit add weekly Update Linux  # New weekly habit 
```

**Completed:**

```bash
plan completed  # List of recently completed items
```

**Sync:**

```bash
cd ~/.lowbit-planner                    # Access the database
git init                                # Initiate a git repo
git remote add origin <YOUR_REPOSITORY> # Add your origin

plan sync                               # Sync your data using git

```

**Help:**

```bash
plan        # Basic usage and features

plan inbox  # Help for Inbox operations
plan event  # Help for Event operations
plan task   # Help for Task operations
plan habit  # Help for Habit operations

plan --help # General help
```
