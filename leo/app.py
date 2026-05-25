# Updated for assignment progress
# LEO Flask Application
from flask import Flask
from flask import render_template
from flask import request
from flask import redirect
from flask import url_for
from flask import flash
import db
import connect
from datetime import datetime


app = Flask(__name__)
app.secret_key = 'leo_secret_2026'  # Set a secret key for session/flash

# Initialize database connection
db.init_db(
    app, connect.dbuser, connect.dbpass, connect.dbhost, connect.dbname, connect.dbport
)


@app.route("/")
def home():
    return render_template("home.html")


@app.route("/members", methods=["GET"])
def members_list():
    cursor = db.get_cursor()
    # List all members        
    querystr = "SELECT member_id, first_name, last_name FROM members;" 
    cursor.execute(querystr)        
    members = cursor.fetchall()
    cursor.close()
    if True:  # Example condition for a flash message
        flash("Example of a flash message. Optional, but good for error or confirmation " \
            "messages when used with an IF statement.", "info")
    return render_template("members_list.html", members=members)


@app.route("/observations")
def observation_list():
    # Add your code here to list observations
    return render_template("observations_list.html")


# Add other routes and view functions as required.

# Add other routes and view functions as required.

if __name__ == "__main__":
    app.run(debug=True)
    
