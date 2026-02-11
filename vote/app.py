from flask import Flask, render_template, request, make_response, g
from redis import Redis
import os
import socket
import random
import json
import logging

# Configuración desde variables de entorno
option_a = os.getenv('OPTION_A', "Cats")
option_b = os.getenv('OPTION_B', "Dogs")
redis_host = os.getenv('REDIS_HOST', 'redis')
redis_port = int(os.getenv('REDIS_PORT', 6379))
hostname = socket.gethostname()

app = Flask(__name__)

# Configuración de logging para Gunicorn + Flask
gunicorn_error_logger = logging.getLogger('gunicorn.error')
app.logger.handlers.extend(gunicorn_error_logger.handlers)
app.logger.setLevel(logging.INFO)

def get_redis():
    if not hasattr(g, 'redis'):
        g.redis = Redis(
            host=redis_host,
            port=redis_port,
            db=0,
            socket_timeout=5,
            socket_connect_timeout=5,
            retry_on_timeout=True,
            health_check_interval=30
        )
    return g.redis

@app.route("/", methods=['GET', 'POST'])
@app.route("/vote", methods=['GET', 'POST'])
def hello():
    voter_id = request.cookies.get('voter_id')
    if not voter_id:
        voter_id = hex(random.getrandbits(64))[2:]

    vote = None

    if request.method == 'POST':
        redis = get_redis()
        vote = request.form.get('vote')

        app.logger.info('POST recibido - voter_id: %s | vote: %s', voter_id, vote)

        if vote is None:
            app.logger.warning('No se encontró el campo "vote" en el formulario')
        else:
            # Formato JSON que espera el Worker
            data = json.dumps({
                'voter_id': voter_id,
                'vote': vote
            })

            try:
                redis.rpush('votes', data)
                app.logger.info('Voto "%s" guardado en la cola "votes"', vote)
            except Exception as e:
                app.logger.error('Error al guardar en la cola "votes": %s', str(e))

    resp = make_response(render_template(
        'index.html',
        option_a=option_a,
        option_b=option_b,
        hostname=hostname,
        vote=vote,
    ))

    resp.set_cookie('voter_id', voter_id, max_age=60*60*24*365)  # 1 año, para que persista
    return resp


if __name__ == "__main__":
    app.run(
        host='0.0.0.0',
        port=int(os.getenv('PORT', 80)),
        debug=True,
        threaded=True
    )