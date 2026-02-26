# User Stories

All work done towards this project should be tracked as feature work.
Feature work is organized into the following hierarchical categories:

- Epic: A large body of work for a major feature or theme that can be broken down into smaller user stories,usually taking multiple sprints to complete; commonly used for large features, big improvements, significant product changes, etc.
- Story: A small, deliverable piece of functionality written from the user's perspective, completable within a sprint; often written as "As a `user`, I want `goal` so that `benefit`."
- Sub-task: A smaller unit of work under a story to help break the implementation into manageable steps; they cannot exist on their own - they must belong to a story.

Stories and sub-tasks should contain the following information:

- Goal: describes the intention/value of this ticket and should help finish the sentence "When completed, this ticket will ..."
- Requirements or Acceptance Criteria: list of individual criteria that must be true for this story to be considered complete
- Notes (optional): any additional information, context, resources, diagrams, etc that would be helpful in completing this story

Stories should also contain a tasks section with a list of the sub-tasks to accomplish the acceptance criteria.

Tasks should chunk out the work of the story into manageable, bite-sized pieces.
Ideally these should be scoped to one independent commit and take less than a day to complete (~≤6 hours) and be as independent and parallel as possible, though dependency chains across subtasks are rarely completely avoidable.
Each sub-task should leave the tree in a clean, passing state (no failing builds or tests).

It is also important that testing is considered when creating stories and sub-tasks.
Unit tests must be written as part of the same sub-task as the code they cover; creating a separate sub-task or story to retrofit unit tests for already-completed code is not acceptable — tests ship with the implementation.
Integration tests may be split into a dedicated sub-task when combining them with the original implementation sub-task would make it too large, but they must always be completed within the same parent story before that story is considered done.

This project is managed using GitHub resources, so these concepts will be mapped to GitHub features in the following ways:

- Epics -> Milestones
- Stories -> Issues; labels will be used to differentiate type (story, task, bug, defect, etc)
- Sub-tasks -> Sub-issues with a label of task

Undesirable behavior is also tracked using issues with a label of bug or defect.

- A bug is defined as undesirable behavior that has not yet been released to production.
- A defect is defined as undesirable behavior that is detected in production.

Both types of issues should contain the following information:

- **What I do:** the steps taken to reproduce the behavior
- **What I expect to happen:** the _correct_ behavior that was expected
- **What actually happens:** the actual undesirable behavior that occurred
- any other notes, logs, screenshots, or helpful context
