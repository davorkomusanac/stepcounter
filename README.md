# stepcounter

I have tried to be as much as possible faithful to the specified design. There were some instances which were left unclear to me (e.g. Circular and Linear Progress Indicators), so I had to take some liberty and make my own design choices based on what I thought would be the best user flow.

I tried to efficiently document code and explain the thoughts behind my tehnical decisions. I am aware that the solution might not be ideal, there are some caveats, however I focused foremostly to fulfill the User Stories while trying to not be behind the deadline.

For Steps Synchronization I checked the [Health plugin](https://pub.dev/packages/health) on [pub.dev](https://pub.dev/) and decided to create a mock api based on it.

As requested, Bloc was used over Cubits for state management, and in some cases I also used Hydrated Bloc (for storing daily goals) for better UX.

For the reminder at 8pm if the user did not achieve his goal, I used local notifications as requested, without using any push service, although it came with several tehnical caveats (if it were for production release), but it works for the development purposes.

https://user-images.githubusercontent.com/53110486/215367256-c0fb90e0-3362-4f87-b0f9-32ce33a56636.mp4

https://user-images.githubusercontent.com/53110486/215367269-dfc84ed3-e254-45ba-bfdf-2c4685ec3a2c.mp4
