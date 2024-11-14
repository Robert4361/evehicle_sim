# EvehicleSim

This is (kinda) an Elixir port of a Java project for my college curriculum.

The theme of the project is a system of driving e-vehicles, and radars which can measure their speed. If a vehicle is over the speed limit, a traffic ticket should be created.
The data is read from a CSV file which simulates data the vehicle would create while being driven. The radars have their txt files which include things like their location, duration which the vehicle has to drive over the speed limit to get a ticket etc.

Now, why would I even think of doing this in Elixir? For educational purposes of course :).

Due to the posibility of having multiple radars, I find the Actor model (or Elixir's version of it) a wonderful fit. The main goal of this project is to get comfortable with Elixir's concurrency, processes supervisors etc.
This app is split into 2 main parts, the Core which is the functional "business logic" part, and the Runtime which is further split into workers and supervisors.

Due to the variable amount of radars which could be on our hypothetic playground/grid/infrastructure, I decided to use a Registry for the radars, along with a DynamicSupervisor. With this it was made possible that the vehicle can pick which radar should it send it's data to. The alternative was that each vehicle sends every row to each radar, which I deemed inferior. The vehicles get data from the Registry and then pick the most compatible radar (one close enough to the vehicle and one where the alloweed speed limit is lower than the vehicle's current speed). Once the radar get's the data, it stores it so it can reference it later.
If the vehicle is driving too fast too long (the time difference between the start and end data is bigger than the allowed duration), it gets a ticket. The ticket storage is pretty rudimentary and not scalable for now, but maybe it will be changed in the future. Today there is a ticket GenServer which just has a list of tickets.

Another current limitation of the app is that 1 vehicle can be properly tracked over time. Also open to change :)

All in all, this was a great project to get to grips with the concurrency and fault tolerance of Elixir, which are it's most important features in my opinion.

