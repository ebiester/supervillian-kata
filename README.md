supervillian-kata
=================

This is a repository for the Supervillian Support Desk Katas.

Exploratory application architecture kata - the supervillian support desk.

This set of katas is meant to be a tiny slice of a CRUD app as a way to practice a tiny slice of a business application that is well defined. I put it together as a minimal viable framework test -- something that would test database, business logic layer, controllers, views -- enough to be able to compare an architecture or framework quickly. 

By definition, a kata is bite sized, and any architecture test that can test more than the simplest ideas is going to be more than bite sized. As such, I have designed it as a set of interrelated katas. The first kata can be done independent of a web framework and expresses the ideas of interconnected models. The second kata explores that set of models within the context of an application. The third takes that set of assumptions and looks to explore how flexible the architecture is in the face of changing requirements.

Background: A lightning strike hit you one night when you were hacking on some C code -- you were suddenly one with the network, able to discern the codeless code. You decided to use your forces for good.

Your first mission is to use your powers to investigate the criminal underworld. There is a dastardly villainy support organization, working with mere villains and garden-variety agents of terror up to the supervillains who were the real targets to build their lairs of doom and supply their diabolical supply needs. And, like any twenty-first century company, they need talented developers. 

On your first day, you are given this as an initial spec. You think of this as an early opportunity to sabotage the company with subtle bugs that may trip up those who cannot fathom the codeless code until you see two burly guards drag in a scrawny developer and tie him to a support beam in the center of the developers. You see a crazed maniac you recognize as your bosses's boss. In a shrill voice that reminds you of Skeletor, "You cannot outrun us. When I say no bugs, I mean no bugs! Take him to the dungeon!" You decide you may need a few tests, codeless code or not.

This is the spec for Kata 1:

Users: 
* There are two types of ticket submitters: Supervillians and Villians, 
* There are two types of support employees: Junior and Senior.
* Users have a username.

Assigning Tickets:
* Tickets have a submitting user, assigned user, title and description.
* Tickets have three states: Not started, started, and completed.
* Tickets from Supervillians may not be assigned to junior support employees. 
* When a ticket is added, it is assigned to an open employee if an eligible employee does not have a ticket.
* A new ticket is automatically assigned to a support employee when a previous ticket is closed and a new ticket is available. (This is an evil organization, after all, and some of the most valuable clients are... ahem, some of the most difficult. Self organization is not encouraged.)
* Support employees are immediately assigned a ticket if one is available when they are added.

Ticket Prioritization: Implement in this order.
* Tickets are assigned oldest to newest within the priority groups. (That is all priority 1 will be assigned before priority 2, before 3, subject to the assigning tickets restrictions.
* Tickets from Supervillians of any age are in priority class one.
* Tickets from Villains are of priority class two, until they have been outstanding for one week, on which they become priority class one.
___

The spec for Kata 2 is dependent on Kata 1. 

Tickets:
* Open tickets can only be placed in progress. 
* In progress tickets may only be closed. 
* Closed tickets cannot be reopened.

Validation:
* Usernames must be unique.
* Tickets must have submitting users, titles, and descriptions.

View behavior:
* If logged in, you may view all of your past and present tickets as a list.
* As a villian or supervillian, you may enter a new ticket.
* As a villian or supervillian, you may edit an open ticket. 

___ 

The spec for Kata 3 is dependent on Kata 2.

* There is a new user type: Minions. Minions are on a Supervillian's account.
* As a minion, you may open a new ticket.
* As a minion, your tickets are originally given the same priority as
  Villains, but they do not ever escalate in priority.

