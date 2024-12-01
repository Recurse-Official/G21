const Goal = require('../models/goal');

// Add a new goal
const addGoal = async (req, res) => {
  try {
    const { type, targetAmount, userId } = req.body;

    // Check if the goal already exists for the user
    const existingGoal = await Goal.findOne({ type, userId });
    if (existingGoal) {
      return res.status(400).json({ message: 'Goal already exists for this category.' });
    }

    const goal = new Goal({
      type,
      targetAmount,
      userId,
    });

    await goal.save();
    res.status(201).json({ message: 'Goal added successfully', goal });
  } catch (error) {
    res.status(500).json({ message: 'Error adding goal', error: error.message });
  }
};

// Get all goals for the user
const getGoals = async (req, res) => {
  try {
    const { userId } = req.params;
    const goals = await Goal.find({ userId });

    if (!goals.length) {
      return res.status(404).json({ message: 'No goals found for the user.' });
    }

    res.status(200).json(goals);
  } catch (error) {
    res.status(500).json({ message: 'Error fetching goals', error: error.message });
  }
};

// Update the spent amount for a goal
const updateSpentAmount = async (req, res) => {
  try {
    const { type, spentAmount, userId } = req.body;

    const goal = await Goal.findOneAndUpdate(
      { type, userId },
      { $inc: { spentAmount } },
      { new: true } // Return the updated document
    );

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found for this category and user.' });
    }

    res.status(200).json({ message: 'Spent amount updated successfully', goal });
  } catch (error) {
    res.status(500).json({ message: 'Error updating spent amount', error: error.message });
  }
};

// Update a goal's target amount
const updateGoal = async (req, res) => {
  try {
    const { type, targetAmount, userId } = req.body;

    const goal = await Goal.findOneAndUpdate(
      { type, userId },
      { targetAmount },
      { new: true } // Return the updated document
    );

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found for this category and user.' });
    }

    res.status(200).json({ message: 'Target amount updated successfully', goal });
  } catch (error) {
    res.status(500).json({ message: 'Error updating goal', error: error.message });
  }
};

// Delete a goal
const deleteGoal = async (req, res) => {
  try {
    const { userId, type } = req.body;

    const goal = await Goal.findOneAndDelete({ userId, type });

    if (!goal) {
      return res.status(404).json({ message: 'Goal not found for this category and user.' });
    }

    res.status(200).json({ message: 'Goal deleted successfully', deletedGoal: goal });
  } catch (error) {
    res.status(500).json({ message: 'Error deleting goal', error: error.message });
  }
};

module.exports = { addGoal, getGoals, updateSpentAmount, updateGoal, deleteGoal };
