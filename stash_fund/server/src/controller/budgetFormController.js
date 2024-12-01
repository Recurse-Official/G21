// controllers/budgetFormController.js
const BudgetFormModel = require('../models/budgetFormModel');

const handleBudgetFormSubmission = async (req, res) => {
  try {
    const {
      userId,
      gender,
      savingGoal,
      regularExpenses,
      unexpectedExpenses,
      dailyTravelExpenses,
      weeklyCoffeeExpenses,
      foodHabits,
      currentBill,
      weight,
      height,
      age,
      financialFeelings,
      spendingOnOthers,
      livingConditions,
      hasDebts,
      stressFreeBudgetItems,
    } = req.body;

    // Validate required fields
    if (!userId || !gender || !savingGoal || !dailyTravelExpenses || !weeklyCoffeeExpenses) {
      return res.status(400).json({ error: 'Some required fields are missing' });
    }

    // Save form data to the database
    const newBudgetForm = new BudgetFormModel({
      userId,
      gender,
      savingGoal,
      regularExpenses,
      unexpectedExpenses,
      dailyTravelExpenses,
      weeklyCoffeeExpenses,
      foodHabits,
      currentBill,
      weight,
      height,
      age,
      financialFeelings,
      spendingOnOthers,
      livingConditions,
      hasDebts,
      stressFreeBudgetItems,
    });

    await newBudgetForm.save();

    res.status(201).json({ message: 'Form submitted successfully!' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'An error occurred while processing the form submission' });
  }
};
const getBudgetFormData = async (req, res) => {
    const { userId } = req.params;
  
    try {
      // Fetch form submissions for the given userId
      const formData = await BudgetFormModel.find({ userId });
  
      if (!formData || formData.length === 0) {
        return res.status(404).json({ error: 'No form data found for this user.' });
      }
  
      res.status(200).json(formData);
    } catch (error) {
      console.error(error);
      res.status(500).json({ error: 'An error occurred while fetching the form data.' });
    }
  };
module.exports = { handleBudgetFormSubmission ,getBudgetFormData };
