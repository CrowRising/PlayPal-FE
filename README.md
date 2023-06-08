[![Contributors](https://img.shields.io/github/contributors/CrowRising/PlayPal-FE.svg)](https://github.com/CrowRising/PlayPal-FE/graphs/contributors)
[![Forks](https://img.shields.io/github/forks/CrowRising/PlayPal-FE.svg)](https://github.com/CrowRising/PlayPal-FE/forks)
[![Stargazers](https://img.shields.io/github/stars/CrowRising/PlayPal-FE.svg)](https://github.com/CrowRising/PlayPal-FE/stargazers)
[![Issues](https://img.shields.io/github/issues/CrowRising/PlayPal-FE.svg)](https://github.com/CrowRising/PlayPal-FE/issues)

# PlayPal

## About This Project
### Mod 3 Group Consultancy Project
PlayPal is a playground and park finder app. Designed for parents looking for new, fun, safe playgrounds within any given area/location. PlayPal has the ability for registered users to upload pictures, rate and review playgrounds that help inform the community.
<br><br>
                                                  <img src="https://www.miracle-recreation.com/content/uploads/2018/11/Image-Header_Park.jpg.webp" width="600" height="400">
                                                  
 This front end app works with our back end app found here: [PlayPal-BE](https://github.com/CrowRising/PlayPal-BE)                                                 
                                                  
## Built With
* ![Ruby](https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white)
* ![Postgresql](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
* ![Render](https://img.shields.io/badge/Render-%46E3B7.svg?style=for-the-badge&logo=render&logoColor=white)
* ![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
* ![Rails](https://img.shields.io/badge/rails-%23CC0000.svg?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
* ![CircleCi](https://img.shields.io/badge/circleci-343434?style=for-the-badge&logo=circleci&logoColor=white)
* ![Visual Studio Code](https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white)
* ![Love](https://ForTheBadge.com/images/badges/built-with-love.svg)


## Running On
  - Rails 7.0.4
  - Ruby 3.1.1

## <b>Getting Started</b>

To get a local copy, follow these simple instructions

### <b>Installation</b>

1. Fork the Project
2. Clone the repo 
``` 
git clone git@github.com:CrowRising/PlayPal-FE.git 
```
3. Install the gems
```
bundle install
```
4. Create the database
```
rails db:{create,migrate}
```

5. Create your Feature Branch 
```
git checkout -b feature/AmazingFeature
```
6. Commit your Changes 
```
git commit -m 'Add some AmazingFeature' 
```
7. Push to the Branch 
```
git push origin feature/AmazingFeature
```
8. Open a Pull Request


## How to Use PlayPal

From the welcome page you can either log in with google or search for playgrounds without logging in.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.00.09.png)

If no information is filled out in the search fields an error message will flash.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.07.02.png)

Once you have plugged in the area you would like to search in, you are taken to an index page of all the parks.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.02.33.png)

All of the Playgrounds' names are links, once clicked you are taken to the playground show page and if there are any reviews on that playground they will show up below the image.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.22.58.png)

If you were a logged in user you would have the option to add a review and or add this playground to your favorites.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.05.12.png)

On a Logged in User's Dashboard there is a list of their favorite playgrounds as well as an option to search for more.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.04.24.png)

If a logged in user wanted to leave a review they would have to fill out all three field in the review form.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.08.08.png)

When the display is smaller, like on a phone, the menu bar become a drop down. With the option to sign in or logout.  
![](app/assets/images/Screenshot%202023-06-08%20at%2014.04.04.png)
![](app/assets/images/Screenshot%202023-06-08%20at%2014.06.15.png)

## Contributing  [![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/CrowRising/PlayPal-FE/issues)
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

## Authors
- Thomas Hawley [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/thawley2)  [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/thomas-hawley-901612123/)
- Reilly Miller [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/rmiller220) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/reilly-miller-6b6131266/)
- Crow Rising [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ](https://github.com/CrowRising) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/crowrising/)
- Logan Wilson [![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white) ]( https://github.com/Bluedevil667) [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white) ](https://www.linkedin.com/in/logan-wilson-28422ba0/)

## Planning Tools
- [![Miro Board](https://img.shields.io/badge/Miro-050038?style=for-the-badge&logo=Miro&logoColor=white)](https://miro.com/app/board/uXjVMDHct-E=/)
- [GitHub Project Board](https://github.com/users/CrowRising/projects/5)
