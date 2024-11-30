// controllers/geminiController.js
const { generateContent } = require('../services/geminiService');

const getGeneratedContent = async (req, res) => {
  const { prompt } = req.body;
  console.log("prompt in controller "+prompt);
  if (!prompt) {
    return res.status(400).json({ error: 'Prompt is required' });
  }
  try {
    const data = await generateContent(prompt);
    console.log(data);
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

module.exports = { getGeneratedContent };
