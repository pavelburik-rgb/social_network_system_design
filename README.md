# social_network_system_design
System design of the social network system for travelers

This page contains description and system dedsign of the social network system for travelers.

**Functional requirements:**
- create post with text description, photos and geo position;
- add comments and likes to other posts;
- search for new places for travelling;
- look through user's feed, based on user's subscriptions;
- subscribe to other travelers and look through their user's page.

**Non-functional requirements:**
- 10 000 000 DAU
- Users' behavior:
  - creates 1 post per 2 day;
  - adds 5 comments per day;
  - gives 10 likes per day;
  - subscribes 5 times per week (or 0.7 per day);
  - searchs new places 2 times per day;
  - look through feed 3 times per day (av. 30 posts/day).
- availability 99,9%
- geo - CIS countries
- no seasonality
- data storage - 20 years
- limits:
  - not more than 10 posts per day;
  - not more than 5 photos in one post;
  - not more the 100 subscriptions per week;
- time limits:
  - not more than 3 sec for post downloading.
 
Post = text description (up to 1000 symbols) + photos (up to 5 photos (each about 5 MB)) + geo + meta.
Photo compressed to 0.4 Mb
Feed/Search = 1 page - 5 posts.
 
**Calculations:**
- RPS (write):
  - create post: 10 000 000 * 0.5 / 86400 = 57 (without photos)
     - download photos: 10 000 000 * 5 * 0.5 /86400 = 300 
  - add comments: 10 000 000 * 5 / 86400 ~= 600
  - likes: 10 000 000 * 10 / 86400 ~= 1 160
  - subscription: 10 000 000 * 0.7 / 86400 ~= 80
  - TOTAL write = 2200
- RPS (read):
  - search posts: 10 000 000 * 2 / 86400 ~= 230
  - read feed: 10 000 000 * (30/5 posts in a request) / 86400 ~= 700
  - TOTAL read = 930
 
- Traffic (write):
  - create post: 57 (without photos) * 4kB = 228 kB/s
     - download photos: 300 * 5 MB = 1.5 GB/s
     - compressed photos: 300 * 0.4 Mb = 120Mb/s
  - add comments: 600 * 0.6KB = 360 kB/s
  - likes: 1 160 * 0.03KB = 34.8 kB/s
  - subscription: 80 * 0.03KB = 2.4 kB/s
  - TOTAL write traffic = 1.5 GB/s
- Traffic (read):
  - search places: 230 * 2.02MB = 465 MB/s
  - read feed: 700 * 2.02MB * 5 (posts in 1 query) = 7,07 GB/s
  - TOTAL read traffic = 7.07 + 0.465 = 7.535 GB/s
 
- Capacity:
  - posts = 228kb * 86400 * 365 = 7,2 TB
  - photos = 120 MB * 86400 * 365 = 3,7 PB
  - comments = 360 kB * 86400 * 365 = 11 TB
  - TOTAL = 3 718.2 TB / year 

 --Disks calculation (for 1 year):
- HDD: 
  - IO = 2200 + 930 / 100 = 31 disks
  - Traffic = 9 035 000 kBs / 100 000 kBs = 91 disks
  - Memory = 3 718.2 TB = 32 TB = 117 disks + 15% = 134 disks
     
- SSD (SATA):
  - IO = 2200 + 930 / 1000 = 4 disks
  - Traffic = 9 035 000 kBs / 500 000 KBs = 19 disks
  - Memory = 3 718.2 TB / 100 TB = 38 disks * 15% = 44 disks
 
- SSD (nMVE):
  - IO = 2200 + 930 / 10 000 = 1 disk
  - Traffic = 9035 000 kBs / 3 000 000 KBs = 3 disks
  - Memory = 3 718.2 TB / 30 TB = 124 disks * 15% = 142 disks
 
We will choose SSD (SATA), but will use combined types of disks, using HDDs (for comments, posts and cold storage of photos) and SSDs (SATA) disks for photos (hot storage not more than 90 days).
