# RPGDataPad

##Development Tools
  * Visual Studio 2015 Community: https://www.visualstudio.com/en-us/products/visual-studio-community-vs.aspx
  * SQL Server 2014 Express: https://www.microsoft.com/en-us/download/details.aspx?id=42299
  * IIS 7.5 Express: https://www.microsoft.com/web/handlers/webpi.ashx?command=getinstaller&appid=IISExpress
  * Atlassian SourceTree for Git: https://www.sourcetreeapp.com/

##First Time Setup
  * Git
    1. Open Visual Studio and open "Team Explorer".
    2. Open "Connect to Team Projects"
    3. Clone the repository via the "Local Git Repositories" section
    4. Open SourceTree and click "Clone/New"
    5. Click "Add Working Copy" and point to the Git directory created by Visual Studio.
    6. Branches can now be created/managed via SourceTree and Visual Studio (though I recommend managing it mostly through SourceTree)
  * Starting the App
    1. Open RPGDataPad.sln with Visual Studio
    2. Open the Web.config file in the RPGDataPad project.
    3. Change the server in the connection string to that of your local SQL Server and save. (For SQL Server Express its most likely \<computer name\>\SQLEXPRESS)
    4. Right-click on the RPGDataPad project and click "Set as StartUp project".
    5. Start the project via the green "play" button at the top. Once started the app will automatically use IIS Express and will create/update the DB automatically via the migration scripts in the Migrations folder in the RPGDataPad.Data project.
  
##Creating a DB Migration Script
  * Create a new .sql file in the Migrations folder in the RPGDataPad.Data project. Name should be an integer that is 1 + the previous file. (e.g. if there are two files currently in the folder named 1.sql and 2.sql then the new file should be named 3.sql)
  * Format of the file should follow the one in SQLTemplate.txt so that automatic migrations can run correctly and safely.
