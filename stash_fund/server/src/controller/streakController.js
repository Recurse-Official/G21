// src/controllers/streakController.js
const Streak = require('../models/streak');

// Create or Get Streak for a User
const getOrCreateStreak = async (req, res) => {
    const { userId } = req.params;

    try {
        let streak = await Streak.findOne({ userId });

        if (!streak) {
            // Create new streak if it doesn't exist
            streak = await Streak.create({ userId });
        }

        res.status(200).json(streak);
    } catch (error) {
        res.status(500).json({ message: 'Error retrieving or creating streak', error });
    }
};

// Update Streak for a User
const updateStreak = async (req, res) => {
    const { userId } = req.params;

    try {
        let streak = await Streak.findOne({ userId });

        if (!streak) {
            return res.status(404).json({ message: 'Streak not found for this user' });
        }

        const today = new Date().setHours(0, 0, 0, 0);
        const lastStreakDate = streak.dateOfLastStreak ? new Date(streak.dateOfLastStreak).setHours(0, 0, 0, 0) : null;

        if (lastStreakDate === today) {
            return res.status(200).json({ message: 'Streak already updated today', streak });
        } else if (lastStreakDate === today - 24 * 60 * 60 * 1000) {
            // Continuing the streak
            streak.currentStreak += 1;
        } else {
            // Streak reset
            streak.currentStreak = 1;
        }

        // Update max streak if needed
        if (streak.currentStreak > streak.maxStreak) {
            streak.maxStreak = streak.currentStreak;
        }

        streak.dateOfLastStreak = new Date();

        await streak.save();

        res.status(200).json(streak);
    } catch (error) {
        res.status(500).json({ message: 'Error updating streak', error });
    }
};

// Reset Streak for a User
const resetStreak = async (req, res) => {
    const { userId } = req.params;

    try {
        let streak = await Streak.findOne({ userId });

        if (!streak) {
            return res.status(404).json({ message: 'Streak not found for this user' });
        }

        streak.currentStreak = 0;
        streak.dateOfLastStreak = null;

        await streak.save();

        res.status(200).json(streak);
    } catch (error) {
        res.status(500).json({ message: 'Error resetting streak', error });
    }
};

module.exports = {
    getOrCreateStreak,
    updateStreak,
    resetStreak,
};
