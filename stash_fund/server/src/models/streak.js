// src/models/streakModel.js
const mongoose = require('mongoose');

const streakSchema = new mongoose.Schema({
    userId: {
        type: String,
        required: true,
    },
    maxStreak: {
        type: Number,
        default: 0,
    },
    currentStreak: {
        type: Number,
        default: 0,
    },
    dateOfLastStreak: {
        type: Date,
        default: null,
    },
});

const Streak = mongoose.model('Streak', streakSchema);

module.exports = Streak;
