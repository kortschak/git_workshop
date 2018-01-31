* TOC
{:toc}

# Making changes

"By June 1949, people had begun to realize that it was not so easy to get a program right as had at one time appeared.
… It was on one of my journeys between the EDSAC room and the punching equipment that the realization came over me
with full force that a good part of the remainder of my life was going to be spent in finding errors in my own programs."
(Wilkes, Memoirs of a Computer Pioneer, p. 145)

As described in the previous section the git model allows a file to be in only one of four states if it is within the file system of the git repository.
These states are *untracked*, *unmodified*, *modified* and *staged*.
Some of the transitions between states come from modifying files in your editor (or otherwise).
Git provides commands to move files between states so that it can maintain the history of your changes.

In the following excercise you will create a repository and make a some changes to the files in the repository.
This will show how the files move between the different possible states and what commands can be used to make these transitions.
It will be valuable to refer back to the file status lifecycle diagram from the previous page.

## Create a new git repository

```
$ mkdir project
$ cd project
$ ls -a
```

Notice that the project directory has only the `.` and `..` directories as expected.

```
$ git init
$ ls -a
```

The `git init` command has created a `.git` directory which contains all the respository metadata and history.

```
$ ls .git/
```

Git provides a command to get a quick look at the satus of the repository.
This will list files in the *untracked*, *modified* and *staged* states and is useful if you get lost.

```
$ git status
```

## Add a file to the repository

The following command will add a trivial Markdown file and add it to the repository.
Note that adding a file involves two git commands: `add` and `commit`, and that committing requires that some text be added explaining what is happening.
If you do not include the commit message flag, `-m`, git will start an editor to add a message.
You should make your messages meaningful and easy to read.

```
$ echo "# Project Title" > README.md
$ git add README.md
$ git commit -m "Add README"
```

### Q: What state changes do `add` and `commit` make to the file?

Now add a few more files to make things interesting.

```
$ echo "contents of the a file" > a.txt
$ git status

$ git add a.txt
$ git status

$ git commit -m "Add a.txt file"
$ git status

$ echo "contents of the b file" > b.txt
$ echo "contents of the c file" > c.txt
$ mkdir subdir
$ echo "contents of the subdir/d file" > subdir/d.txt
$ echo "contents of the subdir/e file" > subdir/e.txt
$ git status
```

### Q: Why does the a.txt file not show up in the output of `git status`?

Hint: Rule of Silence. Why?

None of the files just created have been added or committed to the repository.
It is possible to use shell filename globbing, or git's internal name globbing.

```
$ git add *.txt
$ git status

$ git add '*.txt'
$ git status
```

### Q: Why do the status outputs differ between these two commands?

Then commit the new files to the repository.

```
$ git commit -m 'Add all new txt files'
$ git status
```

Notice that the output of `git status` becomes quiet since now everything is in the *unmodified* state.
One of the most important features of git is that it can be used to look at a commented history of your changes.
The `log` subcommand will show you all the changes that have been made to the repository, with their commit messages.
By default the most recent changes are shown first.

```
$ git log
```

Try the command above again, but with the `-p` flag (also look at `man git-log` for other useful flags).

### Q: Find a flag that will show you how many lines were changed in each file for each commit.

The `status` and `log` subcommands allow you to see the overall status, and changes that have been committed to the repository, but not uncommitted changes.
Git has a subcommand, `diff` that will show these differences (usually only with *tracked* files).

First make a new *tracked* but uncommited file.

```
$ echo "contents of the subdir/f file" > subdir/f.txt
$ git add subdir/f.txt
```

```
$ git diff
$ git diff HEAD
$ git diff --staged
```

### Q: What are the differences between these three invocations of `git diff`? Do you expect to see any difference in their output?

Now make changes to the files, note that both are tracked, but only one is committed to the repository.

```
$ echo "changed contents of the a file" > a.txt
$ echo "changed contents of the subdir/f file" > subdir/f.txt
$ git status
```

and repeat the three `git diff` invocations above.

```
$ git diff
$ git diff HEAD
$ git diff --staged
```

### Q: What are the differences between these three invocations of `git diff` this time?

Now stage the `a.txt` file and examine the output of `git diff` again.

```
$ git add a.txt
$ git diff
$ git diff HEAD
$ git diff --staged
```

If you have been reading the output of `git status` carefully, you will have noticed that we can unstage a file.

```
$ git reset a.txt
$ git reset subdir/f.txt
$ git status
```

and we can discard changes that are not staged.

```
$ git checkout -- a.txt
$ git status
```

All of the changes that we have been making above occur in a single global environment,
but git makes it possible to work in a separate space, a branch, and then bring the changes back in by merging.
The notion of a branch was introduced in the previous page.

Create a new branch, `clean`, and check it out (move the current `HEAD` to point to this branch's most recent commit).

```
$ git checkout -b clean
```

### Q: What does the `-b` flag do? Is there another way to express this command?

Hint: See the previous page.

Note that this branch is currently identical to the previous branch (which was `master`).
To check this you can check this using the `diff` subcommand.

```
$ git diff master clean
```

In the `clean` branch you will remove all the text files.
Then you will merge the changes back into master

```
$ git rm '*.txt'
$ git commit -m "Remove all the txt files"
```

### Q: What does the `rm` subcommand do?

### Q: What are the difference between `master` and `clean` according to `git diff`.

Now move back to the `master` branch and merge the changes.
Finally, remove the `clean` branch since its changes are kept in `master`.

```
$ git checkout master
$ git merge clean
$ git branch -d clean
```

### Q: How many branches now exist in the repository?
