# Deploy Task Organizer to Railway

## Step 1: Create Railway Account
1. Go to https://railway.app
2. Click "Login" and sign up with GitHub
3. Authorize Railway to access your GitHub account

## Step 2: Create MySQL Database
1. In Railway dashboard, click "New Project"
2. Select "Provision MySQL"
3. Railway will create a MySQL database
4. Click on the MySQL service to view connection details

## Step 3: Push Code to GitHub
```bash
# Initialize git repository
git init
git add .
git commit -m "Initial commit - Task Organizer"

# Create repository on GitHub (via website)
# Then push to GitHub
git remote add origin https://github.com/YOUR-USERNAME/task-organizer.git
git branch -M main
git push -u origin main
```

## Step 4: Deploy to Railway
1. In Railway dashboard, click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose your task-organizer repository
4. Railway will automatically detect it's a Java Maven project

## Step 5: Connect Database & Set Environment Variables
1. Click on your deployed service
2. Go to "Variables" tab
3. Click "Add Reference" and select your MySQL database
4. Add these variables manually:
   ```
   DB_URL=jdbc:mysql://${{MySQL.MYSQL_HOST}}:${{MySQL.MYSQL_TCP_PORT}}/${{MySQL.MYSQL_DATABASE}}?useSSL=true&serverTimezone=UTC
   DB_USER=${{MySQL.MYSQL_USER}}
   DB_PASSWORD=${{MySQL.MYSQL_PASSWORD}}
   PORT=8080
   ```

## Step 6: Initialize Database Schema
1. Connect to Railway MySQL using provided credentials
2. Run the database schema SQL file to create tables
3. Or use Railway's MySQL console to execute your schema

## Step 7: Access Your Application
1. Go to "Settings" tab in your service
2. Click "Generate Domain" to get a public URL
3. Your app will be available at: https://your-app-name.railway.app/task-organizer

## Troubleshooting
- Check "Deployments" tab for build logs
- Check "Logs" tab for runtime errors
- Ensure database tables are created
- Verify environment variables are set correctly

## Local Development
To run locally:
```bash
mvn clean package
# Deploy WAR to local Tomcat
# Or use: mvn tomcat7:run
```

## Update Deployment
```bash
# Make changes
git add .
git commit -m "Update description"
git push

# Railway will automatically redeploy
```
