import {Pool} from 'pg';

const pool = new Pool({
    user: 'postgres',
    password: 'postgres',
    host: 'localhost',
    port: 5432,
    database: 'chatrifydb'
})

export default pool;