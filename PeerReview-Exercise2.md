
# Solution Assessment #

## Peer-reviewer Information

* *name:* Cyrus Azad
* *email:* cjazad@ucdavis.edu

___

## Solution Assessment ##

### Stage 1 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel stays in the middle of the drawn 5 by 5 unit cross no matter how fast it goes. However when you launch the game, position lock is the last camera available out of the made cameras, and the instructions say that the camera should be immediately testable. The student notes this in the README.

___
### Stage 2 ###

- [X] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The vessel stays within the drawn box at all times while the camera autoscrolls. The vessel can move within the box at normal or boosted speed and still be contained within it. I do not see any flaws when it comes to the requirements. 

___
### Stage 3 ###

- [ ] Perfect
- [X] Great
- [ ] Good
- [ ] Satisfactory
- [ ] Unsatisfactory

___
#### Justification ##### 
The camera approaches the vessel at a leashed distance and smoothly position locks when the vessel comes to a halt. However, the leash is not always consistent. It is a different length when the player boosts vs. moves normally, and is also a different length depending on which direction the player boosts. 

___
### Stage 4 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [X] Unsatisfactory

___
#### Justification ##### 
The vessel follows the camera at a very choppy rate. The vessel can only follow the camera in a singular direction. If you input another direction before the vessel resets back to the center, the vessel will fly off the screen and the camera will stay still. Once the vessel stops moving, the camera will instantly position lock to it's new position. This means you can never go diagonal. The student notes this in the README. 
If you start boosting before you input a direction, then the camera does not follow the vessel at all. It stays still until the vessel stops, and then position locks onto it. If you are moving in a singular direction and press bost when the vessel is not at the end of the drawn cross, the vessel will boost off of the screen, and the camera will once again remain still until the vessel stops. The camera will then position lock onto the vessel again. 

___
### Stage 5 ###

- [ ] Perfect
- [ ] Great
- [ ] Good
- [ ] Satisfactory
- [X] Unsatisfactory

___
#### Justification ##### 
Not Attempted.

___
# Code Style #

#### Style Guide Infractions ####

Not all functions are surrounded by two blank lines. This is done inconsistently, as some [are surrounded by two blank lines](https://github.com/ensemble-ai/exercise-2-camera-control-RaghavsScarletSplendour/blob/9808b8955bf56483643a4a2adfb2a8a59ed17f27/Obscura/scripts/camera_controllers/PositionFollowCameraController.gd#L15-L16), whereas others are [only separated by one](https://github.com/ensemble-ai/exercise-2-camera-control-RaghavsScarletSplendour/blob/9808b8955bf56483643a4a2adfb2a8a59ed17f27/Obscura/scripts/camera_controllers/TargetFocusCameraController.gd#L19)

They did not at a .0 to the end of this [float](https://github.com/ensemble-ai/exercise-2-camera-control-RaghavsScarletSplendour/blob/9808b8955bf56483643a4a2adfb2a8a59ed17f27/Obscura/scripts/camera_controllers/PositionFollowCameraController.gd#L9). However, they did do it for every other float in their code. 

#### Style Guide Exemplars ####

They formatted their code where it is consistently indented correctly and easy to read. 

They commented their code so that it is easy to understand and the comments are easy to read. 


# Best Practices #

#### Best Practices Infractions ####

They changed the names of [the required exports](https://github.com/ensemble-ai/exercise-2-camera-control-RaghavsScarletSplendour/blob/9808b8955bf56483643a4a2adfb2a8a59ed17f27/Obscura/scripts/camera_controllers/FrameAutoScrollCameraController.gd#L5-L7). Not the biggest deal, just slightly confusing when looking for the specific exports in the code. 


#### Best Practices Exemplars ####

They are consistent in variable names and naming conventions for each class, as well as making these names clear to understand what the variable contains. 
Functions are well formatted and well spaced so they are easy to read. 