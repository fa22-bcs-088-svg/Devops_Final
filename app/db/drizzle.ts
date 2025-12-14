import { drizzle } from 'drizzle-orm/postgres-js';
import postgres from 'postgres';
import dotenv from 'dotenv';

dotenv.config();

// During build time, use a placeholder URL if DATABASE_URL is not set
// The actual connection will be established at runtime
const databaseUrl = process.env.DATABASE_URL || 'postgresql://placeholder:placeholder@localhost:5432/placeholder';

if (!process.env.DATABASE_URL && process.env.NODE_ENV === 'production') {
  console.warn('⚠️ DATABASE_URL not set, using placeholder. Make sure to set it at runtime.');
}

export const client = postgres(databaseUrl);
export const db = drizzle(client);
