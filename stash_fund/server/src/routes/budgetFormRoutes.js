// routes/budgetFormRoutes.js
const express = require('express');
const { handleBudgetFormSubmission, getBudgetFormData } = require('../controller/budgetFormController');

const router = express.Router();

// POST route for form submission
router.post('/submit', handleBudgetFormSubmission);

router.get('/:userId', getBudgetFormData);
module.exports = router;
