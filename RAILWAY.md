# Containerized Deployment Reflection

> **Note:** Rename this file to match the service you used (e.g., `FLY.md`, `RENDER.md`, `RAILWAY.md`).

**Service Used:** Railway 
**Team Members:** Ethan/Jack

---

## 1. Deployment Process Overview

Railway was a little more confusing to deploy. It was not hard to connect the repo and get deployed with the Dockerfiles, but the hard part was getting the app to run correctly once we had it up. We connected our GitHub to Railway and deployed our app, but we were having trouble ensuring all of our environment variables were correct and that our Google Oauth would allow us to pass through the log-in page into the app. We eventually switched the AUTH_URL to the Railway URL which allowed it to redirect to the right page.   


---

## 2. Pros and Cons

Based on your hands-on experience with this platform, what are its strengths and limitations
compared to a platform-as-a-service like Vercel?

  | Pros | Cons |
   |---|---|
   | Decently easy to deploy | Not super easy to troubleshoot |
   | Has a nice UI/UX | Didn't automatically create domain |
   | Good for small projects like this w/Docker |  |
   
---

## 3. Challenges and Surprises

I came in thinking it was going to be harder to deploy, but it was actually just harder to get connected with the external services. It was able to read the Dockerfiles and get it deployed very easily. The hardest part was once again ensuring I had the Google Oauth connections right. We were having trouble getting the app working, but with enough troubleshooting we realized we needed to chnage our AUTH_URL to the Railway domain instead of localhost. Other than that, it went pretty smooth.   