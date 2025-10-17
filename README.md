<div align="center">
  <h3 align="center">Meteo system vAMS.3 based on real-life LKPR equipment</h3>
  <p align="center">
    Instrument for Air Manager platform for personal entertainment / non commercial use
  </p>
</div>

## Features
* Can display weather from FSX/P3D (for TowerView when controlling on VATSIM/IVAO)
* Optimised for 17" 1280x1024 screens like the real unit :-)

## Installation of official Release version
If there is an official Release version of this instrument available, you can download it by clicking the link in Releases section (right side of GitHub page). It will download a ZIP archive. Extract the ZIP and you will find .siff file - that is the instrument. Use Air Manager "Import" function to import this instrument.

If there is no official Release version of this instrument avaible, it is usually because it is still in development. In that case read further.

## Installation from GitHub source
Click Code -> Download as ZIP. Download will begin for ZIP folder eg. xxxyyy.zip. When download is finished, open the ZIP and you will find a sub-folder inside with similar name. This subfolder should include files <i>logic.lua</i>, folder <i>resources</i> and maybe other files. Go to your C:\Users\username\Air Manager\instruments\OPEN_DIRECTORY and create folder with name <b>5ff21df2-44e0-4e91-38a6-c50843f180d7</b> (that is your Air Manager hash for this instrument). Copy all the files which you just downloaded (<i>logic.lua</i>, folder <i>resources</i>, etc) directly into this hash folder. Then run your Air Manager, which should immediately discover this new instrument

## FSX connection
Due to limitations of FSX, it is not enough to simply run this instrument in Air Manager and expect the weather to be displayed fully. To connect to your FSX, you must install custom panel with custom gauge and LUA script into FSX. Open Resources folder for those files!

## Contributing
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License
This project is licensed under the Creative Commons Attribution-NonCommercial 4.0 International License. Commercial use is prohibited without prior written permission.

## Contact
If you need to contact me, use any social network profiles linked from my GitHub. I usually reply within one day.

## Acknowledgments
* [Sim Innovations Air Manager](https://www.siminnovations.com/)

<div align="center">
    <img src="preview.png" alt="Logo">
</div>
