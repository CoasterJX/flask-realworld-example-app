from conduit.app import create_app
from conduit.extensions import db
from conduit.settings import ProdConfig
import os

# Ensure we use a writable path for SQLite
os.environ['DATABASE_URL'] = 'sqlite:////tmp/conduit.db'

app = create_app(ProdConfig)
with app.app_context():
    db.create_all()
    print("Database tables created successfully.")
