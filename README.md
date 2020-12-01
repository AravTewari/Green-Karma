# Green Karma

## Inspiration
Climate change is one of our most inherent issues today. Billions of people use their mobile devices every day for social media and gaming — I decided to leverage this to introduce a gamified and social approach to sustainability, to put user activity towards a greater cause. Presenting, Green Karma, the first app of its kind which utilizes user's social networks and connections and motivates them to do green activities.

## What it does
The app provides users with a dashboard, which displays the user's profile, a progress bar of the user's current level, progress on badges, their day-to-day activities, and the respective points. Levels measure progress throughout the app, depending on the points earned from completing different tasks. Tasks are eco-friendly activities the user completes, such as biking to work instead of driving.

To add a task, the user is presented with different categories (food waste, commute, etc.), respect activity options (recycling, volunteering, etc.), and respective abilities to enter details, share with their friends, and add a picture.

This allowed for the creation of a social network. To give a social and connected feel, the friends feature allows for quick updates on what friends are up to, in addition to viewing their points earned and progress. Green Karma users can view recent posts from people in their circle and like and comment on the posts. This form of social recognition is proven to be a great incentive for users because people appreciate the positive feedback and reinforcement people get from the ones they know. However, this is not the only form of motivation Green Karma uses.

Green Karma also has an implemented a reward system that will let users redeem points for coupons and gift cards from participating companies. In addition, they will have the ability to earn badges which can be added to their profile and open the possibility for more redemption. This allows for companies such as Lyft and Spotify to come and offer special rewards for certain tasks, thus creating a more connected community that strives to help save the Earth.

## How I built it
I used the mobile framework Flutter to create a cross-platform app in order to reach everyone. I decided to use Firebase, a serverless backend service offered by Google Cloud, as the backend for my app. Firebase allowed for me to create secure authentication with email and password and provided me with a MongoDB. Here is a look of how the database architecture looks like.

The robust database allows for me to keep track of different networks and different connections among friends, posts, comments, etc. It allows for users to know which tasks they excel in and which they need to improve on. The database helps Green Karma become a true social network and is central to the app.

## Challenges I ran into
I ran into a lot of challenges with connecting the database to the frontend. I had to create a lot of classes to represent different things such as a post or a task and their respective model in the database. I had to store all the user profile data in the database and load it on the app startup. As you can see, there were a lot of challenges but I was able to overcome them in the end.

## Accomplishments that I'm proud of
I am very proud of what I have managed to create in the last four days and I have great ambitions for it. I was able to create a full-stack application within just four days. I am proud of the UI/UX which I had put a lot of thought into, including all the animations! 

## What I learned
I learned how to create applications using Flutter and how to connect them to backend services such as Firebase. I learned how to interact with databases and how my architecture should look like within them. In addition, I learned how to create UI/UXs which are pleasing to the user.

## What's next for Green Karma
I have great ambitions for it. I want to add even more features to Green Karma. For example, I want to integrate a Facebook connection so a user's circle can be more relevant to them and personalized. In addition to circles, I want to implement the concept of group tasks, which are tasks that multiple users can take on and attempt to complete for a great reward.
