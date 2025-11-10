# IMPORTANTE: monkey_patch DEBE ser lo primero
import eventlet
eventlet.monkey_patch()

import uuid
import time
import concurrent.futures
from queue import Queue
import threading
import random

# Ahora importar Cassandra
try:
    from cassandra.io.eventletreactor import EventletConnection
    from cassandra.cluster import Cluster
    print("✓ Usando EventletConnection")
except ImportError as e:
    print(f"Error con eventlet: {e}")
    exit(1)

import mysql.connector

class MySQLConnectionPool:
    def __init__(self, pool_size=10):
        self.pool_size = pool_size
        self.pool = Queue(maxsize=pool_size)
        self.lock = threading.Lock()
        
        for _ in range(pool_size):
            conn = mysql.connector.connect(
                host='localhost',
                user='root',
                password='root',
                database='killrvideo',
                port=3307
            )
            self.pool.put(conn)
    
    def get_connection(self):
        return self.pool.get()
    
    def return_connection(self, conn):
        self.pool.put(conn)
    
    def close_all(self):
        while not self.pool.empty():
            conn = self.pool.get()
            conn.close()

def test_parallel_cassandra():
    print("\nIniciando test Cassandra ...")
    cluster = Cluster(['localhost'], port=9042)
    session = cluster.connect('killrvideo')
    
    prepared_query = session.prepare("SELECT * FROM user_videos WHERE userid = ? LIMIT 1")
    userids = [
        uuid.UUID("11111111-1111-1111-1111-111111111111"),
        uuid.UUID("22222222-2222-2222-2222-222222222222"),
        uuid.UUID("33333333-3333-3333-3333-333333333333"),
        uuid.UUID("44444444-4444-4444-4444-444444444444")
    ]
    
    def query():
        userid = random.choice(userids)
        rows = session.execute(prepared_query, [userid])
        return list(rows)
    
    print("  Calentando Cassandra...")
    for _ in range(10):
        query()
    
    print("  Ejecutando benchmark...")
    start = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=50) as executor:
        futures = [executor.submit(query) for _ in range(1000)]
        completed = 0
        for future in concurrent.futures.as_completed(futures):
            _ = future.result()
            completed += 1
            if completed % 100 == 0:
                print(f"  Progreso Cassandra: {completed}/1000")
    
    total_time = time.time() - start
    cluster.shutdown()
    
    return 1000 / total_time

def test_parallel_mysql():
    print("\nIniciando test MySQL...")
    
    pool = MySQLConnectionPool(pool_size=50)
    
    userids = [
        "d0f60aa8-54a9-4840-b70c-fe562b68842b",
        "522b1fe2-2e36-4cef-a667-cd4237d08b89",
        "9761d3d7-7fbd-4269-9988-6cfd4e188678"
    ]
    
    def query():
        conn = pool.get_connection()
        try:
            cursor = conn.cursor()
            userid = random.choice(userids)
            cursor.execute("SELECT * FROM user_videos WHERE userid = %s LIMIT 1", (userid,))
            result = cursor.fetchall()
            cursor.close()
            return result
        finally:
            pool.return_connection(conn)
    
    print("  Calentando MySQL...")
    for _ in range(10):
        query()
    
    print("  Ejecutando benchmark...")
    start = time.time()
    with concurrent.futures.ThreadPoolExecutor(max_workers=50) as executor:
        futures = [executor.submit(query) for _ in range(1000)]
        completed = 0
        for future in concurrent.futures.as_completed(futures):
            _ = future.result()
            completed += 1
            if completed % 100 == 0:
                print(f"  Progreso MySQL: {completed}/1000")
    
    total_time = time.time() - start
    pool.close_all()
    
    return 1000 / total_time

if __name__ == '__main__':
    print("\n" + "="*60)
    print("|| BENCHMARK: Test con 50 conexiones paralelas ||")
    print("="*60)
    print("Ejecutando 1000 queries en paralelo por cada base de datos")
    print("Usando connection pooling en ambos sistemas\n")
    
    try:
        cass_qps = test_parallel_cassandra()
        print(f"\n|| Cassandra (3 nodos): {cass_qps:.0f} queries/sec ||")
    except Exception as e:
        print(f"\nError en Cassandra: {e}")
        import traceback
        traceback.print_exc()
        cass_qps = 0
    
    try:
        mysql_qps = test_parallel_mysql()
        print(f"\n|| MySQL (1 nodo): {mysql_qps:.0f} queries/sec ||")
    except Exception as e:
        print(f"\nError en MySQL: {e}")
        import traceback
        traceback.print_exc()
        mysql_qps = 0
    
    if cass_qps > 0 and mysql_qps > 0:
        print("\n" + "="*60)
        print("RESULTADO:")
        print("="*60)
        if cass_qps > mysql_qps:
            speedup = cass_qps / mysql_qps
            print(f"Cassandra es {speedup:.2f}x MÁS RÁPIDO que MySQL")
            print(f"   Cassandra: {cass_qps:.0f} q/s")
            print(f"   MySQL: {mysql_qps:.0f} q/s")
        else:
            speedup = mysql_qps / cass_qps
            print(f"MySQL es {speedup:.2f}x más rápido que Cassandra")
            print(f"   MySQL: {mysql_qps:.0f} q/s")
            print(f"   Cassandra: {cass_qps:.0f} q/s")
        print("="*60 + "\n")
