## hurrycane: Evacuate diaster safely with seamless ride sharing.

## Inspiration

Our inspiration came from witnessing many college students in Tampa who were stranded without cars during the most recent hurricane. As a group familiar with the challenges of being carless, we saw firsthand how quickly a lack of transportation turns into a critical issue during disasters. This highlighted the urgent need for a community-driven solution that ensures everyone can evacuate safely, regardless of their access to a vehicle.

## What it does

hurrycane is a disaster evacuation ride-sharing app that connects people in need with volunteer drivers during emergencies. It groups users based on their location to find the quickest evacuation option with others nearby. The app leverages community support to ensure no one is left stranded during a crisis.

## How we built it

We built the application using SwiftUI for the front end with Apple's MapKit API and Go for the backend, which handles the ridesharing logic and ensures the scalability of our application. Additionally, we made calls to two databases: Firestore and MongoDB. Firestore is used for instantaneous client-side updates, while MongoDB enables efficient geospatial queries.

## Challenges we ran into

One of the biggest challenges was properly grouping people together reliably during high-stress situations. Ensuring the accuracy of real-time pick-up and location-based clusters was crucial for safety. We also had to design the app to be intuitive and easy to use in emergencies, particularly for those less tech-savvy, like the elderly.

## Accomplishments that we're proud of

We’re proud of creating a platform that can make a real difference in emergencies. Developing a seamless integration of accessibility features and building a system that matches drivers and evacuees in real time were major milestones. Most importantly, we’ve built something that can save lives and promote equity in disaster response.

## What we learned

We learned about the complexities of emergency logistics and the critical role of community-driven solutions. Our team deepened its understanding of accessibility needs and the importance of designing technology that works for everyone, especially during high-stress situations.

## What's next for hurrycane

Next, we plan to expand hurrycane to include partnerships with local governments and emergency services to enhance the app’s reach and reliability. We’ll also focus on refining our predictive algorithms for better grouping during different types of disasters, and we aim to launch in flood-prone areas before expanding to regions affected by wildfires, hurricanes, and other emergencies.
