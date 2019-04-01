* TOC
{:toc}

# Collaborative coding

Most of the code that is written is written by teams of people.
Historically these teams have been colocated in the same building or at least in the same institution or company.
Modern teams are now often widely distributed, for example a project I work on, the Gonum project (with ~50 contributors of varying degrees of input), ~~has no other contributor in Australia as far as I know~~ -
the top contributors are in Australia, Europe and the UK - ~~none has ever actually met each other~~.

How is this possible?

In the case of the Gonum project, a centralised store of the code base is used that all contributors work from.
This also includes communication tools for planning, and tracking bugs and feature requests.
The store is open for all to see and interact with so bugs can be reported and changes may be made by people outside the team - this is how people join.
With this kind of infrastructure and careful communication, widely distributed teams can develop very large scale software projects.
The same tools also help small local teams working on simple software products.

# github.com

One of the most commonly used centralised stores of code is [GitHub](https://github.com) (others exist such as [Bitbucket](https://bitbucket.org) and [GitLab](https://gitlab.com)).
The model that is used in these systems is one of "social coding".
This is the idea that when people are able to collaborate with each other they will.
It seems to work for the most part.

## A social coding environment

Not a special place, just a place.

There is a common belief that GitHub *is* git.
This is not true; GitHub is just a set of web-based tools with integrated services that, arguably, enhance git, and a backing store for the code and metadata.
It also has very large market share, which makes a difference since the networking opportunities of a social network become greater with size.
Note that GitHub is often trawled by recruiters, so an active and well maintained GitHub account can be a good way to show off your work.

## Create a GitHub account

In order to complete the workshop, you will need a GitHub account.
With the account, you will also be able to file bug reports against tools you use that are hosted on GitHub and contribute to their development when you are able.

Navigate to https://github.com/join and sign up for a GitHub account.
Note that if you are going to be involved in software development in the future (you probably will at least to some extent), you will retain this username, so keep that in mind from a professional perspective.

By default, free accounts on GitHub are open to all (Bitbucket has free private accounts without request).
However, you can request free private repository rights if you are a student or a researcher, just fill in the form [here](https://education.github.com/discount_requests/new).

## Setting up keys

GitHub needs to know that the requests coming from your machine are from you.
This can be done using username/password pairs, but it is more convenient to share keys.
First you will need to create a SSH key pair if you do not already have keys available.

Check whether you have keys that you can use.

```
$ ls -l ~/.ssh
```

If this reports there there is no directory or there is no `id_rsa.pub` file, then you will need to create a new key pair.
Otherwise skip the following step.

```
$ ssh-keygen -t rsa -b 4096 -C "your_email@adelaide.edu.au"
```

Select defaults for all questions.
This will place create `~/.ssh` if it does not exist and place the public and private key files there.
The keys will not require a password - this is OK so long as you keep the private key private (you can add a password if you wish, then add the key to the ssh-agent with `ssh-add ~/.ssh/id_rsa`).

When you have a SSH key pair, follow the instructions given by GitHub for [adding a new SSH key to your account](https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/).

Note that you can revoke keys if you believe that the private key has been compromised (you have lost you laptop, you are no longer using the machine etc).
I recommend you revoke the key created here if you are using a virtual machine for the workshop, and then create a new one on your own machine.

An additional layer of security is provided that is worth taking advantage of is two-factor authentication (2FA).
See the [GitHub documentation for 2FA](https://help.github.com/articles/securing-your-account-with-two-factor-authentication-2fa/); 2FA is outside the scope of this workshop, but is recommended.
