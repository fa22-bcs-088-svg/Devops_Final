import { db } from '@/app/db/drizzle';
import { feedback } from '@/app/db/schema';
import { desc } from 'drizzle-orm';
import { NextRequest, NextResponse } from 'next/server';

// GET: Fetch all feedback
export async function GET() {
  try {
    const allFeedback = await db
      .select()
      .from(feedback)
      .orderBy(desc(feedback.createdAt));

    return NextResponse.json(allFeedback, { status: 200 });
  } catch (error) {
    console.error('Error fetching feedback:', error);
    return NextResponse.json(
      { error: 'Failed to fetch feedback' },
      { status: 500 }
    );
  }
}

// POST: Save new feedback
export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const { name, comment } = body;

    // Validate input
    if (!name || !comment) {
      return NextResponse.json(
        { error: 'Name and comment are required' },
        { status: 400 }
      );
    }

    // Insert into database
    const result = await db
      .insert(feedback)
      .values({
        name: name.trim(),
        comment: comment.trim(),
      })
      .returning();

    return NextResponse.json(
      { message: 'Feedback saved successfully', data: result[0] },
      { status: 201 }
    );
  } catch (error) {
    console.error('Error saving feedback:', error);
    return NextResponse.json(
      { error: 'Failed to save feedback' },
      { status: 500 }
    );
  }
}
