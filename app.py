from flask import Flask, jsonify
import os
import pymysql

app = Flask(__name__)

# Read RDS connection details from environment variables
DB_HOST = os.getenv("DB_HOST", "localhost")
DB_USER = os.getenv("DB_USER", "admin")
DB_PASS = os.getenv("DB_PASS", "ChangeMe123!")
DB_NAME = os.getenv("DB_NAME", "appdb")

@app.route('/')
def home():
    return "🚀 Hello from Flask App running on AWS with Terraform + CodePipeline!"

@app.route('/health')
def health():
    return jsonify({"status": "healthy"})

@app.route('/db-check')
def db_check():
    try:
        conn = pymysql.connect(
            host=DB_HOST,
            user=DB_USER,
            password=DB_PASS,
            database=DB_NAME,
            connect_timeout=3
        )
        conn.close()
        return jsonify({"db_connection": "success"})
    except Exception as e:
        return jsonify({"db_connection": "failed", "error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
