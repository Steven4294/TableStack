# TableStack

## Features

TableStack loads the top 30 users from api.stackexchange and displays their: badges, username, and profile image. 

## Third-party libraries

[SDWebImage](https://github.com/rs/SDWebImage) was used to download images asynchronously and to cache images so that they were only downloaded one time. SDWebImage also has a convenient way to display placeholder images while the image is being loaded.

[SBJson 5](https://github.com/stig/json-framework) is parsing library which was used to parse the JSON response from stackexchange into Obj-C objects. 

---

#### TODO's

- custom TableViewCell. It would be nice to have a custom TableView cell - would make the UI a lot cleaner. TableStack is currently implemented using Apple's default UITableViewCell.

- pagination. It would be useful to be able to continue scrolling and fetch more users. 

- UITableViewDetailCell. It would be nice to be able to click on a cell and have it load more content - e.g. you click on a user and it shows more information, including their location, reputation change, etc. 
