require('dotenv').config(); // Load environment variables
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
// const morgan = require('morgan');

// Import Routes
// const userRoutes = require('./src/routes/userRoutes');
const geminiRoutes = require('./src/routes/geminiRoutes');
const authRoutes = require('./src/routes/authRoutes');
const streakRoutes = require('./src/routes/streakRoutes');

// Initialize Express App
const app = express();

// Middleware
app.use(express.json()); // Parse JSON bodies
app.use(cors()); // Enable Cross-Origin Resource Sharing
// app.use(morgan('dev')); // Log HTTP requests in dev mode

// Routes
// app.use('/api/users', userRoutes); // User authentication routes
app.use('/api/gemini', geminiRoutes); // Financial goal routes
app.use('/api/auth', authRoutes); // Financial goal routes
app.use('/api/streak', streakRoutes); // Financial goal routes

// Database Connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log('Connected to MongoDB'))
  .catch((error) => console.error('Database connection error:', error));

// Start Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
