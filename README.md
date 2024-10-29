Local spinup of the project
```bash
Ruby version: 3.2.2
Rails version: 7.1.4.2
run: ./bin/dev  This will start the server and also compile Tailwindcss

normal users:
  - username: test@gmail.com OR test2@gmail.com
  - password: password - for both users
Admin user:
  - username: admin@gmail.com
  - password: password

Project "test project" is lock down to only test@gmail.com and Admins
Project "All invited!" whitelisted for test@gmail.com and Admin

Questions Asked:
Do we need to split the history of the project's comment and status changes?
What level of visibility should we allow as a default for new created projects?
Can admins comment on any project? as well as change the status of any project?
How many users can be invited to a project?
What is the maximum number of projects a user can have?
Should it be opt in or opt out?
  If opt in, what invite method is best for the user?

Expected Answers:
Yes, i think it would be best to split the history of the project's comment and status changes.
This way we can see the history of the project's status changes and comments in a cleaner way.
However it should be structured in a way that we can see the history of the project's status changes and comments in a single view.

I think the default visibility for new created projects should be private.
This way the user can set up a project on their own terms without having to worry about the project being public.

It would be best to give admins comment status on projects, as well as change any status of any project.
This way the admin can have full control over the project and can make changes as needed. This would be useful incase of user difficulties.

How about we leave this open(unlimited) for now and see how it goes. We can always change it later if needed.
Probably the best approach as you can have many people taking park in the project and artificially limiting the number of users could be a bad idea.
However this could be a potential upsell feature for the future.

I think the maximum number of projects a user can have should be unlimited. Subject to change if needed.
Lets plan this in a way makes for ease of transition if we need to change this in the future.

Since we are going with private as the default visibility for new created projects, we should make it opt in, so the user can choose to invite others to the project.
This way the user can have full control over who can see the project and who can't. Maybe we could user research it?