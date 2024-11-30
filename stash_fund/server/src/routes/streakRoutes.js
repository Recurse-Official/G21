// src/routes/streakRoutes.js
const express = require('express');
const { getOrCreateStreak, updateStreak, resetStreak } = require('../controller/streakController');

const router = express.Router();

// Route to get or create a user's streak
router.get('/:userId', getOrCreateStreak);

// Route to update a user's streak
router.put('/:userId', updateStreak);

// Route to reset a user's streak
router.put('/:userId/reset', resetStreak);

module.exports = router;
