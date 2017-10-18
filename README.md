# Colorblind Shader for Unity  

![Example image](https://github.com/0x4d4147/readme-images/blob/master/ColorblindUnity/Figure%201.JPG?raw=true)


### Usage  

#### Scene  

The test scene is called **Colorblind Test Scene**. This scene is set up with a few colored test objects and a Camera with the image effect shader applied.  

![Example image](https://github.com/0x4d4147/readme-images/blob/master/ColorblindUnity/Figure%202.JPG?raw=true)

![Example image](https://github.com/0x4d4147/readme-images/blob/master/ColorblindUnity/Figure%203.JPG?raw=true)

Edit the shader to control the type of colorblindness to simulate, the error mask effect texture, the error mask strength, and the error blinking effect speed (0 for none).  

![Example image](https://github.com/0x4d4147/readme-images/blob/master/ColorblindUnity/Figure%204.JPG?raw=true)

#### Color Space

Your project **MUST** be configured to use **Linear color**.
_Edit > Project Settings > Player > Other Settings > Color Space_

If you need to use Gamma, then you'll need to make a modification in the shader code to map RGB to linear RGB and back. Otherwise, shoot me a request to add it (via Twitter or GitHub or something).

## Sources 

Algorithm:
http://ixora.io/projects/colorblindness/color-blindness-simulation-research/

Error texture:
https://www.toptal.com/designers/subtlepatterns/worms/

## Releases  

[Get as Unity Package](https://github.com/0x4d4147/ColorblindUnity/releases)  

## License  
[MIT License (c) 2017](https://github.com/0x4d4147/ColorblindUnity/blob/master/LICENSE)
