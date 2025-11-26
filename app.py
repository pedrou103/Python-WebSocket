from flask import Flask, render_template
from flask_socketio import SocketIO, emit
import os

app = Flask(__name__)

socketio = SocketIO(app)


@app.route('/')
def index():
    return render_template('index.html')


@socketio.on('message')
def handle_message(data):
    emit('message', data, broadcast=True)

@socketio.on("typing")
def handle_typing(user):
    emit("typing", user, broadcast=True, include_self=False)



if __name__ == '__main__':
    # socketio.run(app, debug=True)
    port = int(os.environ.get("PORT", 5000))
    socketio.run(app, debug=True, host="0.0.0.0", port=port)