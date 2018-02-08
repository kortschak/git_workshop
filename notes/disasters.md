* TOC
{:toc}

# When things go wrong

Git is very powerful and is able to radically restructure the history of a project.
This is not something that we have gone into here, but will likely be something you face at some point.

When things go wrong, be aware that the following is not necessary.

![Git](https://imgs.xkcd.com/comics/git.png)

Git retains lost data (graph nodes that do not have associated tags or branches) for a while (30 days by default),
so you can recover states that you think you may have lost.

A useful command here is `git reflog` which will show you your history of `HEAD`s.
By looking at the output of `git reflog` you find a commit you were at and use `git checkout <sha-1>` to get back to that state.
Obviously, this will not work if you did not commit the changes you were working on and those changes were lost.

To see this in action check out a commit that you have made recently and deleted the references to.
You will have created commits for the changes you sent to the git\_workshop\_18 repository,
but those should have been deleted after they were merged into the upstream repository.

Run the `reflog` subcommand to see the history of your `HEAD`s.

```
$ git reflog
```

Find the commit message that matches the commit that was merged into the upstream repository,
but which was deleted after the merge.
Take note of the truncated `sha-1` value in the left column for the `HEAD` that hold that commit.

```
$ git checkout <sha-1>
```

### Q: If you wanted to recover this commit as a branch, how would you do this?

Note that there may be more than one line with the summary line you want since it is possible to repeatedly commit the same commit,
while changing the code and the commit time (see `--amend` in `man git-commit`).
See this `reflog` excerpt from the github.com/kortschak/arrgh project on my local repository:

```
36f1588 HEAD@{25}: commit (amend): travis: install opencpu-server
cdc21cd HEAD@{26}: commit (amend): travis: install opencpu-server
fa328fe HEAD@{27}: commit: travis: install opencpu-server
```

Here I found changes that should have been included in the original commit, but which I forgot at the time, so I added them in to the same commit using `--amend`.
This is one of the commonly used history revision tools provided by git.
It should only be used when the consequences are understood, and generally not after you have published your changes.

Another common problem, and something we have structured the workshop to avoid, is the issue of merge conflicts.
Because git allows multiple collaborators to checkout and work on code/text, it is possibe that two or more people will make changes to the same line in a file.
The git merge procedures cannot decide which change is correct.

Here is a simple example where the line between Edward and William has Maurice inserted in `HEAD` and Malory inserted in the branch `add/malory`.

```
People

Alice
Bob
Carol
Dave
Edward
<<<<<<< HEAD
Maurice
=======
Malory
>>>>>>> add/mallory
William
```

It is up to the person merging `add/mallory` to manually resolve the conflict.
Assuming that Malory should be added (and that alphabetical ordering is wanted), the manual resolution would be to edit the file to look like this.

```
People

Alice
Bob
Carol
Dave
Edward
Malory
Maurice
William
```

The conflict markers should be removed during the edit - always check that they have been removed before moving on.

Once the conflict has been resolved in the file (and tested) you then stage the file and commit it and then merge.

```
$ git add <conflictingfile(s)>
$ git commit # This may need significant justification for the resolution.
```

The merge will then continue until the next conflict - in multi-commit merges this can happen repeatedly and is sometimes challenging.

A useful tool provided by git is `git mergetool`.
This command invokes a conflict resolution tool that displays conflicts in a graphical way, allowing you to select which part to include in the merge.
You can specify which tool you actually want to do the work of `git mergetool` by running the command `git config --global merge.tool <tool>`;
common tools are `meld`, `vimdiff` and `kdiff3`. The `emacs` editor may also be used as a merge tool.
The following image shows a merge tool window where the `meld` command has been used as the tool.

![Meld window resolving merge conflict](https://i.stack.imgur.com/QRzUR.png) 

The best way to deal with conflicts though is to avoid them if possible.
This can be achieved easily by following two rules:

- Always pull from the upstream master before working.
- Don't work on parts of files that are the subject of another pending changes (look through the outstanding pull requests or ask other collaborators).

A handy hint for working on manuscript documents is to make line breaks at sentences rather than paragraphs.
Since the diff algorithm that git uses is line based, this reduces the likelihood that any pair of changes will collide,
and also makes changes in text easier to find and think about.
In software documents, this is rarely a problem since lines of code tend to be shorter than lines of natural language (even when the natural language is broken at sentence boundaries).
