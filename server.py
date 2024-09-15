from flask import Flask, render_template, request, redirect, url_for, session, flash
from database.db import get_db, init_db
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'supersecretkey' 

# Inicializa la base de datos
#init_db()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        name_user = request.form['name_user']
        name = request.form['name']
        email = request.form['email']
        password = generate_password_hash(request.form['password'])
        creation_date = datetime.now().strftime('%Y-%m-%d')

        db = get_db()
        cursor = db.cursor()
        cursor.execute('INSERT INTO users (name_user, name, password, email, creation_date) VALUES (%s, %s, %s, %s, %s)',
                       (name_user, name, password, email, creation_date))
        db.commit()
        flash('User registered successfully')
        return redirect(url_for('dashboard'))
    
    return render_template('register.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        name_user = request.form['name_user']
        password = request.form['password']

        db = get_db()
        cursor = db.cursor()
        cursor.execute('SELECT * FROM users WHERE name_user = %s', (name_user,))
        user = cursor.fetchone()        

        if user and check_password_hash(user["password"], password):
            session['user_id'] = user["id"]
            session['name_user'] = user["name_user"]
            session['name'] = user["name"]
            return redirect(url_for('dashboard'))
        else:
            flash('Invalid credentials')
    
    return render_template('login.html')

@app.route('/dashboard')
def dashboard():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    db = get_db()
    cursor = db.cursor()
    cursor.execute('SELECT * FROM activities_day WHERE id_user = %s', (session['user_id'],))
    activities = cursor.fetchall()
    return render_template('dashboard.html', activities=activities)

@app.route('/add_task_form')
def add_task_form():
    if 'user_id' not in session:
        return redirect(url_for('login'))
    return render_template('add_task.html')

@app.route('/add_task', methods=['POST'])
def add_task():
    if 'user_id' not in session:
        return redirect(url_for('login'))

    name_task = request.form['name_task']
    activitie_date = request.form['activitie_date']

    db = get_db()
    cursor = db.cursor()
    cursor.execute('INSERT INTO activities_day (id_user, name_task, activitie_date) VALUES (%s, %s, %s)',
                   (session['user_id'], name_task, activitie_date))
    db.commit()
    return redirect(url_for('dashboard'))

@app.route('/edit_task_form/<int:task_id>')
def edit_task_form(task_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    db = get_db()
    cursor = db.cursor()
    cursor.execute('SELECT * FROM activities_day WHERE id = %s', (task_id,))
    task = cursor.fetchone()
    return render_template('edit_task.html', task=task)

# Ruta para editar una tarea existente
@app.route('/edit_task/<int:task_id>', methods=['POST'])
def edit_task(task_id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    name_task = request.form['name_task']
    activitie_date = request.form['activitie_date']

    db = get_db()
    cursor = db.cursor()
    cursor.execute('UPDATE activities_day SET name_task = %s, activitie_date = %s WHERE id = %s',
                   (name_task, activitie_date, task_id))
    db.commit()
    return redirect(url_for('dashboard'))

@app.route('/delete_task/<int:id>', methods=['POST'])
def delete_task(id):
    if 'user_id' not in session:
        return redirect(url_for('login'))

    db = get_db()
    cursor = db.cursor()
    cursor.execute('DELETE FROM activities_day WHERE id = %s AND id_user = %s', (id, session['user_id']))
    db.commit()
    return redirect(url_for('dashboard'))

@app.route('/logout')
def logout():
    session.pop('user_id', None)
    session.pop('name_user', None)
    return redirect(url_for('index'))
     
if __name__ == "__main__":    
    host = "127.0.0.1"
    port = 8000
    app.run(host, port, True)