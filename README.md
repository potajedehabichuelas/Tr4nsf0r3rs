
Task no.2 - TRANSFORMERS -

The app has 3 different screens:

First screen: Team editor
  From this screen you're able to add new members and edit the existing ones, you can also edit the team's name. By default, the teams are loaded from two JSON files that contain the teams:
  -AutoBotsTeam.json and DecepticonsTeam.json

This is to make testing and playing with it easier. The structure of the JSON object to read a team is as follows:

{
    "name": "Decepticons",
    "members": [
                {
                "name": "Soundwave",
                "strength": 8,
                "intelligence": 9,
                "speed": 2,
                "endurance": 6,
                "rank": 7,
                "courage": 5,
                "firepower": 6,
                "skill": 4
                }
             ]
}

More transformers could be added to the team by adding them to the members array following the JSON syntax. If the structure is incorrect or the file is missing the app will not show any teams on launch, but the user can still create a team from scratch. 

If the user clicks on either a member of the team or "add member" then edit member screen is presented

Second Screen: Member editor:
In this screen, the user is able to edit the specs of a team member (if clicked on a member in the previous screen) or add a new transformer.

Last Screen: Battle
Presented when the user clicks on "Start Combat" in the Team Editor screen, the user will now visualize the outcome of the battle from the previous teams.

Possible scenarios:
- Team 1 wins
- Team 2 wins
- Draw
- Everything was destroyed


NOTES:

- I could surely write many more tests, specially for the TBattle class, to test each rule in the fight mainly. But I was not sure the extent of the development that was required hence why I'm writing this here. If this is something you'd wish to see, I'd be more than happy to complete those.

- I've tried to arrange the objects the way it could make more sense to me, while also keeping in mind bigger scopes and being generic, but if you feel that there are better ways or that I've missed something please ask / let me know. 

- I'm also aware that there are some lonely strings that could be out of the way by using libraries like R or stuff like that. Again, I could keep coding for a bit more, so again, if you think something is not enough, please let me know.

