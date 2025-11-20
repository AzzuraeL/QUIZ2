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
**IMPORTANT: You MUST run this SQL to create the tables!**

### Option 1: Using Railway Web Console (Easiest)
1. In Railway dashboard, click on your **MySQL** service
2. Click the "Data" tab
3. Click "Query" or open the query console
4. Copy and paste the entire contents of `railway-setup.sql`
5. Click "Run" or press Ctrl+Enter
6. You should see: "Tables created successfully!"

### Option 2: Using MySQL Client
```bash
# Get connection details from Railway MySQL service
# Connect using the command provided in Railway dashboard
mysql -h [HOST] -P [PORT] -u [USER] -p[PASSWORD] railway < railway-setup.sql
```

### Option 3: Using DBeaver/MySQL Workbench
1. Get connection details from Railway MySQL Variables tab
2. Create new connection with Railway credentials
3. Connect to the `railway` database
4. Open and execute `railway-setup.sql`

**Verify Tables Created:**
```sql
SHOW TABLES;
-- Should show: users, tasks
```

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
