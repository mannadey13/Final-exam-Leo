# Progress update push test
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


@app.route("/members")
def members_list():

    connection = db.get_db()
    cursor = connection.cursor()

    querystr = """
    SELECT
        member_id,
        first_name,
        last_name,
        email,
        phone
    FROM members
    ORDER BY member_id ASC;
    """

    cursor.execute(querystr)

    members = cursor.fetchall()

    cursor.close()

    return render_template(
        "members_list.html",
        members=members
    )


@app.route("/observations")
def observation_list():
    connection = db.get_db()
    cursor = connection.cursor()
    
    querystr = """
    SELECT 
        members.first_name,
        insects.insect_name,
        locations.location_name,
        observations.observation_date

    FROM observations

    JOIN members
    ON observations.member_id = members.member_id

    JOIN insects
    ON observations.insect_id = insects.insect_id

    JOIN locations
    ON observations.location_id = locations.location_id

    ORDER BY observations.observation_date DESC;
   """
    cursor.execute(querystr)
    observations = cursor.fetchall()
    cursor.close()
    return render_template(
        "observation_list.html",
        observations=observations
    )
    
@app.route("/add_member", methods=["GET", "POST"])
def add_member():

    if request.method == "POST":

        first_name = request.form.get("first_name")
        last_name = request.form.get("last_name")
        email = request.form.get("email")
        phone = request.form.get("phone")

        connection = db.get_db()
        cursor = connection.cursor()

        querystr = """
        INSERT INTO members
        (first_name, last_name, email, phone)
        VALUES (%s, %s, %s, %s);
        """

        cursor.execute(querystr, (
            first_name,
            last_name,
            email,
            phone
        ))

        connection.commit()

        cursor.close()

        flash("Member added successfully!", "success")

        return redirect(url_for("members_list"))

    return render_template("add_member.html")

# Add other routes and view functions as required.

# Add other routes and view functions as required.

if __name__ == "__main__":
    app.run(debug=True)
    
