import {
  pgTable,
  serial,
  varchar,
  boolean,
  timestamp,
} from 'drizzle-orm/pg-core';

export const todos = pgTable('todos', {
  id: serial('id').primaryKey(),
  content: varchar('content', { length: 255 }).notNull(),
  completed: boolean('completed').default(false),
  createdAt: timestamp('created_at').defaultNow(),
});

export const feedback = pgTable('feedback', {
  id: serial('id').primaryKey(),
  name: varchar('name', { length: 255 }).notNull(),
  comment: varchar('comment', { length: 1000 }).notNull(),
  createdAt: timestamp('created_at').defaultNow(),
});
