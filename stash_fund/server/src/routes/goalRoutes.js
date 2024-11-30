// src/routes/goalRoutes.js
const express = require('express');
const { addGoal, getGoals, updateGoal, deleteGoal, updateSpentAmount} = require('../controller/goalController');


const router = express.Router();

// Add a new goal
router.post('/addGoal',  addGoal);

// Get all goals for the user
router.get('/getGoals/:userId', getGoals);

// Update a goal
router.post('/updateGoal', updateGoal);

// Delete a goal
router.delete('/deleteGoal', deleteGoal);

// spent towards goal
router.post('/spentGoal', updateSpentAmount);

module.exports = router;
