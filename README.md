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
  - creates 1 post per day;
  - adds 5 comments per day;
  - gives 10 likes per day;
  - subscribes 5 times per week (or 0.7 per day);
  - searchs new places 2 times per day;
  - look through feed 3 times per day (av. 30 posts).
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
 
Post = text description (up to 1000 symbols) + photos (up to 5 photos (each about 400 kB)) + geo + meta.
Feed/Search = 1 page - 5 posts.
 
**Calculations:**
- RPS (write):
  - create post: 10 000 000 * 1 / 86400 = 115 (without photos)
     - download photos: 10 000 000 * 5 /86400 = 600 
  - add comments: 10 000 000 * 5 / 86400 ~= 600
  - likes: 10 000 000 * 10 / 86400 ~= 1 160
  - subscription: 10 000 000 * 0.7 / 86400 ~= 80
- RPS (read):
  - search places: 10 000 000 * 2 / 86400 ~= 230
  - read feed: 10 000 000 * (30/5) / 86400 ~= 700
 
- Traffic (write):
  - create post: 115 (without photos) * 4kB = 460 kB
     - download photos: 600 * 0.4 MB = 240 MB
  - add comments: 600 * 0.6KB = 360 kB
  - likes: 1 160 * 0.03KB = 34.8 KB
  - subscription: 80 * 0.03KB = 2.4KB
- Traffic (read):
  - search places: 230 * 2.02MB = 465MB
  - read feed: 700 * 2.02MB = 1414MB
