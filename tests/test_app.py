import flask
import pytest
import app


@pytest.fixture(scope="module")
def hello_world_app():
    return flask.Flask(__name__)


def test_server_response(hello_world_app):
    expected_response = 'Hello Equal Experts'
    with hello_world_app.test_request_context():
        response = app.hello()
        assert response == expected_response
